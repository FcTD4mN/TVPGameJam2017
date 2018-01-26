ImageLoader = require "src/Image/ImageLoader"

local MapTile = {}
MapTile.mIndex = ""
MapTile.mImage = nil


-- ==========================================Build/Destroy


function MapTile:NewFromIndex( iIndex )
    local newMapTile = {}
    setmetatable( newMapTile, self )
    self.__index = self

    newMapTile.mIndex = iIndex
    newMapTile.mImage = ImageLoader.LoadSimpleImage( "resources/CommOp1/MapTiles/"..iIndex..".png" )

    return  newMapTile
end

return  MapTile