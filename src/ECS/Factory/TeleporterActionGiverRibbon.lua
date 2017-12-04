ECSIncludes  = require "src/ECS/ECSIncludes"

local TeleporterActionGiverRibbon = {}
TeleporterActionGiverRibbon.mId = 0


-- ==========================================Build/Destroy


function TeleporterActionGiverRibbon:New( iWorld, iX, iY, iPath, iTelX, iTelY, iAction )
    local entity = Entity:New( "teleporteractiongiverribbon".. TeleporterActionGiverRibbon.mId )
    TeleporterActionGiverRibbon.mId = TeleporterActionGiverRibbon.mId + 1

    -- Components
    local box2DComponent = BasicComponents:NewBox2DComponent( iWorld, iX, iY, 283, 521, "static", true, 1 )
        local shape       = love.physics.newRectangleShape( 100, 521 )
        local fixture     = love.physics.newFixture( box2DComponent.mBody, shape )
        fixture:setUserData( entity )
        fixture:setSensor( true )

    entity:AddComponent( BasicComponents:NewSimpleSprite( iPath ) )
    entity:AddComponent( BasicComponents:NewTeleporter( iTelX, iTelY ) )
    entity:AddComponent( BasicComponents:NewActionGiver( iAction ) )
    entity:AddComponent( box2DComponent )

    ECSWorld:AddEntity( entity )

    return  entity
end

return  TeleporterActionGiverRibbon