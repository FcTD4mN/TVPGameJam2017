local ObjectPool    = require "src/Objects/Pools/ObjectPool"
local CollidePool   = require "src/Objects/Pools/CollidePool"
local RayPool       = require "src/Objects/Pools/RayPool"


local LevelBase = {}


-- ==========================================Build/Destroy


function LevelBase:New( iWorld, iCamera )

    newLevelBase = {}
    setmetatable( newLevelBase, LevelBase )
    LevelBase.__index = LevelBase

    newLevelBase:BuildLevelBase( iWorld, iCamera )

    return  newLevelBase
end


function  LevelBase:BuildLevelBase( iWorld, iCamera )

    self.mWorld                 = iWorld
    self.mTerrain               = nil
    self.mCamera                = iCamera
    self.mMiniMap               = nil

    self.mFixedBackground       = nil
    self.mBackgrounds           = {}
    self.mForegrounds           = {}

    self.mHeros                 = {}
    self.mEnvironnementObjects  = {}

end

-- ==========================================Type


function  LevelBase.Type()
    return "LevelBase"
end


-- ==========================================Update/Draw


function  LevelBase:Update( iDT )

    for k,v in pairs( self.mBackgrounds ) do
        v:Update( iDT, self.mCamera )
    end

    self.mWorld:update( iDT )
    CollidePool.Update( iDT )
    ObjectPool.Update( iDT )
    RayPool.Update( iDT )

    for k,v in pairs( self.mForegrounds ) do
        v:Update( iDT, self.mCamera )
    end

    self:UpdateCamera()
    if( self.mMiniMap ) then

        self:UpdateMiniMap()

    end

end


function  LevelBase:Draw()

    self.mFixedBackground:Draw( 0, 0 )

    for k,v in pairs( self.mBackgrounds ) do
        v:Draw( self.mCamera )
    end

    ObjectPool.Draw( self.mCamera )
    RayPool.Draw( self.mCamera )

    for k,v in pairs( self.mForegrounds ) do
        v:Draw( self.mCamera )
    end

    if( self.mMiniMap ) then

        self.mMiniMap:Draw()
        ObjectPool.DrawToMiniMap( self.mMiniMap.mCamera )
        -- RayPool.Draw( self.mMiniMap.mCamera )

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

    self.mCamera.mX = xAverage - love.graphics.getWidth() / 2
    self.mCamera.mY = 0 --love.graphics.getHeight() / 2

end


function  LevelBase:UpdateMiniMap()

    self.mMiniMap.mCamera.mX = self.mCamera.mX
    self.mMiniMap.mCamera.mY = self.mCamera.mY

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