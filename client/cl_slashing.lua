function loadAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Wait(10)
    end
end

function hasKnife()
    local playerPed = PlayerPedId()
    local weapon = GetSelectedPedWeapon(playerPed)

    for _, knife in pairs(Config.Knives) do
        if weapon == knife then
            return true
        end
    end

    return false
end

function setCarAlarm(vehicle)
    if DoesEntityExist(vehicle) then
        SetVehicleAlarm(vehicle, true)
        StartVehicleAlarm(vehicle)
    end
end

RegisterNetEvent('v-vehiclesab:popTire', function(networkId, wheelIndex)
    local vehicle = NetworkGetEntityFromNetworkId(networkId)
    if DoesEntityExist(vehicle) then
        SetVehicleTyreBurst(vehicle, wheelIndex, false, 1000.0)
        setCarAlarm(vehicle)
    end
end)

Citizen.CreateThread(function()
    exports.ox_target:addGlobalVehicle({
        {
            label = Lang.Lang['slash_tire_target'],
            icon = 'fas fa-cut',
            distance = 3.0,
            bones = {"wheel_lf", "wheel_rf", "wheel_lm1", "wheel_rm1", "wheel_lr", "wheel_rr"},
            canInteract = function(entity, distance, coords, name, bone)
                local hasWeapon = hasKnife()
                return hasWeapon
            end,
            onSelect = function(data)
                local playerPed = PlayerPedId()
                local vehicle = data.entity

                local playerPos = GetEntityCoords(playerPed)

                local boneCoords = nil
                local closestBone = nil
                local closestDistance = 3.0 

                for _, boneName in pairs(data.bones) do
                    local boneIndex = GetEntityBoneIndexByName(vehicle, boneName)
                    if boneIndex ~= -1 then
                        local bonePos = GetWorldPositionOfEntityBone(vehicle, boneIndex)
                        local distanceToBone = #(bonePos - playerPos)
                        if distanceToBone < closestDistance then
                            closestBone = boneName
                            closestDistance = distanceToBone
                            boneCoords = bonePos
                        end
                    end
                end

                local wheelBones = {
                    ['wheel_lf'] = 0, -- Left Front
                    ['wheel_rf'] = 1, -- Right Front
                    ['wheel_lm1'] = 2, -- Left Middle (if applicable)
                    ['wheel_rm1'] = 3, -- Right Middle (if applicable)
                    ['wheel_lr'] = 4, -- Left Rear
                    ['wheel_rr'] = 5  -- Right Rear
                }

                local wheelIndex = wheelBones[closestBone]

                if wheelIndex == nil then
                    return
                end

                TaskTurnPedToFaceCoord(playerPed, boneCoords.x, boneCoords.y, boneCoords.z, 1000)

                SetPedConfigFlag(playerPed, 36, true)

                loadAnimDict("melee@knife@streamed_core_fps")
                TaskPlayAnim(playerPed, "melee@knife@streamed_core_fps", "ground_attack_on_spot", 8.0, -8.0, -1, 1, 0, false, false, false)

                local progressActive = lib.progressCircle({
                    duration = Config.SlashProgress,
                    position = 'bottom',
                    useWhileDead = false,
                    canCancel = false,
                    anim = {
                        dict = "melee@knife@streamed_core_fps",
                        clip = "ground_attack_on_spot"
                    }
                })

                if progressActive then
                    local success = lib.skillCheck(Config.SlashSkillCheck, Config.SlashSkillCheckKeys)
                    if success then
                        local networkId = NetworkGetNetworkIdFromEntity(vehicle)
                        TriggerServerEvent('v-vehiclesab:slashTire', networkId, wheelIndex)
                    else
                        lib.notify({
                            title = Lang.Lang['failed_title'],
                            description = Lang.Lang['failed_description'],
                            type = 'error'
                        })
                    end
                else
                    lib.notify({
                        title = Lang.Lang['cancelled_title'],
                        description = Lang.Lang['cancelled_description'],
                        type = 'error'
                    })
                end
                StopAnimTask(playerPed, "melee@knife@streamed_core_fps", "ground_attack_on_spot", 1.0)
                SetPedConfigFlag(playerPed, 36, false)
            end
        }
    })
end)