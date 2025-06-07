local aimlabCoords = vector3(6976.78, 916.68, 763.63)
local aimHeading = 183.55

local targetCoords = {
    vector3(6972.09,903.10,763.63),
    vector3(6974.63,903.90,763.63),
    vector3(6977.45,904.84,763.63),
    vector3(6980.12,905.71,763.63),
    vector3(6983.65,906.97,763.63),
    vector3(6988.37,908.66,763.63),
    vector3(6989.44,905.88,763.63),
    vector3(6986.94,904.88,763.63),
    vector3(6983.30,903.49,763.63),
    vector3(6979.88,902.39,763.63)
}

local aimlabActive = false
local spawnedPeds = {}
local enterCoords = nil
local targetModel = GetHashKey("s_m_y_cop_01")

local function cleanupTargets()
    for _, ped in ipairs(spawnedPeds) do
        if DoesEntityExist(ped) then
            DeleteEntity(ped)
        end
    end
    spawnedPeds = {}
end

local function spawnTargets()
    cleanupTargets()
    RequestModel(targetModel)
    while not HasModelLoaded(targetModel) do
        Wait(10)
    end

    for _, coord in ipairs(targetCoords) do
        local ped = CreatePed(4, targetModel, coord.x, coord.y, coord.z, 0.0, false, true)
        SetPedCanRagdoll(ped, true)
        SetEntityInvincible(ped, false)
        GiveWeaponToPed(ped, GetHashKey("WEAPON_PISTOL"), 250, true, true)
        SetPedDropsWeaponsWhenDead(ped, false)
        table.insert(spawnedPeds, ped)
    end
end

RegisterCommand('aimlab', function()
    if aimlabActive then return end
    local ped = PlayerPedId()
    if IsPedDeadOrDying(ped) then return end
    enterCoords = GetEntityCoords(ped)

    DoScreenFadeOut(500)
    Wait(500)
    SetEntityCoordsNoOffset(ped, aimlabCoords, false, false, false)
    SetEntityHeading(ped, aimHeading)
    Wait(500)
    DoScreenFadeIn(500)

    aimlabActive = true
    spawnTargets()
end)

RegisterCommand('leaveaimlab', function()
    if not aimlabActive then return end
    local ped = PlayerPedId()
    DoScreenFadeOut(500)
    Wait(500)
    cleanupTargets()
    if enterCoords then
        SetEntityCoordsNoOffset(ped, enterCoords, false, false, false)
    end
    Wait(500)
    DoScreenFadeIn(500)
    aimlabActive = false
end)

-- Respawn any dead targets every few seconds
Citizen.CreateThread(function()
    while true do
        if aimlabActive then
            for i, ped in ipairs(spawnedPeds) do
                if not DoesEntityExist(ped) or IsEntityDead(ped) then
                    local coord = targetCoords[i]
                    DeleteEntity(ped)
                    local newPed = CreatePed(4, targetModel, coord.x, coord.y, coord.z, 0.0, false, true)
                    SetPedCanRagdoll(newPed, true)
                    SetEntityInvincible(newPed, false)
                    GiveWeaponToPed(newPed, GetHashKey("WEAPON_PISTOL"), 250, true, true)
                    SetPedDropsWeaponsWhenDead(newPed, false)
                    spawnedPeds[i] = newPed
                end
            end
        end
        Wait(1000)
    end
end)
