ECSIncludes  = require "src/ECS/ECSIncludes"

MapTileBasic  = require "src/CommOp1/ECS/Factory/MapTileBasic"
MapTileWalkable  = require "src/CommOp1/ECS/Factory/MapTileWalkable"

local MapTileEntity = {}
MapTileEntity.mTypes = {}


-- ==========================================Build/Destroy

function MapTileEntity:Init()
    self:RegisterMapTileClass( MapTileBasic )
    self:RegisterMapTileClass( MapTileWalkable )
end

function MapTileEntity:New( iTile )

    local class = MapTileEntity.mTypes[ iTile.mTypeSetIndex ]
    if not class then
        return MapTileBasic:New( iTile )
    end
    local entity = class:New( iTile )

    return  entity

end

function MapTileEntity:RegisterMapTileClass( iClass )
    MapTileEntity.mTypes[iClass.mTypeSetIndex] = iClass
end

return  MapTileEntity