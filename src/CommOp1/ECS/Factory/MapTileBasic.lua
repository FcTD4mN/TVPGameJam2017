ECSIncludes  = require "src/ECS/ECSIncludes"

local MapTileBasic = {}
MapTileBasic.mId = 0
MapTileBasic.mTypeSetIndex = "0"
MapTileBasic.mPathPrefix = ""
MapTileBasic.mPathSuffix = ".png"

-- ==========================================Build/Destroy

function MapTileBasic:New( iTile )
    local entity = Entity:New( "MapTileBasic".. MapTileBasic.mId )
    MapTileBasic.mId = MapTileBasic.mId + 1
    
    entity:AddComponent( PositionComponent:New( iTile.mX, iTile.mY ) )

    local quad = love.graphics.newQuad( iTile.mXInTileSet, iTile.mYInTileSet, iTile.mW, iTile.mH, iTile.mTileSetImage:getWidth(), iTile.mTileSetImage:getHeight() )
    entity:AddComponent( SpriteComponent:NewFromImage( iTile.mTileSetImage, quad ) )

    return  entity
end

function MapTileBasic:Type()
    return  "Basic"
end

return  MapTileBasic