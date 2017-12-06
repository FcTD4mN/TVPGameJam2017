ECSIncludes  = require "src/ECS/ECSIncludes"

local SpikeBall = {}
SpikeBall.mId = 0


-- ==========================================Build/Destroy


function SpikeBall:New( iWorld, iX, iY )
    local entity = Entity:New( "spikeball"..SpikeBall.mId )
    SpikeBall.mId = SpikeBall.mId + 1

    -- Components
    local box2DComponent    = Box2DComponent:New( iWorld, iX + 300, iY, 40, 40, "dynamic", true, 1, 0 )
        local hitBox    = love.physics.newRectangleShape( 40, 40 )
        local fixture   = love.physics.newFixture( box2DComponent.mBody, hitBox )
        fixture:setFriction( 1.0 )
        fixture:setUserData( entity )

    local ropeComp          = RopeOriginComponent:New( iWorld, iX, iY )
        local fixedPart = love.physics.newBody( iWorld, iX, iY, "static" )
        fixedPart:setFixedRotation( true )
        fixedPart:setGravityScale( 0 )


    local ropeJoint    = love.physics.newRopeJoint( ropeComp.mBody, box2DComponent.mBody, iX, iY, iX + 300, iY, 300, false )

    entity:AddComponent( box2DComponent )
    entity:AddComponent( ropeComp )

    entity:AddTag( "canKill" )

    ECSWorld:AddEntity( entity )

    return  entity
end

return  SpikeBall
