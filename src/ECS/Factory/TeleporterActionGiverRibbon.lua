ECSIncludes  = require "src/ECS/ECSIncludes"

local TeleporterActionGiverRibbon = {}
TeleporterActionGiverRibbon.mId = 0


-- ==========================================Build/Destroy


function TeleporterActionGiverRibbon:New( iWorld, iX, iY, iPath, iTelX, iTelY, iAction )
    local entity = Entity:New( "teleporteractiongiverribbon".. TeleporterActionGiverRibbon.mId )
    TeleporterActionGiverRibbon.mId = TeleporterActionGiverRibbon.mId + 1

    -- Components
    local box2DComponent = Box2DComponent:New( iWorld, iX, iY, 283, 521, "static", true, 1, 0 )
        local shape       = love.physics.newRectangleShape( 100, 521 )
        local fixture     = love.physics.newFixture( box2DComponent.mBody, shape )
        fixture:setUserData( entity )
        fixture:setSensor( true )

    entity:AddComponent( SpriteComponent:New( iPath ) )
    entity:AddComponent( TeleporterComponent:New( iTelX, iTelY ) )
    entity:AddComponent( ActionGiverComponent:New( iAction ) )
    entity:AddComponent( box2DComponent )

    ECSWorld:AddEntity( entity )

    return  entity
end

return  TeleporterActionGiverRibbon