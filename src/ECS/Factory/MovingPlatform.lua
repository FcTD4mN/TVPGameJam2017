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


    --TODO: defaultpath

    local path = {}
    path["points"] = {}
    path["points"][1] = {}
    path["points"][1]["body"] = love.physics.newBody( iWorld, iX, iY, "static" )
    path["points"][1]["x"] = iX
    path["points"][1]["y"] = iY
    path["points"][1]["time"] = 0.0
    path["points"][2] = {}
    path["points"][2]["body"] = love.physics.newBody( iWorld, iX, iY, "static" )
    path["points"][2]["x"] = iX
    path["points"][2]["y"] = iY
    path["points"][2]["time"] = 0.5
    path["points"][3] = {}
    path["points"][3]["body"] = love.physics.newBody( iWorld, iX - 400, iY - 400, "static" )
    path["points"][3]["x"] = iX
    path["points"][3]["y"] = iY - 400
    path["points"][3]["time"] = 3
    path["points"][4] = {}
    path["points"][4]["body"] = love.physics.newBody( iWorld, iX - 400, iY - 400, "static" )
    path["points"][4]["x"] = iX
    path["points"][4]["y"] = iY - 400
    path["points"][4]["time"] = 3.5
    path["points"][5] = {}
    path["points"][5]["body"] = love.physics.newBody( iWorld, iX, iY, "static" )
    path["points"][5]["x"] = iX
    path["points"][5]["y"] = iY
    path["points"][5]["time"] = 6.5
    
    

    entity:AddComponent( MotionComponent:New( path, true ) )
    entity:AddComponent( box2DComponent )

    entity:AddTag( "wall" )

    ECSWorld:AddEntity( entity )

    return  entity
end

return  MovingPlatform