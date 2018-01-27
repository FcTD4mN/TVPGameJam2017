ECSIncludes  = require "src/ECS/ECSIncludes"

local Character = {}
Character.mId = 0


-- ==========================================Build/Destroy


function Character:New( iFaction, iX, iY, iSelectable )
    local entity = Entity:New( "Character"..Character.mId )
    Character.mId = Character.mId + 1



    -- Components
    local factionComponent = FactionComponent:New( iFaction )

    entity:AddComponent( factionComponent )
    entity:AddComponent( PositionComponent:New( iX, iY ) )
    entity:AddComponent( DestinationComponent:New() )
    entity:AddComponent( UserInputComponent:New() )

    local minspeed = 3
    local maxspeed = 5
    entity:AddComponent( SpeedComponent:New( math.random() * ( maxspeed - minspeed ) + minspeed ) )
    if iSelectable then
        entity:AddComponent( SelectableComponent:New() )
    end
    entity:AddComponent( SpriteComponent:NewFromFile( factionComponent:SpritePath() ) )

    entity:AddComponent( RadiusComponent:New( 50 ) )
    entity:AddTag( "character" )

    ECSWorld:AddEntity( entity )

    return  entity
end


return  Character