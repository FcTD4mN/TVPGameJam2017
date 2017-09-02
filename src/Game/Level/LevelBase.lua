local ObjectPool            = require "src/Objects/ObjectPool"
local CollidePool           = require "src/Objects/CollidePool"


local LevelBase = {}



-- ==========================================Build/Destroy


function LevelBase:New( iWorld )

    newLevelBase = {}
    setmetatable( newLevelBase, self )
    self.__index = self

    LevelBase.BuildLevelBase( newLevelBase )

    return  newLevelBase
end


function  LevelBase:BuildLevelBase( iLevelBase )

    iLevelBase.world                  = iWorld
    iLevelBase.terrain                = nil

    iLevelBase.fixedBackground        = nil
    iLevelBase.backgrounds            = {}
    iLevelBase.foregrounds            = {}

    iLevelBase.heros                  = {}
    iLevelBase.environnementObjects   = {}

end

-- ==========================================Type


function  LevelBase.Type()
    return "LevelBase"
end


-- ==========================================Update/Draw


function  LevelBase:Update( iDT )

    self.terrain:Update( iDT )

    for k,v in pairs( self.backgrounds ) do
        v:Update( iDT )
    end

    ObjectPool.Update( dt )
    self.world:update( dt )
    CollidePool.Update( dt )

    for k,v in pairs( foregrounds ) do
        v:Update( dt )
    end

    self:UpdateCamera()
end


function  LevelBase:Draw()

    self.fixedBackground:Draw()

    for k,v in pairs( self.backgrounds ) do
        v:Update( iDT )
    end


    for k,v in pairs( self.environnementObjects ) do
        v:Update( iDT )
    end

    for k,v in pairs( self.heros ) do
        v:Update( iDT )
    end


    for k,v in pairs( self.foregrounds ) do
        v:Update( iDT )
    end

end


-- ==========================================LevelBase functions


function  LevelBase:UpdateCamera()

    xAverage = 0

    for k,v in pairs( self.heros ) do
        x = v:GetX()
        xAverage = ( xAverage + x )
    end
    xAverage = xAverage / #self.heros

    Camera.x = xAverage - love.graphics.getWidth() / 2
    Camera.y = 0 --love.graphics.getHeight() / 2

end


-- ==========================================Collide CB


function  LevelBase.Collide( iCollider )
    -- do nothing
end


return  LevelBase