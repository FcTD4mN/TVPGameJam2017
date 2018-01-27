local  Map       = require "src/CommOp1/Map/Map"
local  Camera    = require "src/Camera/Camera"

-- Pools
                  require "src/CommOp1/ECS/ECSIncludes"
MapTileEntity   = require "src/CommOp1/ECS/Factory/MapTileEntity"


local LevelBase = {}


-- ==========================================Build/Destroy


function  LevelBase:InitializeLevelBase( iMapFile, iVisualType )

    self.mWorldECS              = ECSWorld
    self.mCamera                = Camera:New( 0, 0, 800, 600, 1.0 )
    self.mMap                   = Map:NewFromFile( iMapFile, 80, 80 )

    self.mWorldECS:AddSystem( SpriteRenderer )

    MapTileEntity:SetGlobalVisualType( iVisualType )
    self:GenerateMapEntities()

end

-- ==========================================Type


function  LevelBase.Type()
    return "LevelBase"
end


-- ==========================================Update/Draw


function  LevelBase:UpdateLevelBase( iDT )

    self.mWorldECS:Update( iDT )

end


function  LevelBase:DrawLevelBase()

    self.mWorldECS:Draw( self.mCamera )

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
    self.mWorldECS:KeyReleased( iKey, iScancode )
end


function LevelBase:MouseMoved( iX, iY )
    self.mWorldECS:MouseMoved( iX, iY )
end


function LevelBase:MouseReleased( iX, iY, iButton, iIsTouch )
    self.mWorldECS:MouseReleased( iX, iY, iButton, iIsTouch )
end


function LevelBase:WheelMoved( iX, iY )
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