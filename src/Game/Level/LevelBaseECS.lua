local  Background   = require "src/Image/Background"
local  Camera       = require "src/Camera/Camera"
local  MiniMap      = require "src/Camera/MiniMap"
local  Terrain      = require "src/Objects/Terrain"

-- Pools
ObjectRegistry  = require "src/Base/ObjectRegistry"
ECSIncludes     = require "src/ECS/ECSIncludes"
CollidePool     = require "src/Objects/Pools/CollidePool"
RayPool         = require "src/Objects/Pools/RayPool"


local LevelBaseECS = {}


-- ==========================================Build/Destroy


function LevelBaseECS:New( iWorld, iCamera )

    newLevelBaseECS = {}
    setmetatable( newLevelBaseECS, LevelBaseECS )
    LevelBaseECS.__index = LevelBaseECS

    newLevelBaseECS:BuildLevelBaseECS( iWorld, iCamera )

    return  newLevelBaseECS
end


function LevelBaseECS:NewFromXML( iNode, iWorld )
    local newLevelBaseECS = {}
    setmetatable( newLevelBaseECS, LevelBaseECS )
    LevelBaseECS.__index = LevelBaseECS

    newLevelBaseECS:LoadLevelBaseECSXML( iNode, iWorld )

    return newLevelBaseECS
end


function  LevelBaseECS:BuildLevelBaseECS( iWorld, iCamera )

    self.mWorld                 = iWorld
    self.mWorldECS              = ECSWorld
    self.mTerrain               = nil
    self.mCamera                = iCamera
    self.mMiniMap               = nil

    self.mFixedBackground       = nil
    self.mBackgrounds           = {}
    self.mForegrounds           = {}

    self.mHeros                 = {}
end

-- ==========================================Type


function  LevelBaseECS.Type()
    return "LevelBaseECS"
end


-- ==========================================Update/Draw


function  LevelBaseECS:Update( iDT )

    for k,v in pairs( self.mBackgrounds ) do
        v:Update( iDT, self.mCamera )
    end

    self.mWorld:update( iDT )

    if( self.mWorldECS ) then
        self.mWorldECS:Update( iDT )
    end

    -- Still usefull ?
    CollidePool.Update( iDT )
    RayPool.Update( iDT )
    -- ===============

    for k,v in pairs( self.mForegrounds ) do
        v:Update( iDT, self.mCamera )
    end

    self:UpdateCamera()
    if( self.mMiniMap ) then

        self:UpdateMiniMap()

    end

end


function  LevelBaseECS:Draw( iCamera )

    local camera = self.mCamera
    if( iCamera ) then
        camera = iCamera
    end

    if( self.mFixedBackground ) then
        self.mFixedBackground:Draw( 0, 0, camera.mScale )
    end

    for k,v in pairs( self.mBackgrounds ) do
        v:Draw( camera )
    end

    if( self.mWorldECS ) then
        self.mWorldECS:Draw( camera )
    end
    RayPool.Draw( camera )

    for k,v in pairs( self.mForegrounds ) do
        v:Draw( camera )
    end

    if( self.mMiniMap ) then

        self.mMiniMap:Draw( camera )
        ObjectPool.DrawToMiniMap( self.mMiniMap )

    end

end


-- ==========================================LevelBaseECS functions


function  LevelBaseECS:UpdateCamera()
    -- Nothing here
end


function  LevelBaseECS:UpdateMiniMap()

    self.mMiniMap.mCamera.mX = self.mCamera.mX
    self.mMiniMap.mCamera.mY = self.mCamera.mY

end


-- ==========================================Collide CB


function  LevelBaseECS.Collide( iCollider )
    -- do nothing
end


-- ==========================================Events


function LevelBaseECS:KeyPressed( iKey, iScancode, iIsRepeat )

    self.mWorldECS:KeyPressed( iKey, iScancode, iIsRepeat )

end


function LevelBaseECS:KeyReleased( iKey, iScancode )

    self.mWorldECS:KeyReleased( iKey, iScancode )

end


function  LevelBaseECS:MousePressed( iX, iY, iButton, iIsTouch )
    --
end


-- ==========================================XML IO


function  LevelBaseECS:SaveLevelBaseECSXML()

    xmlData = "<level>\n"

        -- STUFF
        xmlData = xmlData .. self.mTerrain:SaveTerrainXML()
        xmlData = xmlData .. self.mCamera:SaveCameraXML()

        if self.mMiniMap then
            xmlData = xmlData .. self.mMiniMap:SaveMiniMapXML()
        end


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
        xmlData = xmlData .. self.mWorldECS:SaveXML()
    xmlData = xmlData .. "</level>\n"

    return  xmlData
end


function  LevelBaseECS:LoadLevelBaseECSXML( iNode, iWorld )

    assert( iNode.name == "level" )

    elIndex = 1

    self.mWorld     = iWorld
    Terrain.LoadTerrainXML( iNode.el[ elIndex ], iWorld ) -- TODO: terrain shouldn't be singleton
    elIndex = elIndex + 1
    self.mTerrain   = Terrain
    self.mCamera    = Camera:NewFromXML( iNode.el[ elIndex ] )
    elIndex = elIndex + 1

    if iNode.el[ elIndex ].name =="minimap" then
        -- self.mMiniMap   = MiniMap:NewFromXML( iNode.el[ elIndex ] )
        elIndex = elIndex + 1
    end

    self.mHeros         = {}
    self.mBackgrounds   = {}
    self.mForegrounds   = {}

    -- Node <backgrounds>
    for k,v in pairs( iNode.el[ elIndex ].el ) do
        table.insert( self.mBackgrounds, Background:NewFromXML( v ) )
    end
    elIndex = elIndex + 1

    -- Node <foregrounds>
    for k,v in pairs( iNode.el[ elIndex ].el ) do
        table.insert( self.mForegrounds, Background:NewFromXML( v ) )
    end
    elIndex = elIndex + 1

    -- Node <objectpool>
    for k,v in pairs( iNode.el[ elIndex ].el ) do
        local obj = ObjectRegistry.CreateFromRegistry( v.name, v, iWorld )
        -- TODO: shouldn't heros ne only in pool as well ? and shouldn't pool forward all events to all objects ?
        if obj:Type() == "Singe" or obj:Type() == "Lapin" then
            table.insert( self.mHeros, obj )
        end
    end
    elIndex = elIndex + 1

    --ECSWorld
    self.mWorldECS = ECSWorld
    ECSWorld:LoadECSWorldXML( iNode.el[ elIndex ], iWorld )
    elIndex = elIndex + 1

end



return  LevelBaseECS