ECSIncludes  = require "src/ECS/ECSIncludes"

local WacDo = {}
WacDo.mId = 0


-- ==========================================Build/Destroy


function WacDo:New( iFaction, iX, iY )
    local entity = Entity:New( "WacDo"..WacDo.mId )
    WacDo.mId = WacDo.mId + 1



    -- Components
    local factionComponent = FactionComponent:New( iFaction, 3, 0.3 )

    entity:AddComponent( factionComponent )
    entity:AddComponent( PositionComponent:New( iX, iY ) )
    entity:AddComponent( SizeComponent:New( gTileSize*4, gTileSize*3 ) )
    entity:AddComponent( RadiusComponent:New( 6 ) )
    entity:AddComponent( InfluencableRadiusComponent:New( 6 ) )
    entity:AddComponent( SelectableComponent:New() )

    ECSWorld:AddEntity( entity )

    return  entity
end


return  WacDo