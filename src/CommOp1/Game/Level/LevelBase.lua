local  Map       = require "src/CommOp1/Map/Map"
local  Camera    = require "src/Camera/Camera"

-- Pools
                  require "src/CommOp1/ECS/ECSIncludes"
MapTileEntity   = require "src/CommOp1/ECS/Factory/MapTileEntity"


local LevelBase = {}


-- ==========================================Build/Destroy


function  LevelBase:InitializeLevelBase( iMapFile, iTileSetFile, iTypeSetFile )

    self.mWorldECS              = ECSWorld
    gCamera                     = Camera:New( 0, 0, 800, 600, 1.0 )
    gNodeList                   = {}
    gConnections                = {}
    gPrecomputedNodeSequences   = {}
    gTileSize                   = 80
    gFaction                    = ""
    gGameSpeed                  = 1
    self.mEditCameraState       = 0
    self.mEditCameraDownTime    = 0

    self.mEditCameraOrigin      = {}
    self.mEditCameraOriginX   = 0
    self.mEditCameraOriginY   = 0
    self.mClickOriginX   = 0
    self.mClickOriginY   = 0
    self.mClickPosX   = 0
    self.mClickPosY   = 0

    self.mMap                   = Map:NewFromFile( iMapFile, iTileSetFile, iTypeSetFile, 80, 80 )

    self.mWorldECS:AddSystem( SkillBarLayoutSystem )
    self.mWorldECS:AddSystem( ClickableSystem )
    self.mWorldECS:AddSystem( CharacterController )

    self.mWorldECS:AddSystem( FactionInfluenceSystem )
    self.mWorldECS:AddSystem( FactionConversionSystem )

    self.mWorldECS:AddSystem( SpriteRenderer )
    self.mWorldECS:AddSystem( AnimationRenderer )
    self.mWorldECS:AddSystem( InfluenceDrawer )
    self.mWorldECS:AddSystem( BuildingFactionDrawer )
    self.mWorldECS:AddSystem( SelectionDrawer )
    self.mWorldECS:AddSystem( RadiusDrawer )
    self.mWorldECS:AddSystem( SelectionSystem ) --renders itself so it needs to be after Sprite renderer
    self.mWorldECS:AddSystem( DestinationDrawer )
    self.mWorldECS:AddSystem( SpriteRendererGUI )
    self.mWorldECS:AddSystem( GUITopBarDrawer )
    self:GenerateMapEntities()

end

-- ==========================================Type


function  LevelBase.Type()
    return "LevelBase"
end


-- ==========================================Update/Draw


function  LevelBase:UpdateLevelBase( iDT )

    if self.mEditCameraState > 0 then
        gCamera.mX = self.mEditCameraOriginX - (self.mClickPosX - self.mClickOriginX ) / gCamera.mScale
        gCamera.mY = self.mEditCameraOriginY - (self.mClickPosY - self.mClickOriginY) / gCamera.mScale
    end
    self.mWorldECS:Update( iDT * gGameSpeed )

end


function  LevelBase:DrawLevelBase()

    self.mWorldECS:Draw( gCamera )

end


-- ==========================================Events


function LevelBase:TextInput( iT )
    return  self.mWorldECS:TextInput( iT )
end


function LevelBase:KeyPressed( iKey, iScancode, iIsRepeat )
    return  self.mWorldECS:KeyPressed( iKey, iScancode, iIsRepeat )
end


function LevelBase:KeyReleased( iKey, iScancode )
    return  self.mWorldECS:KeyReleased( iKey, iScancode )
end


function  LevelBase:MousePressed( iX, iY, iButton, iIsTouch )
    if self.mWorldECS:MousePressed( iX, iY, iButton, iIsTouch ) then
        return  true
    end
    if iButton == 2 then
        self.mEditCameraState = 1
        self.mEditCameraDownTime = love.timer.getTime()
        self.mEditCameraOriginX = gCamera.mX
        self.mEditCameraOriginY = gCamera.mY
        self.mClickOriginX = iX
        self.mClickOriginY = iY
        self.mClickPosX = iX
        self.mClickPosY = iY
    end
    return  false
end


function LevelBase:MouseMoved( iX, iY )

    if self.mEditCameraState > 0 then
        self.mClickPosX = iX
        self.mClickPosY = iY

        if (self.mEditCameraState > 1)
            or (love.timer.getTime() - self.mEditCameraDownTime > 0.25)
            or (math.abs( self.mClickPosX - self.mClickOriginX ) > 20)
            or (math.abs( self.mClickPosY - self.mClickOriginY ) > 20) then

            self.mEditCameraState = 2
            return  true
        end

    end

    if self.mWorldECS:MouseMoved( iX, iY ) then
        return  true
    end

    return  false
end


function LevelBase:MouseReleased( iX, iY, iButton, iIsTouch )
    if self.mEditCameraState > 0 then
        local shouldReturn = self.mEditCameraState > 1 or love.timer.getTime() - self.mEditCameraDownTime > 0.25
        if iButton == 2 then
            self.mEditCameraState = 0
        end

        if shouldReturn then
            return  true
        end
    end
    return  self.mWorldECS:MouseReleased( iX, iY, iButton, iIsTouch )
end


function LevelBase:WheelMoved( iX, iY )
    if self.mWorldECS:WheelMoved( iX, iY ) then
        return  true
    end
    gCamera.mScale = gCamera.mScale * math.pow( 1.05, iY )
    return  true
end


-- ========================================== Functions
function  LevelBase:GenerateMapEntities()
    for i=1, #self.mMap.mTiles do
        local line = self.mMap.mTiles[i]
        for j=1, #line do
            local tile = line[j]
            local entity = MapTileEntity:New( tile )
            self.mWorldECS:AddEntity( entity )
        end
    end
end

return  LevelBase