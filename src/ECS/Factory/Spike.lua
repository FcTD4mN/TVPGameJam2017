ECSIncludes  = require "src/ECS/ECSIncludes"

local Spike = {}
Spike.mId = 0


-- ==========================================Build/Destroy


function Spike:New( iWorld, iX, iY, iW, iH )
    local entity = Entity:New( "spike"..Spike.mId )
    Spike.mId = Spike.mId + 1

    -- Components
    local box2DComponent = Box2DComponent:New( iWorld, iX, iY, iW, iH, "static", true, 1, 0 )
        local stickyShape    = love.physics.newRectangleShape( iW, iH )
        local fixture  = love.physics.newFixture( box2DComponent.mBody, stickyShape )
        fixture:setFriction( 1.0 )
        fixture:setUserData( entity )

    entity:AddTag( "spike" )
    entity:AddComponent( box2DComponent )

    entity:AddTag( "canKill" )

    ECSWorld:AddEntity( entity )

    return  entity
end

return  Spike