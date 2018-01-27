local  Map       = require "src/CommOp1/Map/Map"
local  Camera    = require "src/Camera/Camera"

-- Pools
                  require "src/CommOp1/ECS/ECSIncludes"
MapTileEntity   = require "src/CommOp1/ECS/Factory/MapTileEntity"


local LevelBase = {}


-- ==========================================Build/Destroy


function  LevelBase:InitializeLevelBase( iMapFile, iVisualType )

    self.mWorldECS              = ECSWorld
    gCamera                     = Camera:New( 0, 0, 800, 600, 1.0 )
    self.mEditCamera            = false
    self.mEditCameraOrigin      = {}
    self.mEditCameraOrigin.mX   = 0
    self.mEditCameraOrigin.mY   = 0
    self.mEditCameraDelta       = {}
    self.mEditCameraDelta.mX    = 0
    self.mEditCameraDelta.mY    = 0
    self.mMap                   = Map:NewFromFile( iMapFile, 80, 80 )

    self.mWorldECS:AddSystem( SpriteRenderer )
    self.mWorldECS:AddSystem( InputConverter )
    self.mWorldECS:AddSystem( CharacterController )
    self.mWorldECS:AddSystem( DestinationDrawer )

    MapTileEntity:SetGlobalVisualType( iVisualType )
    self:GenerateMapEntities()

end

-- ==========================================Type


function  LevelBase.Type()
    return "LevelBase"
end


-- ==========================================Update/Draw


function  LevelBase:UpdateLevelBase( iDT )

    if self.mEditCamera then
        gCamera.mX = gCamera.mX + self.mEditCameraDelta.mX * iDT
        gCamera.mY = gCamera.mY + self.mEditCameraDelta.mY * iDT
    end
    self.mWorldECS:Update( iDT )

end


function  LevelBase:DrawLevelBase()

    self.mWorldECS:Draw( gCamera )

end


-- ==========================================Events


function LevelBase:TextInput( iT )
    self.mWorldECS:TextInput( iT )
end


function LevelBase:KeyPressed( iKey, iScancode, iIsRepeat )
    self.mWorldECS:KeyPressed( iKey, iScancode, iIsRepeat )
end


function LevelBase:KeyReleased( iKey, iScancode )
    self.mWorldECS:KeyReleased( iKey, iScancode )
end


function  LevelBase:MousePressed( iX, iY, iButton, iIsTouch )
    if iButton == 2 then
        self.mEditCamera = true
        self.mEditCameraOrigin.mX = iX
        self.mEditCameraOrigin.mY = iY
        self.mEditCameraDelta.mX = 0
        self.mEditCameraDelta.mY = 0
    end
    self.mWorldECS:MousePressed( iX, iY, iButton, iIsTouch )
end


function LevelBase:MouseMoved( iX, iY )
    if self.mEditCamera then
        self.mEditCameraDelta.mX = ( iX - self.mEditCameraOrigin.mX ) / gCamera.mScale
        self.mEditCameraDelta.mY = ( iY - self.mEditCameraOrigin.mY ) / gCamera.mScale
    end
    self.mWorldECS:MouseMoved( iX, iY )
end


function LevelBase:MouseReleased( iX, iY, iButton, iIsTouch )
    if iButton == 2 then
        self.mEditCamera = false
    end

    self.mWorldECS:MouseReleased( iX, iY, iButton, iIsTouch )
end


function LevelBase:WheelMoved( iX, iY )
    print( "===" )
    print( iX )
    print( iY )
    print( gCamera.mScale )
    gCamera.mScale = gCamera.mScale * math.pow( 1.05, iY )
    print( gCamera.mScale )
    self.mWorldECS:WheelMoved( iX, iY )
end


-- ========================================== Functions
function  LevelBase:GenerateMapEntities()
    for i=1, #self.mMap.mTiles do
        local line = self.mMap.mTiles[i]
        for j=1, #line do
            local tile = line[j]
            local entity = MapTileEntity:New( tile.mType, tile.mSubType, tile.mX, tile.mY )
            self.mWorldECS:AddEntity( entity )
        end
    end
end

return  LevelBase