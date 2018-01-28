ECSIncludes  = require "src/ECS/ECSIncludes"

local Mairie = {}
Mairie.mId = 0


-- ==========================================Build/Destroy


function Mairie:New( iFaction, iX, iY )
    local entity = Entity:New( "Mairie"..Mairie.mId )
    Mairie.mId = Mairie.mId + 1



    -- Components
    local factionComponent = FactionComponent:New( iFaction, 3, 0.2 )

    entity:AddComponent( factionComponent )
    entity:AddComponent( PositionComponent:New( iX, iY ) )
    entity:AddComponent( SizeComponent:New( gTileSize*5, gTileSize*3 ) )
    entity:AddComponent( RadiusComponent:New( 6 ) )
    entity:AddComponent( InfluencableRadiusComponent:New( 6 ) )
    entity:AddComponent( SelectableComponent:New() )

    ECSWorld:AddEntity( entity )

    return  entity
end


return  Mairie