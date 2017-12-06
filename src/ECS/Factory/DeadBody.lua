ECSIncludes  = require "src/ECS/ECSIncludes"

local DeadBody = {}
DeadBody.mId = 0


-- ==========================================Build/Destroy


function DeadBody:New( iWorld, iX, iY )
    local entity = Entity:New( "deadbody".. DeadBody.mId )
    DeadBody.mId = DeadBody.mId + 1

    -- Components
    local box2DComponent = Box2DComponent:NewBox2DComponent( iWorld, iX, iY, 208, 169, "static", true, 1, 19 )

    entity:AddComponent( SpriteComponent:NewSpriteComponent( "resources/Animation/Characters/Dummy/corpse.png" ) )
    entity:AddComponent( box2DComponent )

    ECSWorld:AddEntity( entity )

    return  entity
end

return  DeadBody