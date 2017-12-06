ECSIncludes  = require "src/ECS/ECSIncludes"

local TeleporterRibbon = {}
TeleporterRibbon.mId = 0


-- ==========================================Build/Destroy


function TeleporterRibbon:New( iWorld, iX, iY, iPath, iTelX, iTelY )
    local entity = Entity:New( "teleporterribbon".. TeleporterRibbon.mId )
    TeleporterRibbon.mId = TeleporterRibbon.mId + 1

    -- Components
    local box2DComponent = Box2DComponent:NewBox2DComponent( iWorld, iX, iY, 283, 521, "static", true, 1 )
        local shape       = love.physics.newRectangleShape( 100, 521 )
        local fixture     = love.physics.newFixture( box2DComponent.mBody, shape )
        fixture:setUserData( entity )
        fixture:setSensor( true )

    entity:AddComponent( SpriteComponent:NewSpriteComponent( iPath ) )
    entity:AddComponent( TeleporterComponent:NewTeleporterComponent( iTelX, iTelY ) )
    entity:AddComponent( box2DComponent )

    ECSWorld:AddEntity( entity )

    return  entity
end

return  TeleporterRibbon