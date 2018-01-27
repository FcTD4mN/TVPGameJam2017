ECSIncludes  = require "src/ECS/ECSIncludes"

MapTileA  = require "src/CommOp1/ECS/Factory/MapTileA"
MapTileR  = require "src/CommOp1/ECS/Factory/MapTileR"

local MapTileEntity = {}
MapTileEntity.mTypes = {}


-- ==========================================Build/Destroy

function MapTileEntity:Init()
    self:RegisterMapTileClass( MapTileA )
    self:RegisterMapTileClass( MapTileR )
end

function MapTileEntity:New( iTile )

    local class = MapTileEntity.mTypes[ iTile.mType ]
    local entity = class:New( iTile )

    return  entity

end

function MapTileEntity:RegisterMapTileClass( iClass )
    MapTileEntity.mTypes[iClass.mType] = iClass
end

return  MapTileEntity