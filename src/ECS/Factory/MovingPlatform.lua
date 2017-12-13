ECSIncludes  = require "src/ECS/ECSIncludes"

local MovingPlatform = {}
MovingPlatform.mId = 0


-- ==========================================Build/Destroy


function MovingPlatform:New( iWorld, iX, iY, iW, iH )
    local entity = Entity:New( "movingplatform"..MovingPlatform.mId )
    MovingPlatform.mId = MovingPlatform.mId + 1

    -- Components
    local box2DComponent = Box2DComponent:New( iWorld, iX - iW / 2, iY - iH / 2, iW, iH, "kinematic", true, 1, 0 )
        local stickyShape    = love.physics.newRectangleShape( iW, iH )
        local fixture  = love.physics.newFixture( box2DComponent.mBody, stickyShape )
        fixture:setFriction( 1.0 )
        fixture:setUserData( entity )
        --box2DComponent.mBody:setMass( 0 )

    --TODO: a class TimedPath
    local motionComponent = MotionComponent:New( true )
    motionComponent:AddPoint( iWorld, iX, iY, 0.0 )
    motionComponent:AddPoint( iWorld, iX, iY, 0.5 )
    motionComponent:AddPoint( iWorld, iX-400, iY-400, 3.0 )
    motionComponent:AddPoint( iWorld, iX-400, iY-400, 3.5 )
    motionComponent:AddPoint( iWorld, iX, iY, 6.5 )
    
    entity:AddComponent( motionComponent )
    entity:AddComponent( box2DComponent )

    entity:AddTag( "wall" )

    ECSWorld:AddEntity( entity )

    return  entity
end

return  MovingPlatform