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

Config.WheelItem = 'steel' -- item given when picking up a wheel !!!(also used in below second)
Config.WheelItemAmount = 5 --can easily be a math.random to get a number between a range "math.random(5,10)" !!!(also used in below second)

Config.WheelFallOffSpeed = 70 -- The speed in MPH required to be able to lose the tire

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