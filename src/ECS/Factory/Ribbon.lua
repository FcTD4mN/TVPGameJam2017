ECSIncludes  = require "src/ECS/ECSIncludes"

local Ribbon = {}
Ribbon.mId = 0


-- ==========================================Build/Destroy


function Ribbon:New( iWorld, iX, iY, iPath )
    local entity = Entity:New( "Ribbon".. Ribbon.mId )
    Ribbon.mId = Ribbon.mId + 1

    -- Components
    local box2DComponent = BasicComponents:NewBox2DComponent( iWorld, iX, iY, 283, 521, "static", true, 1 )
        local shape       = love.physics.newRectangleShape( 100, 521 )
        local fixture     = love.physics.newFixture( box2DComponent.mBody, shape )
        fixture:setUserData( entity )
        --fixture:setSensor( true )

    entity:AddComponent( BasicComponents:NewSimpleSprite( iPath ) )
    entity:AddComponent( BasicComponents:NewCheckPointSetter( 1 ) )
    entity:AddComponent( BasicComponents:NewCheckPoint( 0 ) )
    entity:AddComponent( box2DComponent )

    ECSWorld:AddEntity( entity )

    return  entity
end

return  Ribbon