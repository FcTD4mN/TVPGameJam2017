ECSIncludes  = require "src/ECS/ECSIncludes"

local Radio = {}
Radio.mId = 0


-- ==========================================Build/Destroy


function Radio:New( iFaction, iX, iY )
    local entity = Entity:New( "Radio"..Radio.mId )
    Radio.mId = Radio.mId + 1



    -- Components
    local factionComponent = FactionComponent:New( iFaction, 20, 0.001 )

    entity:AddComponent( factionComponent )
    entity:AddComponent( PositionComponent:New( iX, iY ) )
    entity:AddComponent( SizeComponent:New( gTileSize*5, gTileSize*3 ) )
    entity:AddComponent( RadiusComponent:New( 100 ) )
    entity:AddComponent( InfluencableRadiusComponent:New( 6 ) )
    entity:AddComponent( SelectableComponent:New() )

    ECSWorld:AddEntity( entity )

    return  entity
end


return  Radio