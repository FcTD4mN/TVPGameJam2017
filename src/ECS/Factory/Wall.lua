ECSIncludes  = require "src/ECS/ECSIncludes"

local Wall = {}
Wall.mId = 0


-- ==========================================Build/Destroy


function Wall:New( iWorld, iX, iY, iW, iH )
    local entity = Entity:New( "wall"..Wall.mId )
    Wall.mId = Wall.mId + 1

    -- Components
    local box2DComponent = BasicComponents:NewBox2DComponent( iWorld, iX, iY, iW, iH, "static", true, 1 )
        local stickyShape    = love.physics.newRectangleShape( iW, iH )
        local fixture  = love.physics.newFixture( box2DComponent.mBody, stickyShape )
        fixture:setFriction( 0.0 )
        fixture:setUserData( entity )

    entity:AddComponent( BasicComponents:NewWallComponent() )
    entity:AddComponent( box2DComponent )
    ECSWorld:AddEntity( entity )

    return  entity
end

return  Wall