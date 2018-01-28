ECSIncludes  = require "src/ECS/ECSIncludes"

local GareSNCF = {}
GareSNCF.mId = 0


-- ==========================================Build/Destroy


function GareSNCF:New( iFaction, iX, iY )
    local entity = Entity:New( "GareSNCF"..GareSNCF.mId )
    GareSNCF.mId = GareSNCF.mId + 1



    -- Components
    local factionComponent = FactionComponent:New( iFaction, 1, 0.8 )

    entity:AddComponent( factionComponent )
    entity:AddComponent( PositionComponent:New( iX, iY ) )
    entity:AddComponent( SizeComponent:New( gTileSize*5, gTileSize*3 ) )
    entity:AddComponent( RadiusComponent:New( 15 ) )
    entity:AddComponent( InfluencableRadiusComponent:New( 6 ) )
    entity:AddComponent( SelectableComponent:New() )

    ECSWorld:AddEntity( entity )

    return  entity
end


return  GareSNCF