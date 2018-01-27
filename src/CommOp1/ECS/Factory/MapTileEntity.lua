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

function MapTileEntity:New( iType, iSubType, iX, iY )

    local class = MapTileEntity.mTypes[iType]
    local entity = class:New( iSubType, iX, iY )

    return  entity

end

function MapTileEntity:SetGlobalVisualType( iVisualType )
    for k,v in pairs( MapTileEntity.mTypes ) do
        v:SetVisualType( iVisualType )
    end
end

function MapTileEntity:SetVisualTypeForTileType( iVisualType, iTileType )
    MapTileEntity.mTypes[ iTileType ]:SetVisualType( iVisualType )
end

function MapTileEntity:RegisterMapTileClass( iClass )
    MapTileEntity.mTypes[iClass.mType] = iClass
end

return  MapTileEntity