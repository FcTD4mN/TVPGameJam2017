ECSIncludes  = require "src/ECS/ECSIncludes"

local LambdaCharacter = {}
LambdaCharacter.mId = 0


-- ==========================================Build/Destroy


function LambdaCharacter:New( iX, iY )
    local entity = Entity:New( "LambdaCharacter"..LambdaCharacter.mId )
    LambdaCharacter.mId = LambdaCharacter.mId + 1

    -- Components
    entity:AddComponent( SpriteComponent:NewFromFile( "resources/CommOp1/RecherchesGraphiques/landaman.png" ) )
    entity:AddComponent( PositionComponent:New( iX, iY ) )
    entity:AddComponent( DestinationComponent:New( iX, iY ) )
    entity:AddComponent( UserInputComponent:New() )

    ECSWorld:AddEntity( entity )

    return  entity
end

return  LambdaCharacter