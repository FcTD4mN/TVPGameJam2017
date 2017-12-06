ECSIncludes  = require "src/ECS/ECSIncludes"

local TriggerCheckPoint = {}
TriggerCheckPoint.mId = 0


-- ==========================================Build/Destroy


function TriggerCheckPoint:New( iWorld, iX, iY, iCheckPoint )
    local entity = Entity:New( "triggercheckpoint".. TriggerCheckPoint.mId )
    TriggerCheckPoint.mId = TriggerCheckPoint.mId + 1

    -- Components
    local box2DComponent = Box2DComponent:New( iWorld, iX, iY, 283, 521, "static", true, 1, 0 )
        local shape       = love.physics.newRectangleShape( 10000, 50 )
        local fixture     = love.physics.newFixture( box2DComponent.mBody, shape )
        fixture:setUserData( entity )
        fixture:setSensor( true )

    entity:AddComponent( CheckPointSetterComponent:New( iCheckPoint ) )
    entity:AddComponent( box2DComponent )

    ECSWorld:AddEntity( entity )

    return  entity
end

return  TriggerCheckPoint