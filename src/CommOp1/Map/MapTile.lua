ImageLoader = require "src/Image/ImageLoader"

local MapTile = {}
MapTile.mType = ""
MapTile.mSubType = ""
MapTile.mX = 0
MapTile.mY = 0


-- ==========================================Build/Destroy


function MapTile:New( iType, iSubType, iX, iY )
    local newMapTile = {}
    setmetatable( newMapTile, self )
    self.__index = self

    newMapTile.mType = iType
    newMapTile.mSubType = iSubType
    newMapTile.mX = iX
    newMapTile.mY = iY

    return  newMapTile
end

return  MapTile