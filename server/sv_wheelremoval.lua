local QBCore = exports['qb-core']:GetCoreObject()
local tireCooldowns = {}

RegisterNetEvent('v-vehiclesab:removeWheel')
AddEventHandler('v-vehiclesab:removeWheel', function(closestWheelIndex, vehicleNetId)
    local src = source
    local player = QBCore.Functions.GetPlayer(src)

    if not player then
        print("Invalid player attempted to trigger the event.")
        return
    end

    TriggerClientEvent('v-vehiclesab:breakWheelClient', src, closestWheelIndex, vehicleNetId)
end)

RegisterNetEvent('v-vehiclesab:TireProp')
AddEventHandler('v-vehiclesab:TireProp', function(wheelPos, closestVehicle)
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