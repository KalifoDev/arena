local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

local src = {}
Tunnel.bindInterface("mirtin_arena", src)

local Arenas = {} -- { [arenaId] = { players = { [playerSource] = { kills = 0, deaths = 0 } }, state = "waiting" | "active" | "finished" } }
local PlayerArenas = {} -- { [playerSource] = arenaId }
local PlayerBets = {} -- { [playerSource] = betAmount }

-- Función para obtener datos de una arena desde shared-side/arenas.lua
function GetArenaConfig(arenaId)
    local arenaConfig = require("shared-side/arenas").arenas[arenaId]
    if not arenaConfig then
        print("[ARENA] Configuración de arena no encontrada para ID: " .. arenaId)
        return nil
    end
    return arenaConfig
end

-- Evento para que un jugador apueste y entre a una arena
RegisterServerEvent("arena:join")
AddEventHandler("arena:join", function(arenaId)
    src.apostarArena(arenaId)
end)

function src.apostarArena(arenaId)
    local source = source
    local user_id = vRP.getUserId({source})
    if not user_id or PlayerArenas[source] then return false end

    local arenaConfig = GetArenaConfig(arenaId)
    if not arenaConfig then
        TriggerClientEvent("Notify", source, "negado", "Arena no disponible.", 3000)
        return false
    end

    if arenaConfig.minAposta > 0 then
        if not vRP.tryPayment({user_id, arenaConfig.minAposta}) then
            TriggerClientEvent("Notify", source, "negado", "Dinero insuficiente para entrar.", 3000)
            return false
        end
        PlayerBets[source] = arenaConfig.minAposta
    end

    Arenas[arenaId] = Arenas[arenaId] or { players = {}, state = "waiting" }
    Arenas[arenaId].players[source] = { kills = 0, deaths = 0 }
    PlayerArenas[source] = arenaId

    TriggerClientEvent("arena:spawn", source, arenaId, arenaConfig.timeArena * 60)
    TriggerClientEvent("Notify", source, "sucesso", "Entraste a la arena: " .. arenaConfig.nome, 5000)
    return true
end

-- Evento para manejar muertes y kills
RegisterServerEvent("arena:sendKillFeed")
AddEventHandler("arena:sendKillFeed", function(data)
    local killerSource = source
    local victimSource = data.victim
    local arenaId = PlayerArenas[killerSource]

    if not arenaId or not Arenas[arenaId] then return end

    -- Actualizar stats
    Arenas[arenaId].players[killerSource] = Arenas[arenaId].players[killerSource] or { kills = 0, deaths = 0 }
    Arenas[arenaId].players[killerSource].kills = Arenas[arenaId].players[killerSource].kills + 1

    if Arenas[arenaId].players[victimSource] then
        Arenas[arenaId].players[victimSource].deaths = Arenas[arenaId].players[victimSource].deaths + 1
    end

    -- Enviar kill feed a todos en la arena
    for playerSrc, _ in pairs(Arenas[arenaId].players) do
        TriggerClientEvent("arena:updateKillFeed", playerSrc, {
            killer = GetPlayerName(killerSource),
            victim = GetPlayerName(victimSource),
            weapon = data.weapon,
            isHs = data.isHs
        })
    end
end)

-- Evento para salir de la arena
RegisterServerEvent("arena:leave")
AddEventHandler("arena:leave", function()
    src.playerLeavingArena()
end)

function src.playerLeavingArena()
    local source = source
    local arenaId = PlayerArenas[source]
    if not arenaId or not Arenas[arenaId] then return end

    if Arenas[arenaId].state == "waiting" and PlayerBets[source] then
        local user_id = vRP.getUserId({source})
        vRP.giveMoney({user_id, PlayerBets[source]})
    end

    Arenas[arenaId].players[source] = nil
    PlayerArenas[source] = nil
    PlayerBets[source] = nil

    TriggerClientEvent("arena:leave", source)
end

-- Función para obtener el scoreboard (llamada desde el cliente)
function src.requestScoreboard()
    local source = source
    local arenaId = PlayerArenas[source]
    if not arenaId or not Arenas[arenaId] then return {} end

    local scoreboard = {}
    for playerSrc, stats in pairs(Arenas[arenaId].players) do
        table.insert(scoreboard, {
            name = GetPlayerName(playerSrc),
            kills = stats.kills,
            deaths = stats.deaths
        })
    end

    return scoreboard
end

-- Sincronizar tiempo restante (opcional)
function src.getTimeArena(arenaId)
    local arenaConfig = GetArenaConfig(arenaId)
    return arenaConfig and arenaConfig.timeArena * 60 or 0
end

-- Registrar coordenadas de volta para o lobby
local PlayerReturnCoords = {}
function src._atualizarCoords(coords)
    PlayerReturnCoords[source] = coords
end

-- Retornar lista de arenas com quantidade atual de jogadores
function src.showNuiArena()
    return src.getArenas()
end

function src.getArenas()
    local cfg = require("shared-side/arenas").arenas
    local arenas = {}
    for id, arena in pairs(cfg) do
        arenas[id] = arena
        local count = 0
        if Arenas[id] and Arenas[id].players then
            for _ in pairs(Arenas[id].players) do count = count + 1 end
        end
        arenas[id].actualPlayers = count
        arenas[id].id = id
    end
    return arenas
end

-- Quantidade de jogadores em cada arena
function src.getOnlinePlayersForArenas()
    local counts = {}
    for id, arena in pairs(Arenas) do
        local c = 0
        for _ in pairs(arena.players) do c = c + 1 end
        counts[id] = c
    end
    return counts
end

-- Scoreboard completo para uma arena
function src.scoreBoard(arenaId)
    local arenaConfig = GetArenaConfig(arenaId)
    local players = {}
    if Arenas[arenaId] then
        for playerSrc, stats in pairs(Arenas[arenaId].players) do
            table.insert(players, {
                id = playerSrc,
                name = GetPlayerName(playerSrc),
                kills = stats.kills,
                deaths = stats.deaths
            })
        end
    end
    return arenaConfig and arenaConfig.nome or "Arena", arenaConfig and arenaConfig.timeArena * 60 or 0, players, arenaConfig and arenaConfig.timeArena * 60 or 0
end

-- Gera tabela de ranking global
function src.CreateNewRankTable()
    local ranking = {}
    for id, arena in pairs(Arenas) do
        for playerSrc, stats in pairs(arena.players) do
            local user_id = vRP.getUserId({playerSrc})
            table.insert(ranking, {
                user_id = user_id,
                name = GetPlayerName(playerSrc),
                kills = stats.kills,
                death = stats.deaths
            })
        end
    end
    table.sort(ranking, function(a,b) return (a.kills or 0) > (b.kills or 0) end)
    return ranking
end

-- Envia spawn aleatório da arena
function src.randomSpawn()
    local arenaId = PlayerArenas[source]
    if not arenaId then return nil end
    local arenaConfig = GetArenaConfig(arenaId)
    if not arenaConfig or not arenaConfig.coords then return nil end
    local coords = arenaConfig.coords[math.random(#arenaConfig.coords)]
    return { coords.x, coords.y, coords.z }, 101
end

-- Registra morte de jogador
function src.receberMorte(victim, weapon, killer)
    local arenaId = PlayerArenas[victim]
    if not arenaId or not Arenas[arenaId] then return end

    if killer and killer ~= 0 then
        Arenas[arenaId].players[killer] = Arenas[arenaId].players[killer] or { kills = 0, deaths = 0 }
        Arenas[arenaId].players[killer].kills = Arenas[arenaId].players[killer].kills + 1
    end

    if Arenas[arenaId].players[victim] then
        Arenas[arenaId].players[victim].deaths = Arenas[arenaId].players[victim].deaths + 1
    end

    for playerSrc, _ in pairs(Arenas[arenaId].players) do
        TriggerClientEvent("arena:updateKillFeed", playerSrc, {
            killer = killer ~= 0 and GetPlayerName(killer) or "-",
            victim = GetPlayerName(victim),
            weapon = weapon,
            isHs = false
        })
    end
end

-- Alterna favorito
local PlayerFavorites = {}
function src.toggleFavoriteArena(arenaId)
    local user_id = vRP.getUserId({source})
    if not user_id then return end
    PlayerFavorites[user_id] = PlayerFavorites[user_id] or {}
    PlayerFavorites[user_id][arenaId] = not PlayerFavorites[user_id][arenaId]
end
