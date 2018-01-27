MapTile = require "src/CommOp1/Map/MapTile"


local Map = {}
Map.mTiles = 0 --X/Y


-- ==========================================Build/Destroy


function Map:NewFromFile( iFile, iTileW, iTileH )
    local newMap = {}
    setmetatable( newMap, self )
    self.__index = self

    newMap.mTiles = {}

    newMap:LoadFromFile( iFile, iTileW, iTileH )

    return  newMap
end

function Map:LoadFromFile( iFile, iTileW, iTileH )
    local file, errorstr = love.filesystem.newFile( iFile, "r" )
    if not file:isOpen() then
        return
    end

    local x = 0
    local y = 0

    for line in file:lines() do
        local tiles = {}
        local pos = 1
        while pos <= string.len(line) do
            local sep1 = string.find( line, "-", pos  )
            local type = string.sub( line, pos, sep1 - 1 )
            local sep2 = string.find( line, ",", sep1 + 1 )
            local subtype = ""
            if sep2 == nil then
                subtype = string.sub( line, sep1 + 1 )
                pos = string.len(line) + 1
            else
                subtype = string.sub( line, sep1 + 1, sep2 - 1 )
                pos = sep2 + 1
            end
            local tile = MapTile:New( type, subtype, x, y )
            table.insert( tiles, tile )
            x = x + iTileW
        end
        x = 0
        y = y + iTileH
        table.insert( self.mTiles, tiles )
    end
    file:close()
end

return  Map