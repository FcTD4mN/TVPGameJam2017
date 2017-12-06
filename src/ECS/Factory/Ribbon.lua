ECSIncludes  = require "src/ECS/ECSIncludes"

local Ribbon = {}
Ribbon.mId = 0


-- ==========================================Build/Destroy


function Ribbon:New( iWorld, iX, iY, iPath )
    local entity = Entity:New( "Ribbon".. Ribbon.mId )
    Ribbon.mId = Ribbon.mId + 1

    -- Components
    local box2DComponent = Box2DComponent:New( iWorld, iX, iY, 283, 521, "static", true, 1, 0 )
        local shape       = love.physics.newRectangleShape( 100, 521 )
        local fixture     = love.physics.newFixture( box2DComponent.mBody, shape )
        fixture:setUserData( entity )
        fixture:setSensor( true )

    entity:AddComponent( SpriteComponent:New( iPath ) )
    entity:AddComponent( CheckPointSetterComponent:New( 1 ) )
    entity:AddComponent( CheckPointComponent:New( 0 ) )
    entity:AddComponent( box2DComponent )

    ECSWorld:AddEntity( entity )

    return  entity
end

return  Ribbon