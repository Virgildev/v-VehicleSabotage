RegisterNetEvent('v-vehiclesab:plantCarBomb')
AddEventHandler('v-vehiclesab:plantCarBomb', function(vehicleNetID)
    local src = source
    local vehicle = NetworkGetEntityFromNetworkId(vehicleNetID)

    if DoesEntityExist(vehicle) then
        local offset = vector3(0, 0, 0)
        TriggerClientEvent('v-vehiclesab:attachCarBomb', src, vehicleNetID, offset)
    else
        TriggerClientEvent('ox_lib:notify', src, {
            title = 'Error',
            description = 'Failed to plant bomb: vehicle no longer exists.',
            type = 'error'
        })
    end
    local vehicle = NetworkGetEntityFromNetworkId(vehicleNetID)

    if DoesEntityExist(vehicle) then
        local bombModel = 'ch_prop_ch_ld_bomb_01a'
        loadModel(bombModel)
        local bomb = CreateObject(bombModel, 0.0, 0.0, 0.0, true, true, false)
        local boneIndex = GetEntityBoneIndexByName(vehicle, 'seat_pside_f')

        if boneIndex ~= -1 then
            AttachEntityToEntity(bomb, vehicle, boneIndex, offset.x, offset.y, offset.z, 0, 0, 0, true, true, false, true, false, true)
            print("Bomb attached to vehicle.")
        else
            lib.notify({
                title = 'Error',
                description = 'Failed to attach bomb: invalid bone index.',
                type = 'error'
            })
        end
    else
        lib.notify({
            title = 'Error',
            description = 'Failed to plant bomb: vehicle no longer exists.',
            type = 'error'
        })
    end
end)

RegisterNetEvent('v-vehiclesab:detonateBomb')
AddEventHandler('v-vehiclesab:detonateBomb', function(vehicleNetID)
    local src = source
    TriggerClientEvent('v-vehiclesab:detonateBombClient', src, vehicleNetID)
end)

RegisterNetEvent('v-vehiclesab:removeBomb')
AddEventHandler('v-vehiclesab:removeBomb', function(vehicleNetID)
    TriggerClientEvent('v-vehiclesab:removeBombClient', -1, vehicleNetID)
end)
