MapTile = require "src/CommOp1/Map/MapTile"


local Map = {}
Map.mTiles = 0 --X/Y


-- ==========================================Build/Destroy


function Map:NewFromFile( iFile )
    local newMap = {}
    setmetatable( newMap, self )
    self.__index = self

    newMap.mTiles = {}

    newMap:LoadFromFile( iFile )

    return  newMap
end

function Map:LoadFromFile( iFile )
    local file, errorstr = love.filesystem.newFile( iFile, "r" )
    if not file:isOpen() then
        return
    end

    for line in file:lines() then
        local tiles = {}
        local pos = 1
        while pos < string.len(s) then
            local tileindex = string.sub( line, pos, pos+1 )
            local tile = MapTile:NewFromIndex( tileindex )
            table.insert( tiles, tile )
            pos = pos + 3
        end
        table.insert( self.mTiles, tiles )
    end
    file:close()
end

return  Map