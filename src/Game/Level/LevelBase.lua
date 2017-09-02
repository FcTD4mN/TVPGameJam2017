local ObjectPool            = require "src/Objects/ObjectPool"
local CollidePool           = require "src/Objects/CollidePool"


local LevelBase = {}


-- ==========================================Build/Destroy


function LevelBase:New( iWorld )

    newLevelBase = {}
    setmetatable( newLevelBase, LevelBase )
    LevelBase.__index = LevelBase

    newLevelBase:BuildLevelBase( iWorld )

    return  newLevelBase
end


function  LevelBase:BuildLevelBase( iWorld )

    self.mWorld                  = iWorld
    self.mTerrain                = nil

    self.mFixedBackground        = nil
    self.mBackgrounds            = {}
    self.mForegrounds            = {}

    self.mHeros                  = {}
    self.mEnvironnementObjects   = {}

end

-- ==========================================Type


function  LevelBase.Type()
    return "LevelBase"
end


-- ==========================================Update/Draw


function  LevelBase:Update( iDT )

    for k,v in pairs( self.mBackgrounds ) do
        v:Update( iDT )
    end

    ObjectPool.Update( iDT )
    self.mWorld:update( iDT )
    CollidePool.Update( iDT )

    for k,v in pairs( self.mForegrounds ) do
        v:Update( iDT )
    end

    self:UpdateCamera()
end


function  LevelBase:Draw()

    self.mFixedBackground:Draw( 0, 0 )

    for k,v in pairs( self.mBackgrounds ) do
        v:Draw()
    end

    ObjectPool.Draw()

    for k,v in pairs( self.mForegrounds ) do
        v:Draw()
    end

end


-- ==========================================LevelBase functions


function  LevelBase:UpdateCamera()

    xAverage = 0

    for k,v in pairs( self.mHeros ) do
        x = v:GetX()
        xAverage = ( xAverage + x )
    end
    xAverage = xAverage / #self.mHeros

    Camera.x = xAverage - love.graphics.getWidth() / 2
    Camera.y = 0 --love.graphics.getHeight() / 2

end


-- ==========================================Collide CB


function  LevelBase.Collide( iCollider )
    -- do nothing
end


-- ==========================================Events


function LevelBase:KeyPressed( iKey, iScancode, iIsRepeat )

    for k,v in pairs( self.mHeros ) do
        v:KeyPressed( iKey, iScancode, iIsRepeat )
    end

end


function LevelBase:KeyReleased( iKey, iScancode )

    for k,v in pairs( self.mHeros ) do
        v:KeyReleased( iKey, iScancode )
    end

end


function  LevelBase:MousePressed( iX, iY, iButton, iIsTouch )
    --
end



return  LevelBase