ECSIncludes  = require "src/ECS/ECSIncludes"
Animation  = require "src/Image/Animation"

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
    entity:AddComponent( SizeComponent:New( 40, 64 ) )

    local minspeed = 30
    local maxspeed = 50
    local actualspeed = math.random() * ( maxspeed - minspeed ) + minspeed
    entity:AddComponent( SpeedComponent:New( actualspeed ) )
    if gFaction == iFaction then
        entity:AddComponent( SelectableComponent:New() )
    end
    --entity:AddComponent( SpriteComponent:NewFromFile( factionComponent:SpritePath() ) )
    local animations = {}
    animations[ "idlecommunist" ] = Animation:New( "resources/CommOp1/RecherchesGraphiques/communiste.png", 1, 1, false, false, false )
    animations[ "movecommunist" ] = Animation:New( "resources/CommOp1/RecherchesGraphiques/communiste_spritesheet.png", 12, 24 * actualspeed / maxspeed, true, false, false )

    animations[ "idlecapitalist" ] = Animation:New( "resources/CommOp1/RecherchesGraphiques/capitaliste.png", 1, 1, false, false, false )
    animations[ "movecapitalist" ] = Animation:New( "resources/CommOp1/RecherchesGraphiques/capitaliste_spritesheet.png", 12, 24 * actualspeed / maxspeed, true, false, false )
    
    animations[ "idleneutral" ] = Animation:New( 'resources/CommOp1/RecherchesGraphiques/landaman.png', 1, 1, false, false, false )
    animations[ "moveneutral" ] = Animation:New( 'resources/CommOp1/RecherchesGraphiques/landaman_spritesheet.png', 12, 24 * actualspeed / maxspeed, true, false, false )
    entity:AddComponent( AnimationsComponent:New( animations, "idle"..iFaction ) )

    entity:AddComponent( RadiusComponent:New( 1 ) )
    entity:AddTag( "character" )

    ECSWorld:AddEntity( entity )

    return  entity
end


return  Character