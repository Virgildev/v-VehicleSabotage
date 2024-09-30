local QBCore = exports['qb-core']:GetCoreObject()

local sabotageCooldowns = {}

RegisterNetEvent('v-vehiclesab:sabotageVehicle', function(coords, vehicle)
    local source = source
    local Player = QBCore.Functions.GetPlayer(source)

    if not Player then
        return
    end

    local playerId = Player.PlayerData.citizenid
    local currentTime = os.time()
    
    if sabotageCooldowns[playerId] and (currentTime - sabotageCooldowns[playerId]) < Config.SabotageCooldown then
        TriggerClientEvent('ox_lib:notify', source, {
            description = "You must wait before sabotaging another vehicle.",
            type = 'error',
        })
        return
    end

    local playerCoords = GetEntityCoords(GetPlayerPed(source))
    local distance = #(playerCoords - coords)

    if distance > Config.MaxSabotageDistance then
        TriggerClientEvent('ox_lib:notify', source, {
            description = "You are too far from the vehicle to sabotage it.",
            type = 'error',
        })
        return
    end

    sabotageCooldowns[playerId] = currentTime

    local chance = math.random(1, 100)
    
    if chance <= Config.ExplosionChance then
        Citizen.SetTimeout(Config.ExplosionDelay * 1000, function()
            TriggerClientEvent('v-vehiclesab:triggerExplosion', -1, coords)
        end)
        TriggerClientEvent('ox_lib:notify', source, {
            description = Lang.Lang.sabotage_failed,
            type = 'error',
        })
    else
        TriggerClientEvent('ox_lib:notify', source, {
            description = Lang.Lang.sabotage_success,
            type = 'success',
        })
    end
end)
