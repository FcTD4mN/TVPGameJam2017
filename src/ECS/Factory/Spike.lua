ECSIncludes  = require "src/ECS/ECSIncludes"

local Spike = {}
Spike.mId = 0


-- ==========================================Build/Destroy


function Spike:New( iWorld, iX, iY )
    local entity = Entity:New( "spike"..Spike.mId )
    Spike.mId = Spike.mId + 1

    -- Components
    local box2DComponent = BasicComponents:NewBox2DComponent( iWorld, iX, iY, 100, 100, "dynamic", true, 1 )
        local stickyShape    = love.physics.newRectangleShape( 100, 100 )
        local fixture  = love.physics.newFixture( box2DComponent.mBody, stickyShape )
        fixture:setFriction( 1.0 )
        fixture:setUserData( entity )

    local animations = {}

    entity:AddComponent( BasicComponents:NewSpikeComponent( animations ) )
    entity:AddComponent( box2DComponent )
    ECSWorld:AddEntity( entity )

    return  entity
end

return  Spike