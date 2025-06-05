local vRP = require("@vrp/lib/utils")
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRPclient = Tunnel.getInterface("vRP", "mirtin_arena")

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
    local source = source
    local user_id = vRP.getUserId({source})
    if not user_id or PlayerArenas[source] then return end

    local arenaConfig = GetArenaConfig(arenaId)
    if not arenaConfig then
        TriggerClientEvent("Notify", source, "negado", "Arena no disponible.", 3000)
        return
    end

    -- Verificar apuesta mínima
    if arenaConfig.minAposta > 0 then
        if not vRP.tryPayment({user_id, arenaConfig.minAposta}) then
            TriggerClientEvent("Notify", source, "negado", "Dinero insuficiente para entrar.", 3000)
            return
        end
        PlayerBets[source] = arenaConfig.minAposta
    end

    -- Unir jugador a la arena
    Arenas[arenaId] = Arenas[arenaId] or { players = {}, state = "waiting" }
    Arenas[arenaId].players[source] = { kills = 0, deaths = 0 }
    PlayerArenas[source] = arenaId

    -- Notificar al cliente
    TriggerClientEvent("arena:spawn", source, arenaId, arenaConfig.timeArena * 60) -- Convertir minutos a segundos
    TriggerClientEvent("Notify", source, "sucesso", "Entraste a la arena: " .. arenaConfig.nome, 5000)
end)

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
    local source = source
    local arenaId = PlayerArenas[source]
    if not arenaId or not Arenas[arenaId] then return end

    -- Devolver apuesta si la arena no comenzó
    if Arenas[arenaId].state == "waiting" and PlayerBets[source] then
        local user_id = vRP.getUserId({source})
        vRP.giveMoney({user_id, PlayerBets[source]})
    end

    -- Limpiar datos
    Arenas[arenaId].players[source] = nil
    PlayerArenas[source] = nil
    PlayerBets[source] = nil

    -- Notificar al cliente
    TriggerClientEvent("arena:leave", source)
end)

-- Función para obtener el scoreboard (llamada desde el cliente)
function vSERVER.requestScoreboard()
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
function vSERVER.getTimeArena(arenaId)
    local arenaConfig = GetArenaConfig(arenaId)
    return arenaConfig and arenaConfig.timeArena * 60 or 0
end