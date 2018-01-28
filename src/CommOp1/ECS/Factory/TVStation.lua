ECSIncludes  = require "src/ECS/ECSIncludes"

local TVStation = {}
TVStation.mId = 0


-- ==========================================Build/Destroy


function TVStation:New( iFaction, iX, iY )
    local entity = Entity:New( "TVStation"..TVStation.mId )
    TVStation.mId = TVStation.mId + 1



    -- Components
    local factionComponent = FactionComponent:New( iFaction, 50, 0.00001 )

    entity:AddComponent( factionComponent )
    entity:AddComponent( PositionComponent:New( iX, iY ) )
    entity:AddComponent( SizeComponent:New( gTileSize*5, gTileSize*3 ) )
    entity:AddComponent( RadiusComponent:New( 500 ) )
    entity:AddComponent( InfluencableRadiusComponent:New( 6 ) )
    entity:AddComponent( SelectableComponent:New() )

    ECSWorld:AddEntity( entity )

    return  entity
end


return  TVStation