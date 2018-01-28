ECSIncludes  = require "src/ECS/ECSIncludes"

local Bank = {}
Bank.mId = 0


-- ==========================================Build/Destroy


function Bank:New( iFaction, iX, iY )
    local entity = Entity:New( "Bank"..Bank.mId )
    Bank.mId = Bank.mId + 1



    -- Components
    local factionComponent = FactionComponent:New( iFaction, 8, 0.2 )

    entity:AddComponent( factionComponent )
    entity:AddComponent( PositionComponent:New( iX, iY ) )
    entity:AddComponent( SizeComponent:New( gTileSize*5, gTileSize*3 ) )
    entity:AddComponent( RadiusComponent:New( 12 ) )
    entity:AddComponent( InfluencableRadiusComponent:New( 6 ) )
    entity:AddComponent( SelectableComponent:New() )

    ECSWorld:AddEntity( entity )

    return  entity
end


return  Bank