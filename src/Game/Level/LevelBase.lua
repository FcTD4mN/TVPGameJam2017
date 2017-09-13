local  Background   = require "src/Image/Background"
local  Camera       = require "src/Camera/Camera"
local  MiniMap      = require "src/Camera/MiniMap"
local  Terrain      = require "src/Objects/Terrain"

-- Pools
ObjectPool      = require "src/Objects/Pools/ObjectPool"
ObjectRegistry  = require "src/Base/ObjectRegistry"
CollidePool     = require "src/Objects/Pools/CollidePool"
RayPool         = require "src/Objects/Pools/RayPool"


local LevelBase = {}


-- ==========================================Build/Destroy


function LevelBase:New( iWorld, iCamera )

    newLevelBase = {}
    setmetatable( newLevelBase, LevelBase )
    LevelBase.__index = LevelBase

    newLevelBase:BuildLevelBase( iWorld, iCamera )

    return  newLevelBase
end


function LevelBase:NewFromXML( iNode, iWorld )
    local newLevelBase = {}
    setmetatable( newLevelBase, LevelBase )
    LevelBase.__index = LevelBase

    newLevelBase:LoadLevelBaseXML( iNode, iWorld )

    return newLevelBase
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

        self.mMiniMap:Draw( self.mCamera )
        ObjectPool.DrawToMiniMap( self.mMiniMap )

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

    if iKey == "s" and not iIsRepeat then
        xmlData = self:SaveLevelBaseXML()
        -- file = io.open( "Save/Level1.xml", "w" )
        file = io.open( "/home/damien/work2/Love2D/TVPGameJam2017/Save/Level1.xml", "w" )
        file:write( xmlData )
    end

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


-- ==========================================XML IO


function  LevelBase:SaveLevelBaseXML()

    xmlData = "<level>\n"

        -- STUFF
        xmlData = xmlData .. self.mTerrain:SaveTerrainXML()
        xmlData = xmlData .. self.mCamera:SaveCameraXML()
        xmlData = xmlData .. self.mMiniMap:SaveMiniMapXML()


        -- BACKGROUNDS
        -- xmlData = xmlData .. self.mFixedBackground:SaveXML() -- this is a bigimage

        xmlData = xmlData .. "<backgrounds>\n"
            for k,v in pairs( self.mBackgrounds ) do
                xmlData = xmlData .. v:SaveXML()
            end
        xmlData = xmlData .. "</backgrounds>\n"

        xmlData = xmlData .. "<foregrounds>\n"
            for k,v in pairs( self.mForegrounds ) do
                xmlData = xmlData .. v:SaveXML()
            end
        xmlData = xmlData .. "</foregrounds>\n"

        -- OBJECTS
        xmlData = xmlData .. "<objectpool>\n"
            for i = 1, ObjectPool.Count() do

                local obj = ObjectPool.ObjectAtIndex( i )
                xmlData = xmlData .. obj:SaveXML()
            end
        xmlData = xmlData .. "</objectpool>\n"

    xmlData = xmlData .. "</level>\n"

    return  xmlData

end


function  LevelBase:LoadLevelBaseXML( iNode, iWorld )

    assert( iNode.name == "level" )
    temp = iNode.el[ 1 ]

    self.mWorld     = iWorld
    Terrain.LoadTerrainXML( iNode.el[ 1 ], iWorld ) -- TODO: terrain shouldn't be singleton
    self.mTerrain   = Terrain
    self.mCamera    = Camera:NewFromXML( iNode.el[ 2 ] )
    self.mMiniMap   = MiniMap:NewFromXML( iNode.el[ 3 ] )

    self.mHeros         = {}
    self.mBackgrounds   = {}
    self.mForegrounds   = {}

    -- Node <backgrounds>
    for k,v in pairs( iNode.el[ 4 ].el ) do
        table.insert( self.mBackgrounds, Background:NewFromXML( v ) )
    end


    -- Node <foregrounds>
    for k,v in pairs( iNode.el[ 5 ].el ) do
        table.insert( self.mForegrounds, Background:NewFromXML( v ) )
    end


    -- Node <objectpool>
    for k,v in pairs( iNode.el[ 6 ].el ) do
        local obj = ObjectRegistry.CreateFromRegistry( v.name, v, iWorld )
        -- TODO: shouldn't heros ne only in pool as well ? and shouldn't pool forward all events to all objects ?
        if obj:Type() == "Singe" or obj:Type() == "Lapin" then
            table.insert( self.mHeros, obj )
        end
    end


end



return  LevelBase