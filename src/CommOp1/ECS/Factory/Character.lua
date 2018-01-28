ECSIncludes  = require "src/ECS/ECSIncludes"

local Character = {}
Character.mId = 0


-- ==========================================Build/Destroy


function Character:New( iFaction, iX, iY, iSelectable )
    local entity = Entity:New( "Character"..Character.mId )
    Character.mId = Character.mId + 1

    gTotalCount = gTotalCount + 1

    if iFaction == "communist" then
        gCommunistCount = gCommunistCount + 1
    elseif iFaction == "neutral" then
        gNeutralCount = gNeutralCount + 1
    else
        gCapitalistCount = gCapitalistCount + 1
    end

    -- Components
    local factionComponent = FactionComponent:New( iFaction, 1, 1 )

    entity:AddComponent( factionComponent )
    entity:AddComponent( PositionComponent:New( iX, iY ) )
    entity:AddComponent( DestinationComponent:New() )
    entity:AddComponent( UserInputComponent:New() )

    local minspeed = 30
    local maxspeed = 50
    entity:AddComponent( SpeedComponent:New( math.random() * ( maxspeed - minspeed ) + minspeed ) )
    if gFaction == iFaction then
        entity:AddComponent( SelectableComponent:New() )
    end
    entity:AddComponent( SpriteComponent:NewFromFile( factionComponent:SpritePath() ) )

    entity:AddComponent( RadiusComponent:New( 1 ) )
    entity:AddTag( "character" )

    ECSWorld:AddEntity( entity )

    return  entity
end


return  Character