local QBCore = exports['qb-core']:GetCoreObject()
local tireCooldowns = {}

function SetPlayerRoutingBucketLockdown(playerId)
    local playerBucket = GetPlayerRoutingBucket(playerId)

    if playerBucket ~= 0 then
        SetRoutingBucketEntityLockdownMode(playerBucket, 'strict')
        print(('Routing bucket for player %d set to strict mode'):format(playerId))
    end
end

RegisterNetEvent('v-vehiclesab:removeLooseWheel')
AddEventHandler('v-vehiclesab:removeLooseWheel', function(closestWheelIndex, vehicleNetId)
    local src = source
    local player = QBCore.Functions.GetPlayer(src)

    if not player then
        print("Invalid player attempted to trigger the event.")
        return
    end

    SetPlayerRoutingBucketLockdown(src)

    TriggerClientEvent('v-vehiclesab:breakOffWheelClient', src, closestWheelIndex, vehicleNetId)
end)

RegisterNetEvent('v-vehiclesab:createTireProp')
AddEventHandler('v-vehiclesab:createTireProp', function(wheelPos, closestVehicle)
    local src = source

    local tireProp = CreateObject(Config.WheelProp, wheelPos.x, wheelPos.y, wheelPos.z, true, true, true)
    
    Wait(1500)

    if DoesEntityExist(tireProp) then
        local netId = NetworkGetNetworkIdFromEntity(tireProp)

        TriggerClientEvent('v-vehiclesab:tirePropTarget', src, netId, closestVehicle, wheelPos)
    else
        print("Failed to create the tire prop.")
    end
end)

function GetWheelOffset(vehicle, wheelIndex)
    local offset = vector3(0.0, 0.0, 0.0)

    if wheelIndex == 0 then -- Front Left
        offset = vector3(-0.9, 1.5, -0.5)
    elseif wheelIndex == 1 then -- Front Right
        offset = vector3(0.9, 1.5, -0.5)
    elseif wheelIndex == 2 then -- Rear Left
        offset = vector3(-0.9, -1.5, -0.5)
    elseif wheelIndex == 3 then -- Rear Right
        offset = vector3(0.9, -1.5, -0.5)
    end

    return offset
end

RegisterNetEvent('v-vehiclesab:giveTire')
AddEventHandler('v-vehiclesab:giveTire', function(closestVehicle, tireProp, wheelPos)
    local src = source
    local player = QBCore.Functions.GetPlayer(src)

    if not player then
        print("Invalid player attempted to trigger the event.")
        return
    end

    local currentTime = GetGameTimer()

    if tireCooldowns[src] and currentTime - tireCooldowns[src] < Config.TireGiveItemCoolDown * 1000 then
        local remainingTime = (Config.TireGiveItemCoolDown * 1000 - (currentTime - tireCooldowns[src])) / 1000

        TriggerEvent('ox_lib:notify', {
            title = 'Cooldown Active',
            description = Lang.Lang['must_wait'] .. math.ceil(remainingTime) .. Lang.Lang['must_wait_2'],
            type = 'error',
            position = 'top-right',
            duration = 5000
        })
        return
    end

    local ped = GetPlayerPed(src)
    local playerCoords = GetEntityCoords(ped)
    local dist = #(playerCoords - wheelPos)

    if dist <= 15.0 then
        exports.ox_inventory:AddItem(src, Config.WheelItem, Config.WheelItemAmount)
        print("Player " .. GetPlayerName(src) .. " received a tire.")

        TriggerEvent('ox_lib:notify', {
            title = 'Tire Received',
            description = 'You have received a tire.',
            type = 'success',
            position = 'top-right',
            duration = 5000
        })

        tireCooldowns[src] = GetGameTimer()
    else
        print("No vehicle found near player, event aborted.")
    end
end)