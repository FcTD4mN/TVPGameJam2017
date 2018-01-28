ECSIncludes  = require "src/ECS/ECSIncludes"

local Eglise = {}
Eglise.mId = 0


-- ==========================================Build/Destroy


function Eglise:New( iFaction, iX, iY, iW, iH )
    local entity = Entity:New( "Eglise"..Eglise.mId )
    Eglise.mId = Eglise.mId + 1

    -- Components
    local factionComponent = FactionComponent:New( iFaction, 5, 0.10 )

    entity:AddComponent( factionComponent )
    entity:AddComponent( PositionComponent:New( iX, iY ) )
    entity:AddComponent( SizeComponent:New( iW, iH ) )
    entity:AddComponent( RadiusComponent:New( 6 ) )
    entity:AddComponent( InfluencableRadiusComponent:New( 12 ) )
    entity:AddComponent( SelectableComponent:New() )

    ECSWorld:AddEntity( entity )

    return  entity
end


return  Eglise