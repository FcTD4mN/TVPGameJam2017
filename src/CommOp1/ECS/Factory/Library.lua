ECSIncludes  = require "src/ECS/ECSIncludes"

local Library = {}
Library.mId = 0


-- ==========================================Build/Destroy


function Library:New( iFaction, iX, iY )
    local entity = Entity:New( "Library"..Library.mId )
    Library.mId = Library.mId + 1



    -- Components
    local factionComponent = FactionComponent:New( iFaction )

    entity:AddComponent( factionComponent )
    entity:AddComponent( PositionComponent:New( iX, iY ) )
    entity:AddComponent( SizeComponent:New( gTileSize*4, gTileSize*4 ) )
    entity:AddComponent( RadiusComponent:New( 12 ) )
    entity:AddComponent( SelectableComponent:New() )

    ECSWorld:AddEntity( entity )

    return  entity
end


return  Library