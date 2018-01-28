ECSIncludes  = require "src/ECS/ECSIncludes"

local MilitaryCamp = {}
MilitaryCamp.mId = 0


-- ==========================================Build/Destroy


function MilitaryCamp:New( iFaction, iX, iY )
    local entity = Entity:New( "MilitaryCamp"..MilitaryCamp.mId )
    MilitaryCamp.mId = MilitaryCamp.mId + 1



    -- Components
    local factionComponent = FactionComponent:New( iFaction, 80, 0.001 )

    entity:AddComponent( factionComponent )
    entity:AddComponent( PositionComponent:New( iX, iY ) )
    entity:AddComponent( SizeComponent:New( gTileSize*17, gTileSize*20 ) )
    entity:AddComponent( RadiusComponent:New( 50 ) )
    entity:AddComponent( InfluencableRadiusComponent:New( 20 ) )
    entity:AddComponent( SelectableComponent:New() )

    ECSWorld:AddEntity( entity )

    return  entity
end


return  MilitaryCamp