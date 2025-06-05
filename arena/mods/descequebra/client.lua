-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
IN_PVP = false
local IN_PVP_ID = 0
local PLAYER_VEHICLE = 0
local CURRENT_TIME = 0
local ENTER_COORDS = vec3(0,0,0)

-----------------------------------------------------------------------------------------------------------------------------------------
-- EVENTS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('descequebra:spawn', function(id, time)
    NetworkSetFriendlyFireOption(true)
    SetCanAttackFriendly(PlayerPedId(),true,true)
    ENTER_COORDS = GetEntityCoords(PlayerPedId())

    local arena = config.arenas[id]
    if not arena or IN_PVP then
        return
    end

    local spawns = arena.coords
    local random = math.random(#spawns)

    local ped = PlayerPedId()
    currentWeapon = arena.arma

    local x,y,z = spawns[random].x, spawns[random].y, spawns[random].z
    RequestCollisionAtCoord(x,y,z)
    while not HasCollisionLoadedAroundEntity(ped) do
        RequestCollisionAtCoord(x,y,z)
        Citizen.Wait(1)
    end
    SetEntityHealth(ped, GetPedMaxHealth(ped))
    SetEntityCoords(ped, x,y,z)

    -- FORÇAR TIRAR DO LIMBO
    CreateThread(function()
        local timeout = 3
        local x,y,z = x,y,z
        while timeout > 0 do
            timeout = timeout - 1
            RequestCollisionAtCoord(x,y,z)
            
            local dist = #(GetEntityCoords(ped) - vector3(x,y,z))
            if dist > 10 then
                SetEntityCoords(ped, x,y,z)
            end

            Wait(1000)
        end
    end)

    --GiveWeaponToPed(ped,GetHashKey(currentWeapon),250,true)
    SetCurrentPedWeapon(ped, GetHashKey(currentWeapon), true)

    SendReactMessage("setInArena", true)

    IN_PVP = true
    IN_PVP_ID = id
    CURRENT_TIME = time

    createVehicle(GetHashKey(arena.vehicle))

    CreateThread(function()
        while IN_PVP do
            local ped = PlayerPedId()
            CURRENT_TIME = (CURRENT_TIME - 1)
            SendReactMessage("setTempoRestante", CURRENT_TIME)

            local arena = config.arenas[IN_PVP_ID]
            if not arena or not IN_PVP then
                return
            end

            local inRange = false
            for i = 1, #arena.coords do
                local cds = arena.coords[i]

                if #(GetEntityCoords(PlayerPedId()) - vector3(cds.x,cds.y,cds.z)) <= 150.0 then
                    inRange = true
                end
            end

            if not inRange then
                local spawns = arena.coords
                local random = math.random(#spawns)
    
                SetEntityCoords(PlayerPedId(), spawns[random].x, spawns[random].y, spawns[random].z)
                SetEntityHealth(PlayerPedId(), 300)
                createVehicle(GetHashKey(arena.vehicle))
    
                -- GiveWeaponToPed(ped,GetHashKey(currentWeapon),250,true)
                -- RefillAmmoInstantly(ped)
                SetCurrentPedWeapon(ped, GetHashKey(currentWeapon), true)
            end

            if GetEntityHealth(ped) <= 101 then
                local plyCds = GetEntityCoords(ped)
                NetworkResurrectLocalPlayer(plyCds.x, plyCds.y, plyCds.z, true, true, false)
            
                local arena = config.arenas[IN_PVP_ID]
                if not arena or not IN_PVP then
                    return
                end

                local spawns = arena.coords
                local random = math.random(#spawns)

                SetEntityCoords(PlayerPedId(), spawns[random].x, spawns[random].y, spawns[random].z)
                SetEntityHealth(PlayerPedId(), 300)
                createVehicle(GetHashKey(arena.vehicle))

                -- GiveWeaponToPed(ped,GetHashKey(currentWeapon),250,true)
                -- RefillAmmoInstantly(ped)
                SetCurrentPedWeapon(ped, GetHashKey(currentWeapon), true)
            end

            Wait(1000)
        end
    end)

    CreateThread(function()
        while IN_PVP do
            SetPedCanBeKnockedOffVehicle(PlayerPedId(), 1)
            Wait(0)
        end

	    SetPedCanBeKnockedOffVehicle(PlayerPedId(), 0)
    end)
end)

RegisterNetEvent('descequebra:leave', function()
    IN_PVP = false
    IN_PVP_ID = 0
    CURRENT_TIME = 0

    if PLAYER_VEHICLE > 0 then
        DeleteVeh(PLAYER_VEHICLE)
    end

    local ped = PlayerPedId()
    RemoveAllPedWeapons(ped,true)
    SetEntityCoords(ped, ENTER_COORDS)

    SendReactMessage("setInArena", false) 
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function createVehicle(hash)
    

    while not HasModelLoaded(hash) do
        RequestModel(hash)
        Citizen.Wait(1)
    end
    if HasModelLoaded(hash) and IN_PVP then
        local plycoords = GetEntityCoords(PlayerPedId())
        local nveh = nil
        if PLAYER_VEHICLE > 0 and DoesEntityExist(PLAYER_VEHICLE) then
            --DeleteVeh(PLAYER_VEHICLE)
            nveh = PLAYER_VEHICLE
            while not NetworkHasControlOfEntity(nveh) and DoesEntityExist(nveh)do
                NetworkRequestControlOfEntity(nveh);
                Citizen.Wait(1);
            end
            SetEntityCoords(nveh,plycoords.x,plycoords.y,plycoords.z + 0.5)
        else
            nveh = CreateVehicle(hash,plycoords.x,plycoords.y,plycoords.z + 0.5,GetEntityHeading(ped),true,true)
        end
        while not DoesEntityExist(nveh) do 
            Wait(0) 
        end

        SetPedIntoVehicle(PlayerPedId(),nveh,-1)
        SetVehicleNumberPlateText(nveh,vRP.getRegistrationNumber() or "DROPKILL")
        SetVehicleOnGroundProperly(nveh)
        SetVehicleAsNoLongerNeeded(nveh)
        SetVehicleIsStolen(nveh,false)
        SetVehicleNeedsToBeHotwired(nveh,false)
        Citizen.InvokeNative(0xAD738C3085FE7E11,nveh,true,true)
        SetVehicleHasBeenOwnedByPlayer(nveh,true)
        SetVehRadioStation(nveh,"OFF")
        SetVehicleFixed(nveh)
        SetVehicleDirtLevel(nveh,0.0)
        SetModelAsNoLongerNeeded(hash)



        SetVehicleFixed(nveh)
        Wait(0)
        SetVehicleFixed(nveh)
        SetVehicleDirtLevel(nveh, 0.0)
        SetVehicleLights(nveh, 0)
        SetVehicleBurnout(nveh, false)
        Citizen.InvokeNative(0x1FD09E7390A74D54, nveh, 0)
        PLAYER_VEHICLE = nveh
    end
end

function DeleteVeh(v)
    if DoesEntityExist(v) and IsEntityAVehicle(v) then
        TriggerServerEvent("dk:forceDeleteVehicle", VehToNet(v))
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- COMMANDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('+scoreboard_descequebra', function()
    if not IN_PVP then return end

    Wait(50)
    SendReactMessage("setPlayers", vSERVER.requestScoreboard())
    SendReactMessage("setArenaData", { "Desce e Quebra", 0 })
end)

RegisterCommand('-scoreboard_descequebra', function()
    SendNUIMessage({ closeScoreboard = true })
end)
RegisterKeyMapping('+scoreboard_descequebra', 'Scoreboard PVP', 'keyboard', 'Q')


-----------------------------------------------------------------------------------------------------------------------------------------
-- GAME EVENTS
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("gameEventTriggered", function(eventName, args)
    if eventName ~= "CEventNetworkEntityDamage" or not IN_PVP then
        return
    end

    local ped = PlayerPedId()
    local victim = args[1]
    local attacker = args[2]
    local weapon = args[7]

    -- ENVIANDO KILL FEED
    if IsPedAPlayer(attacker) and attacker == ped then
        local plyHealth = GetEntityHealth(victim)
        if plyHealth <= 101 then
            local hit, bone = GetPedLastDamageBone(victim)
            vSERVER._sendKillFeed({
                victim = GetPlayerServerId(NetworkGetPlayerIndexFromPed(victim)),
                isHs = (bone == 31086),
                weapon = weapon,
            })
        end

        SetEntityHealth(ped, GetPedMaxHealth(ped))
        -- GiveWeaponToPed(ped,GetHashKey(currentWeapon),250,true)
        -- RefillAmmoInstantly(ped)
        SetCurrentPedWeapon(ped, GetHashKey(currentWeapon), true)
    end

    -- Validando Morte
    if victim == ped and GetEntityHealth(ped) <= 101 or IsEntityDead(ped) then
        SetTimeout(1000, function()
            local plyCds = GetEntityCoords(ped)
            NetworkResurrectLocalPlayer(plyCds.x, plyCds.y, plyCds.z, true, true, false)
        
            local arena = config.arenas[IN_PVP_ID]
            if not arena or not IN_PVP then
                return
            end

            local spawns = arena.coords
            local random = math.random(#spawns)

            SetEntityCoords(PlayerPedId(), spawns[random].x, spawns[random].y, spawns[random].z)
            SetEntityHealth(PlayerPedId(), 300)
            createVehicle(GetHashKey(arena.vehicle))

            -- GiveWeaponToPed(ped,GetHashKey(currentWeapon),250,true)
            -- RefillAmmoInstantly(ped)
            SetCurrentPedWeapon(ped, GetHashKey(currentWeapon), true)
        end)
    end
end)
