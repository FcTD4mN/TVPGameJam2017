ECSIncludes  = require "src/ECS/ECSIncludes"

local MapTileWalkable = {}
MapTileWalkable.mId = 0
MapTileWalkable.mTypeSetIndex = "1"
MapTileWalkable.mPathPrefix = ""
MapTileWalkable.mPathSuffix = ".png"

-- ==========================================Build/Destroy

function MapTileWalkable:New( iTile )
    local entity = Entity:New( "MapTileWalkable".. MapTileWalkable.mId )
    MapTileWalkable.mId = MapTileWalkable.mId + 1
    
    entity:AddComponent( PositionComponent:New( iTile.mX, iTile.mY ) )
    quad = love.graphics.newQuad( iTile.mXInTileSet, iTile.mYInTileSet, iTile.mW, iTile.mH, iTile.mTileSetImage:getWidth(), iTile.mTileSetImage:getHeight() )
    entity:AddComponent( SpriteComponent:NewFromImage( iTile.mTileSetImage, quad ) )

    return  entity
end

function MapTileBasic:Type()
    return  "Walkable"
end

return  MapTileWalkable