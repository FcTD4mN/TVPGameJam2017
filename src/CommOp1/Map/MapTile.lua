ImageLoader = require "src/Image/ImageLoader"

local MapTile = {}
MapTile.mType = 0
MapTile.mX = 0
MapTile.mY = 0
MapTile.mTileSetImage = 0
MapTile.mTypeSetImage = 0
MapTile.mXInTileSet = 0
MapTile.mYInTileSet = 0
MapTile.mW = 0
MapTile.mH = 0


-- ==========================================Build/Destroy

function MapTile:New( iType, iX, iY, iTileSetImage, iW, iH, iTileNum )
    local newMapTile = {}
    setmetatable( newMapTile, self )
    self.__index = self

    newMapTile.mType = iType
    newMapTile.mX = iX
    newMapTile.mY = iY
    newMapTile.mTileSetImage = iTileSetImage
    newMapTile.mXInTileSet = ( iTileNum % ( iTileSetImage:getWidth() / iW ) ) * iW
    newMapTile.mYInTileSet = math.floor( iTileNum / ( iTileSetImage:getWidth() / iW ) ) * iH
    newMapTile.mW = iW
    newMapTile.mH = iH

    return  newMapTile
end

return  MapTile