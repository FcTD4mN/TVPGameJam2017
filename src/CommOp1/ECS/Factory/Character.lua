ECSIncludes  = require "src/ECS/ECSIncludes"

local Character = {}
Character.mId = 0


-- ==========================================Build/Destroy


function Character:New( iFaction, iX, iY )
    local entity = Entity:New( "Character"..Character.mId )
    Character.mId = Character.mId + 1



    -- Components
    local factionComponent = FactionComponent:New( iFaction )

    entity:AddComponent( factionComponent )
    entity:AddComponent( PositionComponent:New( iX, iY ) )
    entity:AddComponent( DestinationComponent:New() )
    entity:AddComponent( UserInputComponent:New() )
    entity:AddComponent( SelectableComponent:New() )
    entity:AddComponent( SpriteComponent:NewFromFile( factionComponent:SpritePath() ) )


    entity:GetComponentByName( "selectable" ).mSelected = true


    ECSWorld:AddEntity( entity )

    return  entity
end


return  Character