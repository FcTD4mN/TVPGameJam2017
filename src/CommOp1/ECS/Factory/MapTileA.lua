ECSIncludes  = require "src/ECS/ECSIncludes"

local MapTileA = {}
MapTileA.mId = 0
MapTileA.mType = "0"
MapTileA.mPathPrefix = ""
MapTileA.mPathSuffix = ".png"

-- ==========================================Build/Destroy

function MapTileA:New( iTile )
    local entity = Entity:New( "MapTileA".. MapTileA.mId )
    MapTileA.mId = MapTileA.mId + 1
    
    entity:AddComponent( PositionComponent:New( iTile.mX, iTile.mY ) )

    local quad = love.graphics.newQuad( iTile.mXInTileSet, iTile.mYInTileSet, iTile.mW, iTile.mH, iTile.mTileSetImage:getWidth(), iTile.mTileSetImage:getHeight() )
    entity:AddComponent( SpriteComponent:NewFromImage( iTile.mTileSetImage, quad ) )

    return  entity
end

return  MapTileA