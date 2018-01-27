ECSIncludes  = require "src/ECS/ECSIncludes"

local MapTileA = {}
MapTileA.mId = 0
MapTileA.mType = "A"
MapTileA.mPathPrefix = ""
MapTileA.mPathSuffix = ".png"

-- ==========================================Build/Destroy

function MapTileA:New( iSubType, iX, iY )
    local entity = Entity:New( "MapTileA".. MapTileA.mId )
    MapTileA.mId = MapTileA.mId + 1
    
    entity:AddComponent( PositionComponent:New( iX, iY ) )
    entity:AddComponent( SpriteComponent:New( MapTileA.mPathPrefix..MapTileA.mType..iSubType..MapTileA.mPathSuffix ) )

    return  entity
end

function MapTileA:SetVisualType( iVisualType )
    MapTileA.mPathPrefix = "resources/CommOp1/Tiles/"..iVisualType.."/"
end

return  MapTileA