local in_arena = 0
local time_arena = 0
local openedCoords
local arenaCoords

local reasonDeath
local pedKiller
local Killer
local cooldown = 0
local cooldownBoard = 0
local morto = false
local voice = 2

AddEventHandler("marko_:collectGarbage", function()
	collectgarbage("collect")
end)


RegisterNetEvent("mirtin_survival:updateArena")
AddEventHandler("mirtin_survival:updateArena", function(boolean)
    -- print("updateArena: ", boolean)
    LocalPlayer.state:set("in_arena", boolean, true)
end)

RegisterNetEvent("arena:playSound", function(url)
    SendReactMessage("playSound", url)
end)

-- Comando para abrir a interface da arena manualmente
RegisterCommand("arena", function()
    if in_arena == 0 and not IN_PVP then
        local ped = PlayerPedId()
        if GetEntityHealth(ped) > 101 then
            local weapons = vRP.getWeapons()
            if json.encode(weapons) == '[]' then
                local coords = GetEntityCoords(ped)
                openedCoords = coords
                vSERVER._atualizarCoords(coords)
                openNui()
            else
                TriggerEvent('Notify', 'negado', 'Você não pode entrar com arma na arena.', 3000)
            end
        end
    end
end)


function giveAttachsToWeapon()
    local ped = PlayerPedId()
    local ok, hash = GetCurrentPedWeapon(ped)

    local components = Attachments[hash]

    for _, chash in ipairs(components or {}) do
        GiveWeaponComponentToPed(ped, hash, chash)
    end
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ARENA
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        local time = 1000

        if in_arena == 0 or not IN_PVP then
            local ped = PlayerPedId()
            local playercoords = GetEntityCoords(ped)
            local vida = GetEntityHealth(ped)

            for _,v in pairs(config.locArenas) do
                local distance = #(playercoords - v)
                if distance <= 5.0 and not battleroyale then
                    time = 5
                    config.drawMarker(v)
                    if distance <= 2.0 then
                        if IsControlJustPressed(0,38) and vida > 101 then

                            local Weapons = vRP.getWeapons()
                            local serializedWeaponss = json.encode(Weapons)
                            if serializedWeaponss == '[]' then
                                openedCoords = v
                                vSERVER._atualizarCoords(v)
                                openNui()
                            else
                                TriggerEvent('Notify', 'negado', 'Você não pode entrar com arma na arena.', 3000)
                            end
                        end
                    end
                end
            end
        end

        Citizen.Wait(time)
    end
end)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
src.setArena = function(id, coords)
    DoScreenFadeOut(1000)
    in_arena = parseInt(id)

    Citizen.Wait(1000)
    SetEntityCoords(PlayerPedId(), coords[1],coords[2],coords[3])
    arenaCoords = { coords[1],coords[2],coords[3] }
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.15)
    Citizen.Wait(1000)
    DoScreenFadeIn(1000)
    time_arena = vSERVER.getTimeArena(in_arena)
    toggleNuiFrame(false)

    -- Abrir a HUD conforme documentação
    openHud()
    
    -- Atualizar o timer
    SendStandardMessage("setTimer", time_arena)
    
    -- Verificar e atualizar informações do scoreboard
    local name, time, players = vSERVER.scoreBoard(in_arena)
    if name and players then
        updateTabInfo(name, time_arena, players)
    end
    
    -- Mostrar o tab inicialmente
    -- setTabVisibility(true)
    
    SendReactMessage("setInArena", true)

    async(function()
        while in_arena > 0 do
            time_arena = time_arena - 1

            if time_arena >= 0 then
                SendStandardMessage("setTimer", time_arena)
            end

            Citizen.Wait(1000)
        end
    end)
end

src.removePlayerArena = function()
    DoScreenFadeOut(1000)
    RemoveAllPedWeapons(PlayerPedId(),true)

    Wait(1000)
    in_arena = tonumber(0)
    closeAllNuis()

    Citizen.Wait(1000)
    SetEntityCoords(PlayerPedId(), openedCoords[1],openedCoords[2],openedCoords[3])
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)

    Citizen.Wait(1000)
    DoScreenFadeIn(1000)
    
    resetArenaState()
end

Citizen.CreateThread(function()
    while true do
        if in_arena > 0 then
            time_arena = vSERVER.getTimeArena(in_arena)
        end
        
        Citizen.Wait(60*1000)
    end
end)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- NUIS CALL BACKS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("closeNui", function(data, cb)
	-- closeNui()
    toggleNuiFrame(false)
end)

local leavingState = false
function leaveArena()
    if leavingState then
        TriggerEvent("Notify", "negado", "Você já está saindo da arena.")
        return
    end
    
    leavingState = true
    
    -- Force state update immediately 
    in_arena = 0
    LocalPlayer.state:set("in_arena", false, true)
    
    -- Call server
    vSERVER.playerLeavingArena()
    
    -- Prevent multiple leaving attempts
    SetTimeout(5000, function()
        leavingState = false
        
        -- Force refresh arenas list next time
        cachedArenas = nil
    end)
end

local isCapsLockPressed = false

Citizen.CreateThread(function()
    while true do
        local time = 1000
        -- print("in_arena: ", in_arena)
        if in_arena > 0 then
            time = 0
            if IsControlPressed(0, 52) then -- 0x14 é o código para a tecla Caps Lock
                isCapsLockPressed = true
                SendStandardMessage("hud:tabVisibled", true)
            elseif IsControlJustPressed(0,168) then
                vSERVER.playerLeavingArena()
            else
                if isCapsLockPressed then
                    isCapsLockPressed = false
                    SendReactMessage("hud:tabVisibled", false)
                end
            end
            DrawTextInScreen("~b~[F7] ~w~Sair da Arena",0,0.05,0.95,0.3,255,255,255,255)
        end
        Citizen.Wait(time)
    end
end)


Citizen.CreateThread(function()
    SetNuiFocus(false,false)
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS NUIS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local lastRankTableTime = 0
local rankData = {}
local cachedArenas = nil

function updateOnlinPlayers()
    local onlinePlayers = vSERVER.getOnlinePlayersForArenas()
    for k,v in pairs(cachedArenas) do
        v.actualPlayers = onlinePlayers[k] or v.actualPlayers
    end
end

function sendNuiInfos()
    updateOnlinPlayers()
    SendReactMessage("setList", cachedArenas)
    SendReactMessage("setRankInfo", rankData)
    Wait(100)
    toggleNuiFrame(true)
end

-- RegisterCommand("testeNui", function(source,args,rawCommand)
--     sendNuiInfos()
-- end)

-- Atualizar função openNui para usar o formato padrão documentado no readme
function openNui()
    local currentTime = GetGameTimer()
    
    cachedArenas = vSERVER.showNuiArena()
    
    if currentTime - lastRankTableTime >= 180000 then
        lastRankTableTime = currentTime
        rankData = vSERVER.CreateNewRankTable()
    end
    
    SendStandardMessage("lobby:open", {})
    SetNuiFocus(true, true)
end

function closeNui()
    SetNuiFocus(false, false)
    -- TransitionFromBlurred(1000)
    toggleNuiFrame(false)
end

function closeAllNuis()
    SetNuiFocus(false, false)
    -- TransitionFromBlurred(1000)
    toggleNuiFrame(false)
    SendReactMessage("setInArena", false)
    SendStandardMessage("tab:visibled", false)
    SendStandardMessage("close", false)
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CONTROLADOR DE KILLS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        local time = 1000

        if in_arena > 0  then
            local ped = PlayerPedId()
            local vida = GetEntityHealth(ped)
            local x,y,z = table.unpack(GetEntityCoords(ped,true))

            time = 300

            if IsEntityDead(ped) then
                time = 0
                if GetPedCauseOfDeath(ped) ~= 0 and cooldown == 0 then
                    cooldown = 2
                    if not morto then
                        reasonDeath = GetPedCauseOfDeath(ped)
                        pedKiller = GetPedSourceOfDeath(ped)
        
                        if IsEntityAPed(pedKiller) and IsPedAPlayer(pedKiller) then
                            Killer = NetworkGetPlayerIndexFromPed(pedKiller)
                        elseif IsEntityAVehicle(pedKiller) and IsEntityAPed(GetPedInVehicleSeat(pedKiller, -1)) and IsPedAPlayer(GetPedInVehicleSeat(pedKiller, -1)) then
                            Killer = NetworkGetPlayerIndexFromPed(GetPedInVehicleSeat(pedKiller, -1))
                        end
                        
                        sendToLog(PlayerId(), reasonDeath, Killer)
                    end
                end

                NetworkResurrectLocalPlayer(x,y,z,true,true, false)
                SetEntityHealth(ped, 101)
            end
			
			--  if vida <= 101 then
			-- 	time = 0
				
			-- 	NetworkResurrectLocalPlayer(x,y,z,true,true, false)
            --     print("Ressurect arena3")
			-- 	SetEntityHealth(ped, 101)
            --  end

            -- if vida <= 101 and not morto then
            --     morto = true
            --     print("Ressurect arena2")
            --     SetEntityHealth(ped, 101)
            -- end

            if  vida <= 101 and in_arena > 0 then
                NetworkResurrectLocalPlayer(x,y,z,true,true, false)
                time = 0
               -- print("Ressurect arena1")
                -- if vida <= 101 then
                --     SetPedToRagdoll(ped, 1500, 1500,0, 0, 0, 0)
                -- end
                
                -- config.drawTxt()
                -- if IsControlJustPressed(0, config.keys['spawn']) and morto then
                    morto = false
                    
                    Wait(1000)
                    --print("Ressurect coords1")
                    local coords,health = vSERVER.randomSpawn()
                    if coords then
                       -- print("Ressurect coords2")
                        SetEntityCoords(PlayerPedId(), coords[1],coords[2],coords[3])
                        SetEntityHealth(ped, health)
                        giveAttachsToWeapon()
                    end
                -- end
            end

            if arenaCoords ~= nil then
                local distance = #(GetEntityCoords(PlayerPedId()) - vec3(arenaCoords[1],arenaCoords[2],arenaCoords[3]))
                if distance >= config.rangeDistance then
                    SetEntityCoords(PlayerPedId(), arenaCoords[1],arenaCoords[2],arenaCoords[3])
                end
            end
        end
        
        Citizen.Wait(time)
    end
end)

sendToLog = function(idMorto, arma, quemMatou)
    local source = 0
    local ksource = 0

    if idMorto ~= 0 then
        source = GetPlayerServerId(idMorto)
    end

    if quemMatou ~= 0 then
        ksource = GetPlayerServerId(quemMatou)
    end
    
    if source then
        vSERVER.receberMorte(source, arma, ksource)
    end
end

-- Esta função já está implementada conforme a documentação
function src.sendChatKill(kName, nName, arma, delay)
    notifyKill(kName, nName)
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SCOREBOARD
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local pressionado = false

Citizen.CreateThread(function()
    while true do
        local time = 1000
        if in_arena > 0  then
            time = 5

            if IsControlPressed(0, config.keys['scoreboard']) then
                if not pressionado and cooldownBoard <= 0 then
                    cooldownBoard = 1
                    pressionado = true
                    
                    local name, time, players, remainingTime = vSERVER.scoreBoard(in_arena)
                    if name and players then
                        -- print("dados: ", json.encode(dados), "user_list: ", json.encode(user_list))
                        setTabVisibility(true)
                        updateTabInfo(name, remainingTime, players)
                        -- SendNUIMessage({ scoreboard = true, dados = dados, user_list = user_list })
                    end
                end
            else
                if pressionado then
                    pressionado = false
                    setTabVisibility(false)
                end
            end
        end

        Citizen.Wait(time)
    end
end)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CONTADOR
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        local time = 1000
        
        if cooldown > 0 then
            cooldown = cooldown - 1

            if cooldown <= 0 then
                cooldown = 0
            end
        end

        if cooldownBoard > 0 then
            cooldownBoard = cooldownBoard - 1

            if cooldownBoard <= 0 then
                cooldownBoard = 0
            end
        end

        Citizen.Wait(time)
    end
end)

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function drawTxt(text,font,x,y,scale,r,g,b,a)
    SetTextFont(font)
    SetTextScale(scale,scale)
    SetTextColour(r,g,b,a)
    SetTextOutline()
    SetTextCentre(1)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x,y)
end

function src.inArena()
    return in_arena > 0
end


RegisterNUICallback('vini:KillTable', function(data, cb)
	local tabela = vSERVER.CreateNewRankTable()
	cb(tabela)
end)


DrawTextInScreen = function(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end

-- Callbacks documentados no readme
RegisterNuiCallback("getItems", function(data, cb)
    local type = data.type
    if type == "arenas" then
        -- local arenas = vSERVER.getArenas() or cachedArenas or {}
        local arenas = vSERVER.getArenas()
        cb(arenas)
    elseif type == "ranking" then
        local ranking = vSERVER.CreateNewRankTable() or rankData or {}
        cb(ranking)
    end
end)

RegisterNuiCallback("updateItems", function(data, cb)
    local type = data.type
    if type == "arenas" then
        local arenas = vSERVER.getArenas() or cachedArenas or {}
        cb(arenas)
    elseif type == "ranking" then
        local ranking = vSERVER.CreateNewRankTable() or rankData or {}
        cb(ranking)
    end
end)

-- Este já existe, apenas garantindo que está implementado corretamente
RegisterNuiCallback("close", function(data, cb)
    closeAllNuis()
    SendStandardMessage("close", false)
    cb(true)
end)

-- Funções da HUD documentadas no readme
function openHud()
    SendStandardMessage("hud:open", true)
end

function startCounter(round)
    SendStandardMessage("startCounter", round)
end

RegisterNetEvent("pma-voice:setTalkingMode")
AddEventHandler("pma-voice:setTalkingMode", function(status)
    voice = status
end)

function updatePlayerInfo(distance, talking, health)
    SendStandardMessage("setInformations", {
        distance = voice,
        talking = talking,
        health = health
    })
end

function notifyKill(killer, victim)
    SendStandardMessage("notifyKill", {
        killer = killer,
        victim = victim
    })
end

function setTabVisibility(visible)
    SendStandardMessage("tab:visibled", visible)
end

function updateTabInfo(arenaName, timer, players)
    local formattedPlayers = {}
    
    for _, player in pairs(players or {}) do
        table.insert(formattedPlayers, {
            id = player.id,
            name = player.name,
            kills = player.kills,
            deaths = player.deaths or 0,
            alive = player.alive -- Por padrão, consideramos todos vivos
        })
    end
    
    SendStandardMessage("tab:update", {
        name = arenaName,
        timer = timer,
        players = formattedPlayers
    })
end

function updateTimer(time)
    SendStandardMessage("setTimer", time)
end

function updateWeapon(clip, image, current)
    SendStandardMessage("setWeapon", {
        clip = clip,
        image = image,
        current = current
    })
end

function updateItems(type)
    if type == "arenas" then
        SendStandardMessage("lobby:updateItems", getArenasFormattedData())
    elseif type == "ranking" then
        SendStandardMessage("lobby:updateItems", getRankingFormattedData())
    end
end

-- Implementar função para obter arenas no formato da documentação
-- Esta função deve ser chamada por RegisterNuiCallback("getItems")
function getArenasFormattedData()
    local arenas = vSERVER.getArenas() or cachedArenas or {}
    local formattedArenas = {}
    
    
    for _, arena in pairs(arenas) do
        local formattedArena = {
            id = arena.id,
            name = arena.nome,
            image = arena.imagem,
            time = formatTime(arena.tempo),
            weapon = arena.weaponDisplay,
            favorited = arena.favorited or false,
            players = {
                current = arena.actualPlayers or 0,
                max = arena.maxPlayers or 20
            }
        }
        table.insert(formattedArenas, formattedArena)
    end
    
    return formattedArenas
end

-- Função auxiliar para formatar o tempo (de segundos para "MM:SS")
function formatTime(seconds)
    if not seconds then return "00:00" end
    local minutes = math.floor(seconds / 60)
    local secs = seconds % 60
    return string.format("%02d:%02d", minutes, secs)
end

-- Implementar função para obter ranking no formato da documentação
function getRankingFormattedData()
    local ranking = vSERVER.CreateNewRankTable() or rankData or {}
    local formattedRanking = {}
    
    for position, player in ipairs(ranking) do
        local deaths = player.death or 0
        local kdr = deaths > 0 and math.floor((player.kills / deaths) * 100) / 100 or player.kills
        
        local formattedPlayer = {
            position = position,
            id = player.user_id,
            name = player.name .. " " .. (player.lastname or ""),
            kills = player.kills,
            deaths = deaths,
            kdr = kdr
        }
        table.insert(formattedRanking, formattedPlayer)
    end
    
    return formattedRanking
end

-- -- Atualizar os callbacks conforme a documentação
-- RegisterNuiCallback("getItems", function(data, cb)
--     local type = data.type
--     debugPrint("getItems callback called with type: " .. tostring(type))
    
--     if type == "arenas" then
--         local arenaData = getArenasFormattedData()
--         debugPrint("Returning arena data: " .. json.encode(arenaData))
--         cb(arenaData)
--     elseif type == "ranking" then
--         local rankingData = getRankingFormattedData()
--         debugPrint("Returning ranking data: " .. json.encode(rankingData))
--         cb(rankingData)
--     else
--         debugPrint("Unknown item type requested: " .. tostring(type))
--         cb({})
--     end
-- end)

RegisterNuiCallback("updateItems", function(data, cb)
    local type = data.type
    
    if type == "arenas" then
        local arenaData = getArenasFormattedData()
        cb(arenaData)
    elseif type == "ranking" then
        -- Atualizar cache de ranking
        rankData = vSERVER.CreateNewRankTable()
        local rankingData = getRankingFormattedData()
        cb(rankingData)
    else
        cb({})
    end
end)

local isJoiningArena = false

RegisterNuiCallback("joinMap", function(data, cb)
    if isJoiningArena then 
        cb(false)
        return
    end
    
    isJoiningArena = true
    
    if in_arena > 0 then
        TriggerEvent("Notify", "negado", "Você já está em uma arena. Saia antes de entrar em outra.")
        cb(false)
        isJoiningArena = false
        return
    end

    cachedArenas = vSERVER.showNuiArena()
    
    local arenaId = data.map.id
    local maxPlayers = data.map.players.max
    local onlinePlayers = vSERVER.getOnlinePlayersForArenas()
    
    if onlinePlayers[arenaId] and onlinePlayers[arenaId] >= maxPlayers then
        TriggerEvent("Notify", "negado", "Arena lotada! Tente novamente mais tarde.")
        cb(false)
        isJoiningArena = false
        return
    end
    
    local success = vSERVER.apostarArena(arenaId)
    isJoiningArena = false
    cb(success)
end)

RegisterNuiCallback("favoriteMap", function(data, cb)
    vSERVER.toggleFavoriteArena(data.map.id)
    cb(true)
end)

-- Implementar envio periódico de atualizações de informações do player
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)
        if in_arena > 0 then
            local ped = PlayerPedId()
            local rawHealth = GetEntityHealth(ped)
            local health = 0
            if rawHealth > 101 then
                -- Convert from game health (101-400) to percentage (0-100)
                health = math.floor(((rawHealth - 101) / 300) * 100)
                health = math.max(0, math.min(100, health)) -- Ensure value is between 0-100
            end
            local talking = NetworkIsPlayerTalking(PlayerId())
            
            updatePlayerInfo(3, talking, health)
        end
    end
end)

-- Adicionar thread para atualizar informações de arma
Citizen.CreateThread(function()
    while true do
        sleep = 500
        if in_arena > 0 then
            local ped = PlayerPedId()
            local _, weapon = GetCurrentPedWeapon(ped)
            
            if weapon and weapon ~= 0 then
                local amoutAmmo = GetAmmoInPedWeapon(ped, weapon)
                local _, ammo = GetAmmoInClip(ped, weapon) 
                local ammoInClip = amoutAmmo - ammo
                local weaponName = GetWeaponName(weapon)
                local url = "https://cache.nowayrp.uk/HUD_WEAPONS/" .. weaponName .. ".WEBP"
                
                updateWeapon(ammoInClip, url, ammo)
            end
            sleep = 5
        end
        Citizen.Wait(sleep)
    end
end)

function resetArenaState()
    in_arena = 0
    LocalPlayer.state:set("in_arena", false, true)
    arenaCoords = nil
    closeAllNuis()
end

Citizen.CreateThread(function()
    resetArenaState()
end)