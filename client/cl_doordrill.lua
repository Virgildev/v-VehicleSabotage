local function deleteVehiclePart(entity, partIndex)
    if DoesEntityExist(entity) then
        local skillSuccess = lib.skillCheck(Config.DoorRemoveSkillcheck.difficulty, Config.DoorRemoveSkillcheck.keys)
        if skillSuccess then
            if lib.progressCircle({
                duration = Config.DoorRemoveProgress,
                position = 'bottom',
                label = Lang.Lang['removing_door_progress'],
                canCancel = true,
                disable = { move = true },
                anim = {
                    dict = 'amb@world_human_welding@male@base',
                    clip = 'base'
                },drill
            }) then
                SetVehicleDoorCanBreak(entity, partIndex, true)
                SetVehicleDoorBroken(entity, partIndex, true)
                TriggerServerEvent('v-vehiclesab:removeDrillItem')
                lib.notify({
                    description = Lang.Lang['part_removed_success'],
                    type = "success"
                })
            else
                lib.notify({
                    description = Lang.Lang['part_removal_cancelled'],
                    type = "error"
                })
            end
        else
            lib.notify({
                description = Lang.Lang['entity_not_exist'],
                type = "error"
            })
        end
    end
end

Citizen.CreateThread(function()
    local targetOptions = {
        {
            label = Lang.Lang['remove_car_door_target'],
            icon = "fa-solid fa-door-closed",
            distance = 1.0,
            bones = { 'door_dside_f', 'seat_dside_f' },
            items = Config.DoorRemoveItem,
            onSelect = function(data)
                local entity = data.entity
                deleteVehiclePart(entity, 0) -- Left front door (0)
            end,
            canInteract = function(entity, distance, coords, name, bone)
                return GetEntityBoneIndexByName(entity, "door_pside_f") ~= -1 and not IsVehicleDoorDamaged(entity, 0)
            end
        },
        {
            label = Lang.Lang['remove_car_door_target'],
            icon = "fa-solid fa-door-closed",
            distance = 1.0,
            bones = { 'door_pside_f', 'seat_pside_f' },
            items = Config.DoorRemoveItem,
            onSelect = function(data)
                local entity = data.entity
                deleteVehiclePart(entity, 1) -- Right front door (1)
            end,
            canInteract = function(entity, distance, coords, name, bone)
                return GetEntityBoneIndexByName(entity, "door_dside_f") ~= -1 and not IsVehicleDoorDamaged(entity, 1)
            end
        },
        {
            label = Lang.Lang['remove_car_door_target'],
            icon = "fa-solid fa-door-closed",
            distance = 1.0,
            bones = { 'door_dside_r', 'seat_dside_r' },
            items = Config.DoorRemoveItem,
            onSelect = function(data)
                local entity = data.entity
                deleteVehiclePart(entity, 2) -- Left rear door (2)
            end,
            canInteract = function(entity, distance, coords, name, bone)
                return GetEntityBoneIndexByName(entity, "door_pside_r") ~= -1 and not IsVehicleDoorDamaged(entity, 2)
            end
        },
        {
            label = Lang.Lang['remove_car_door_target'],
            icon = "fa-solid fa-door-closed",
            distance = 1.0,
            bones = { 'door_pside_r', 'seat_pside_r' },
            items = Config.DoorRemoveItem,
            onSelect = function(data)
                local entity = data.entity
                deleteVehiclePart(entity, 3) -- Right rear door (3)
            end,
            canInteract = function(entity, distance, coords, name, bone)
                return GetEntityBoneIndexByName(entity, "door_dside_r") ~= -1 and not IsVehicleDoorDamaged(entity, 3)
            end
        },
        {
            label = Lang.Lang['remove_car_hood_target'],
            icon = "fa-solid fa-car",
            distance = 2.0,
            offset = vec3(0.5, 1, 0.5),
            items = Config.DoorRemoveItem,
            onSelect = function(data)
                local entity = data.entity
                deleteVehiclePart(entity, 4) -- Hood (4)
            end,
            canInteract = function(entity, distance, coords, name, bone)
                return GetEntityBoneIndexByName(entity, "bonnet") ~= -1 and not IsVehicleDoorDamaged(entity, 4)
            end
        },
        {
            label = Lang.Lang['remove_car_trunk_target'],
            icon = "fa-solid fa-car",
            distance = 1.0,
            offset = vec3(0.5, 0, 0.5),
            items = Config.DoorRemoveItem,
            onSelect = function(data)
                local entity = data.entity
                deleteVehiclePart(entity, 5) -- Trunk (5)
            end,
            canInteract = function(entity, distance, coords, name, bone)
                return GetEntityBoneIndexByName(entity, "boot") ~= -1 and not IsVehicleDoorDamaged(entity, 5)
            end
        }
    }

    exports.ox_target:addGlobalVehicle(targetOptions)
end)