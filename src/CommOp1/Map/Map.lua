MapTile = require "src/CommOp1/Map/MapTile"
ImageLoader = require "src/Image/ImageLoader"


local Map = {}
Map.mTiles = 0 --X/Y


-- ==========================================Build/Destroy


function Map:NewFromFile( iFile, iTileSetFile, iTypeSetFile, iTileW, iTileH )
    local newMap = {}
    setmetatable( newMap, self )
    self.__index = self

    newMap.mTiles = {}

    newMap:LoadFromFile( iFile, iTileSetFile, iTypeSetFile, iTileW, iTileH )

    return  newMap
end

function Map:LoadFromFile( iMapFile, iTileSetFile, iTypeSetFile, iTileW, iTileH )
    local mapfile = love.filesystem.newFile( iMapFile, "r" )
    local typesetfile = love.filesystem.newFile( iTypeSetFile, "r" )

    print( iTileSetFile )
    local tilesetimage = ImageLoader.LoadSimpleImage( iTileSetFile )

    local x = 0
    local y = 0

    -- go through the map
    local typelines = typesetfile:lines()
    for mapline in mapfile:lines() do
        local typeline = typelines() --iterator
        local tiles = {}
        local typepos = 1
        local mappos = 1
        while mappos <= string.len(mapline) do

            --read in mapfile
            local mapsep = string.find( mapline, ",", mappos )
            local tilenum = ""
            if mapsep == nil then
                tilenum = string.sub( mapline, mappos )
                mappos = string.len(mapline) + 1
            else
                tilenum = string.sub( mapline, mappos, mapsep - 1 )
                mappos = mapsep + 1
            end

            --read in typesetfile
            local typesep = string.find( typeline, ",", typepos )
            local type = ""
            if typesep == nil then
                type = string.sub( typeline, typepos )
                typepos = string.len(typeline) + 1
            else
                type = string.sub( typeline, typepos, typesep - 1 )
                typepos = typesep + 1
            end

            tilenum = tonumber( tilenum )
            if tilenum ~= -1 then
                local tile = MapTile:New( type, x, y, tilesetimage, iTileW, iTileH, tilenum )
                table.insert( tiles, tile )
            end
            x = x + iTileW
        end
        x = 0
        y = y + iTileH
        table.insert( self.mTiles, tiles )
    end
    mapfile:close()
    typesetfile:close()
end

return  Map