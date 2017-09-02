local LevelBase            = require "src/Game/LevelBase"


local CollidePool           = require "src/Objects/CollidePool"
local ObjectPool            = require "src/Objects/ObjectPool"


local Level1 = {}


-- ==========================================Build/Destroy


function Level1:New( iWorld )

    newLevel1 = LevelBase:New( iWorld )

    setmetatable( newLevel1, LevelBase )
    newLevel1.__index = newLevel1

    Level1.BuildLevel1( newLevel1 )

    return  newLevel1
end


function  Level1:BuildLevel1( iLevel1 )

    LevelBase.BuildLevelBase( iLevel1 )

    iLevel1.world                  = iWorld
    iLevel1.terrain                = nil

    iLevel1.fixedBackground        = nil
    iLevel1.backgrounds            = {}
    iLevel1.foregrounds            = {}

    iLevel1.heros                  = {}
    iLevel1.environnementObjects   = {}

end

-- ==========================================Type


function  Level1.Type()
    return "Level1"
end


-- ==========================================Update/Draw


function  Level1:Update( iDT )
end


function  Level1:Draw()
end


-- ==========================================Level1 functions


-- ==========================================Collide CB


return  Level1