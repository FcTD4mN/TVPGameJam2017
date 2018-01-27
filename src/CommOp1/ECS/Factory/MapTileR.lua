ECSIncludes  = require "src/ECS/ECSIncludes"

local MapTileR = {}
MapTileR.mId = 0
MapTileR.mType = "1"
MapTileR.mPathPrefix = ""
MapTileR.mPathSuffix = ".png"

-- ==========================================Build/Destroy

function MapTileR:New( iTile )
    local entity = Entity:New( "MapTileR".. MapTileR.mId )
    MapTileR.mId = MapTileR.mId + 1
    
    entity:AddComponent( PositionComponent:New( iTile.mX, iTile.mY ) )
    quad = love.graphics.newQuad( iTile.mXInTileSet, iTile.mYInTileSet, iTile.mW, iTile.mH, iTile.mTileSetImage:getWidth(), iTile.mTileSetImage:getHeight() )
    entity:AddComponent( SpriteComponent:NewFromImage( iTile.mTileSetImage, quad ) )

    return  entity
end

return  MapTileR