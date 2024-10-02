local QBCore = exports['qb-core']:GetCoreObject()
local playerCooldowns = {}

local function removeWheelNuts()
    local src = GetPlayerServerId(PlayerId())

    if IsPedInAnyVehicle(PlayerPedId(), false) then
        return lib.notify({ description = Lang['must_be_outside_vehicle'], type = 'error' })
    end

    if not checkCooldown(src) then
        return
    end

    local closestVehicle = getClosestVehicle()
    if not (closestVehicle and DoesEntityExist(closestVehicle)) then
        print("DEBUG: No vehicle found.")
        return lib.notify({ description = Lang['no_vehicle_found'], type = 'error' })
    end

    local playerCoords = GetEntityCoords(PlayerPedId(), false)
    local closestWheelIndex, closestDistance = -1, 2.0
    local wheelBoneNames = {"wheel_lf", "wheel_rf", "wheel_lr", "wheel_rr"}

    for wheelIndex, wheelBone in ipairs(wheelBoneNames) do
        local wheelBoneIndex = GetEntityBoneIndexByName(closestVehicle, wheelBone)
        if wheelBoneIndex ~= -1 then
            local wheelCoords = GetWorldPositionOfEntityBone(closestVehicle, wheelBoneIndex)
            local distance = #(wheelCoords - playerCoords)

            if distance < closestDistance then
                closestDistance = distance
                closestWheelIndex = wheelIndex - 1
            end
        end
    end

    if closestWheelIndex ~= -1 then
        if isWheelLoosened(closestVehicle, closestWheelIndex) then
            print("DEBUG: Wheel already loosened.")
            return lib.notify({ description = Lang['wheel_already_loosened'], type = 'error' })
        end

        local skillSuccess = lib.skillCheck(Config.WheelLoosenSkillcheck.difficulty, Config.WheelLoosenSkillcheck.keys)

        if skillSuccess then
            if lib.progressCircle({
                duration = Config.WheelLoosenProgress,
                position = 'bottom',
                canCancel = true,
                disable = { move = true },
                anim = {
                    dict = 'anim@heists@fleeca_bank@drilling',
                    clip = 'drill_straight_end',
                },
                prop = {
                    model = 'prop_tool_consaw',
                    pos = vec3(0.04, 0.06, 0.20),
                    rot = vec3(15.0, 0.0, 270.0)
                },
            }) then
                SetVehicleAlarm(closestVehicle, true)
                StartVehicleAlarm(closestVehicle)
                TriggerServerEvent('v-vehiclesab:removeWheel', closestWheelIndex, VehToNet(closestVehicle))
            else
                lib.notify({ title = Lang['action_canceled'], description = Lang['loosen_canceled'], type = 'error' })
            end
        else
            lib.notify({ title = Lang['skill_check_failed'], description = Lang['failed_to_loosen'], type = 'error' })
        end
    else
        print("DEBUG: No wheel found.")
        lib.notify({ description = Lang['no_wheel_found'], type = 'error' })
    end
end

RegisterNetEvent('v-vehiclesab:breakWheelClient')
AddEventHandler('v-vehiclesab:breakWheelClient', function(closestWheelIndex, vehicleNetId)
    local closestVehicle = NetToVeh(vehicleNetId)

    if DoesEntityExist(closestVehicle) then
        BreakOffVehicleWheel(closestVehicle, closestWheelIndex, true, true, true, false)
        ApplyForceToEntity(closestVehicle, 2, 0, 1.0, 1.0, 1.0, 0.0, 0.0, 0.0, true, true, true, true, true, true)

        local vehiclePos = GetEntityCoords(closestVehicle)
        local wheelPos = vehiclePos

        TriggerServerEvent('v-vehiclesab:TireProp', wheelPos, closestVehicle)
    else
        print("Attempted to break off a wheel on a non-existent vehicle.")
    end
end)

exports('wheelRemover', function(data)
    removeWheelNuts()
end)
