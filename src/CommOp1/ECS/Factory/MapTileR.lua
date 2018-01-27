ECSIncludes  = require "src/ECS/ECSIncludes"

local MapTileR = {}
MapTileR.mId = 0
MapTileR.mType = "R"
MapTileR.mPathPrefix = ""
MapTileR.mPathSuffix = ".png"

-- ==========================================Build/Destroy

function MapTileR:New( iSubType, iX, iY )
    local entity = Entity:New( "MapTileR".. MapTileR.mId )
    MapTileR.mId = MapTileR.mId + 1
    
    entity:AddComponent( PositionComponent:New( iX, iY ) )
    entity:AddComponent( SpriteComponent:New( MapTileR.mPathPrefix..MapTileR.mType..iSubType..MapTileR.mPathSuffix ) )

    return  entity
end

function MapTileR:SetVisualType( iVisualType )
    MapTileR.mPathPrefix = "resources/CommOp1/Tiles/"..iVisualType.."/"
end

return  MapTileR