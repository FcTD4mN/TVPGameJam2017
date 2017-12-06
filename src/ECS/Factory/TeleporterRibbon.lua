ECSIncludes  = require "src/ECS/ECSIncludes"

local TeleporterRibbon = {}
TeleporterRibbon.mId = 0


-- ==========================================Build/Destroy


function TeleporterRibbon:New( iWorld, iX, iY, iPath, iTelX, iTelY )
    local entity = Entity:New( "teleporterribbon".. TeleporterRibbon.mId )
    TeleporterRibbon.mId = TeleporterRibbon.mId + 1

    -- Components
    local box2DComponent = Box2DComponent:New( iWorld, iX, iY, 283, 521, "static", true, 1, 0 )
        local shape       = love.physics.newRectangleShape( 100, 521 )
        local fixture     = love.physics.newFixture( box2DComponent.mBody, shape )
        fixture:setUserData( entity )
        fixture:setSensor( true )

    entity:AddComponent( SpriteComponent:New( iPath ) )
    entity:AddComponent( TeleporterComponent:New( iTelX, iTelY ) )
    entity:AddComponent( box2DComponent )

    ECSWorld:AddEntity( entity )

    return  entity
end

return  TeleporterRibbon