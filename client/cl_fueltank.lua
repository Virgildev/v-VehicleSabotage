local QBCore = exports['qb-core']:GetCoreObject()

local function useDrill(vehicle)
    local coords = GetEntityCoords(vehicle)

    local success = lib.skillCheck(Config.FuelSkillcheck.difficulty, Config.FuelSkillcheck.keys)

    if success then
        local successMessage = Lang.Lang['drill_success']
        lib.progressCircle({
            duration = Config.FuelProgress,
            position = 'bottom',
            canCancel = true,
            label = Lang.Lang['poking_holes'],
            disable = { move = true },
            anim = {
                dict = 'anim@heists@fleeca_bank@drilling',
                clip = 'drill_straight_end',                 
            },
            prop = {
                model = `hei_prop_heist_drill`, 
                pos = vec3(0.12, 0.06, 0.28), --l/r, foward/back, up
                rot = vec3(15.0, 0.0, 180.0)
            },  
        })

        StartFuelLeak(vehicle)
        --exports["LegacyFuel"]:SetFuel(vehicle, 0)

        TriggerServerEvent('v-vehiclesab:sabotageVehicle', coords)
        lib.notify({
            type = 'success',
            description = successMessage,
        })
    else
        lib.notify({
            type = 'error',
            description = Lang.Lang['drill_failure'],
        })
    end
end

function StartFuelLeak(vehicle)
    SetVehicleCanLeakPetrol(vehicle, true)
    SetVehiclePetrolTankHealth(vehicle, 150)
end

exports('drillTank', function(data, slot)
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)

    local vehicle = QBCore.Functions.GetClosestVehicle(playerCoords)
    local distance = #(GetEntityCoords(vehicle) - playerCoords)

    if vehicle ~= 0 and distance <= 3.0 then
        exports.ox_inventory:useItem(data, function(data)
            if data then
                useDrill(vehicle)
            else
                lib.notify({
                    type = 'error',
                    description = Lang.Lang['no_drill'],
                })
            end
        end)
    else
        lib.notify({
            type = 'error',
            description = 'You must be outside of the vehicle to use the drill!',
        })
    end
end)

RegisterNetEvent('v-vehiclesab:triggerExplosion', function(coords)
    AddExplosion(coords.x, coords.y, coords.z, 2, 50.0, true, false, 1.0)
end)
