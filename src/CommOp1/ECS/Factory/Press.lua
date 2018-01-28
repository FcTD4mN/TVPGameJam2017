ECSIncludes  = require "src/ECS/ECSIncludes"

local Press = {}
Press.mId = 0


-- ==========================================Build/Destroy


function Press:New( iFaction, iX, iY )
    local entity = Entity:New( "Press"..Press.mId )
    Press.mId = Press.mId + 1



    -- Components
    local factionComponent = FactionComponent:New( iFaction, 10, 0.01 )

    entity:AddComponent( factionComponent )
    entity:AddComponent( PositionComponent:New( iX, iY ) )
    entity:AddComponent( SizeComponent:New( gTileSize*5, gTileSize*3 ) )
    entity:AddComponent( RadiusComponent:New( 50 ) )
    entity:AddComponent( InfluencableRadiusComponent:New( 6 ) )
    entity:AddComponent( SelectableComponent:New() )

    ECSWorld:AddEntity( entity )

    return  entity
end


return  Press