Config = {}

--[[
███████╗██╗   ██╗███████╗██╗         ███████╗ █████╗ ██████╗  ██████╗ ████████╗ █████╗  ██████╗ ███████╗
██╔════╝██║   ██║██╔════╝██║         ██╔════╝██╔══██╗██╔══██╗██╔═══██╗╚══██╔══╝██╔══██╗██╔════╝ ██╔════╝
█████╗  ██║   ██║█████╗  ██║         ███████╗███████║██████╔╝██║   ██║   ██║   ███████║██║  ███╗█████╗  
██╔══╝  ██║   ██║██╔══╝  ██║         ╚════██║██╔══██║██╔══██╗██║   ██║   ██║   ██╔══██║██║   ██║██╔══╝  
██║     ╚██████╔╝███████╗███████╗    ███████║██║  ██║██████╔╝╚██████╔╝   ██║   ██║  ██║╚██████╔╝███████╗
╚═╝      ╚═════╝ ╚══════╝╚══════╝    ╚══════╝╚═╝  ╚═╝╚═════╝  ╚═════╝    ╚═╝   ╚═╝  ╚═╝ ╚═════╝ ╚══════╝                                                                                                       
]]

-- Chance of explosion (1 to 100)
Config.ExplosionChance = 0 -- 50% chance for an explosion after sabotage

-- Delay before explosion occurs (in seconds)
Config.ExplosionDelay = 5 -- Delay of 5 seconds before explosion

Config.FuelProgress = 5000 -- Progress bar duration to cut cars fuel tank

Config.FuelSkillcheck = {
    difficulty = {'easy', 'medium', 'easy'}, -- skill check difficulty, add or remove
    keys = {'w', 'a', 's', 'd'} -- skill check keys, add or remove
}

Config.SabotageCooldown = 300  -- Cooldown time in seconds (example: 5 minutes)
Config.MaxSabotageDistance = 5.0 -- Maximum distance from the vehicle to sabotage
Config.ExplosionChance = 50  -- Chance of an explosion (percentage)
Config.ExplosionDelay = 2  -- Time before explosion in seconds

--[[
████████╗██╗██████╗ ███████╗    ███████╗██╗      █████╗ ███████╗██╗  ██╗██╗███╗   ██╗ ██████╗ 
╚══██╔══╝██║██╔══██╗██╔════╝    ██╔════╝██║     ██╔══██╗██╔════╝██║  ██║██║████╗  ██║██╔════╝ 
   ██║   ██║██████╔╝█████╗      ███████╗██║     ███████║███████╗███████║██║██╔██╗ ██║██║  ███╗
   ██║   ██║██╔══██╗██╔══╝      ╚════██║██║     ██╔══██║╚════██║██╔══██║██║██║╚██╗██║██║   ██║
   ██║   ██║██║  ██║███████╗    ███████║███████╗██║  ██║███████║██║  ██║██║██║ ╚████║╚██████╔╝
   ╚═╝   ╚═╝╚═╝  ╚═╝╚══════╝    ╚══════╝╚══════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝                                                                                               
]]

Config.UseSlash = true -- true or false, use slashing or not
Config.Knives = { -- MUST BE HOLDING/IN HAND so must be a weapon - to be able to slash
    `WEAPON_KNIFE`,
    `WEAPON_BOTTLE`,
    `WEAPON_DAGGER`,
    `WEAPON_SWITCHBLADE`,
}
Config.SlashProgress = 5000 -- Progress bar duration to slash the tire
Config.SlashSkillCheck = { 'easy', 'medium', 'easy' } -- skill check difficulty, add or remove
Config.SlashSkillCheckKeys = { 'w', 'a', 's', 'd' } -- skill check keys, add or remove

--[[
██╗   ██╗███████╗██╗  ██╗     █████╗ ██████╗ ███████╗ ██████╗ ███╗   ██╗
██║   ██║██╔════╝██║  ██║    ██╔══██╗██╔══██╗██╔════╝██╔═══██╗████╗  ██║
██║   ██║█████╗  ███████║    ███████║██████╔╝███████╗██║   ██║██╔██╗ ██║
╚██╗ ██╔╝██╔══╝  ██╔══██║    ██╔══██║██╔══██╗╚════██║██║   ██║██║╚██╗██║
 ╚████╔╝ ███████╗██║  ██║    ██║  ██║██║  ██║███████║╚██████╔╝██║ ╚████║
  ╚═══╝  ╚══════╝╚═╝  ╚═╝    ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝ ╚═════╝ ╚═╝  ╚═══╝                                                                       
]]

Config.ArsonSkillcheck = {
    difficulty = {'easy', 'medium', 'easy'}, -- skill check difficulty, add or remove
    keys = {'w', 'a', 's', 'd'}  -- skill check keys, add or remove
}

Config.ArsonProgress = 5000 -- Progress bar duration to plant the bomb

Config.ArsonCooldown = 600 -- Time between each 

--[[
██████╗ ██████╗ ███████╗ █████╗ ██╗  ██╗     ██████╗██╗   ██╗████████╗████████╗██╗███╗   ██╗ ██████╗ 
██╔══██╗██╔══██╗██╔════╝██╔══██╗██║ ██╔╝    ██╔════╝██║   ██║╚══██╔══╝╚══██╔══╝██║████╗  ██║██╔════╝ 
██████╔╝██████╔╝█████╗  ███████║█████╔╝     ██║     ██║   ██║   ██║      ██║   ██║██╔██╗ ██║██║  ███╗
██╔══██╗██╔══██╗██╔══╝  ██╔══██║██╔═██╗     ██║     ██║   ██║   ██║      ██║   ██║██║╚██╗██║██║   ██║
██████╔╝██║  ██║███████╗██║  ██║██║  ██╗    ╚██████╗╚██████╔╝   ██║      ██║   ██║██║ ╚████║╚██████╔╝
╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝     ╚═════╝ ╚═════╝    ╚═╝      ╚═╝   ╚═╝╚═╝  ╚═══╝ ╚═════╝                                                                                                     
]]

Config.BreakCuttingSkillcheck = {
    difficulty = {'easy', 'medium', 'easy'}, -- skill check difficulty, add or remove
    keys = {'w', 'a', 's', 'd'} -- skill check keys, add or remove
}

Config.BreakCuttingProgress = 5000 -- Progress bar duration to cut the breaks

Config.BreakCuttingCooldown = 60000 -- in milliseconds!! time between each break cut

--[[
 ██████╗ █████╗ ██████╗     ██████╗  ██████╗ ███╗   ███╗██████╗ 
██╔════╝██╔══██╗██╔══██╗    ██╔══██╗██╔═══██╗████╗ ████║██╔══██╗
██║     ███████║██████╔╝    ██████╔╝██║   ██║██╔████╔██║██████╔╝
██║     ██╔══██║██╔══██╗    ██╔══██╗██║   ██║██║╚██╔╝██║██╔══██╗
╚██████╗██║  ██║██║  ██║    ██████╔╝╚██████╔╝██║ ╚═╝ ██║██████╔╝
 ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝    ╚═════╝  ╚═════╝ ╚═╝     ╚═╝╚═════╝                                                                
]]

-- !!!! 
-- Bombs go off on the user starting the engine of the vehicle (1500 second wait between start and exploison)
-- !!!!

Config.CarBombSkillcheck = {
    difficulty = {'easy', 'medium', 'easy'}, -- skill check difficulty, add or remove
    keys = {'w', 'a', 's', 'd'} -- skill check keys, add or remove
}

Config.CarBombDisarmSkillcheck = {
    difficulty = {'easy', 'medium', 'easy'}, -- skill check difficulty, add or remove
    keys = {'w', 'a', 's', 'd'} -- skill check keys, add or remove
}

Config.CarBombProgress = 5000 -- Progress bar duration to place the car bomb

Config.CarBombDisarmProgress = 5000 -- Progress bar duration to defuse the bomb

Config.CarBombDisarmItem = 'drill' -- item required to disable the bomb

Config.CarBombCooldown = 300000 -- milliseconds!! current 5 min, cooldown between each car bomb placement

--[[
██████╗  ██████╗  ██████╗ ██████╗     ██████╗ ███████╗███╗   ███╗ ██████╗ ██╗   ██╗ █████╗ ██╗     
██╔══██╗██╔═══██╗██╔═══██╗██╔══██╗    ██╔══██╗██╔════╝████╗ ████║██╔═══██╗██║   ██║██╔══██╗██║     
██║  ██║██║   ██║██║   ██║██████╔╝    ██████╔╝█████╗  ██╔████╔██║██║   ██║██║   ██║███████║██║     
██║  ██║██║   ██║██║   ██║██╔══██╗    ██╔══██╗██╔══╝  ██║╚██╔╝██║██║   ██║╚██╗ ██╔╝██╔══██║██║     
██████╔╝╚██████╔╝╚██████╔╝██║  ██║    ██║  ██║███████╗██║ ╚═╝ ██║╚██████╔╝ ╚████╔╝ ██║  ██║███████╗
╚═════╝  ╚═════╝  ╚═════╝ ╚═╝  ╚═╝    ╚═╝  ╚═╝╚══════╝╚═╝     ╚═╝ ╚═════╝   ╚═══╝  ╚═╝  ╚═╝╚══════╝                                                                                                  
]]

Config.DoorRemoveSkillcheck = {
    difficulty = {'easy', 'medium', 'easy'}, -- skill check difficulty, add or remove
    keys = {'w', 'a', 's', 'd'} -- skill check keys, add or remove
}

Config.DoorRemoveProgress = 5000 -- Progress bar duration to remove a single door

Config.DoorRemoveItem = 'drill' -- item required to remove door

Config.RemoveDrillChance = 25 -- chance the above item is removed on successful or unsuccessful skillcheck

--[[
██╗    ██╗██╗  ██╗███████╗███████╗██╗         ██╗      ██████╗  ██████╗ ███████╗███████╗███╗   ██╗
██║    ██║██║  ██║██╔════╝██╔════╝██║         ██║     ██╔═══██╗██╔═══██╗██╔════╝██╔════╝████╗  ██║
██║ █╗ ██║███████║█████╗  █████╗  ██║         ██║     ██║   ██║██║   ██║███████╗█████╗  ██╔██╗ ██║
██║███╗██║██╔══██║██╔══╝  ██╔══╝  ██║         ██║     ██║   ██║██║   ██║╚════██║██╔══╝  ██║╚██╗██║
╚███╔███╔╝██║  ██║███████╗███████╗███████╗    ███████╗╚██████╔╝╚██████╔╝███████║███████╗██║ ╚████║
 ╚══╝╚══╝ ╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝    ╚══════╝ ╚═════╝  ╚═════╝ ╚══════╝╚══════╝╚═╝  ╚═══╝                                                                                                 
]]

Config.WheelLoosenSkillcheck = {
    difficulty = {'easy', 'medium', 'easy'}, -- skill check difficulty, add or remove
    keys = {'w', 'a', 's', 'd'} -- skill check keys, add or remove
}

Config.WheelLoosenProgress = 5000 -- Progress bar duration to loosen a wheel

Config.WheelItem = 'steel' -- item given when picking up a wheel !!!(also used in below section)
Config.WheelItemAmount = 5 --can easily be a math.random to get a number between a range "math.random(5,10)" !!!(also used in below section)

Config.WheelFallOffSpeed = 70 -- The speed in MPH required to be able to lose the tire

Config.WheelFallOffSpeed = 60 -- Time in milliseconds before a player can use the event again (5 minutes current)

Config.TireCooldown = 60000 -- Cooldown between each tire removal (success or fail) !!!(also used in below section)

Config.TireGiveItemCoolDown = 60000 -- The cooldown between each time the player can be given the items from the server event !!!(also used in below section)

Config.WheelProp = 'prop_stockade_wheel_flat' -- the prop of the wheel to target

--[[
██╗    ██╗██╗  ██╗███████╗███████╗██╗         ██████╗ ███████╗███╗   ███╗ ██████╗ ██╗   ██╗ █████╗ ██╗     
██║    ██║██║  ██║██╔════╝██╔════╝██║         ██╔══██╗██╔════╝████╗ ████║██╔═══██╗██║   ██║██╔══██╗██║     
██║ █╗ ██║███████║█████╗  █████╗  ██║         ██████╔╝█████╗  ██╔████╔██║██║   ██║██║   ██║███████║██║     
██║███╗██║██╔══██║██╔══╝  ██╔══╝  ██║         ██╔══██╗██╔══╝  ██║╚██╔╝██║██║   ██║╚██╗ ██╔╝██╔══██║██║     
╚███╔███╔╝██║  ██║███████╗███████╗███████╗    ██║  ██║███████╗██║ ╚═╝ ██║╚██████╔╝ ╚████╔╝ ██║  ██║███████╗
 ╚══╝╚══╝ ╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝    ╚═╝  ╚═╝╚══════╝╚═╝     ╚═╝ ╚═════╝   ╚═══╝  ╚═╝  ╚═╝╚══════╝                                                                                                          
]]

Config.WheelRemoveSkillcheck = {
    difficulty = {'easy', 'medium', 'easy'}, -- skill check difficulty, add or remove
    keys = {'w', 'a', 's', 'd'} -- skill check keys, add or remove
}

Config.WheelRemoveProgress = 5000 -- Progress bar duration to remove a wheel fully