local SystemBase = require( "src/ECS/Systems/SystemBase" )

local  RadiusDrawer = {}
setmetatable( RadiusDrawer, SystemBase )
SystemBase.__index = SystemBase


function  RadiusDrawer:Initialize()

    self.mEntityGroup = {}

end


function RadiusDrawer:IncomingEntity( iEntity )

    -- Here we decide if we are interested by iEntity or not
    -- =====================================================

    local position = iEntity:GetComponentByName( "position" )
    local radius = iEntity:GetComponentByName( "radius" )
    local selectable = iEntity:GetComponentByName( "selectable" )

    if position and radius and selectable then
        table.insert( self.mEntityGroup, iEntity )
        table.insert( iEntity.mObserverSystems, self )
    end

end


function RadiusDrawer:Update( iDT )

end


function  RadiusDrawer:Draw( iCamera )

    for i = 1, #self.mEntityGroup do

        local entity = self.mEntityGroup[ i ]
        local position = entity:GetComponentByName( "position" )
        local sprite = entity:GetComponentByName( "sprite" )
        local radius = entity:GetComponentByName( "radius" )
        local selectable = entity:GetComponentByName( "selectable" )

        if selectable.mSelected then

            local x, y = gCamera:MapToScreen( position.mX, position.mY )
            local w,h = sprite.mImage:getWidth() * gCamera.mScale, sprite.mImage:getHeight() * gCamera.mScale
            local radiusValue = radius.mRadius * gCamera.mScale

            love.graphics.setColor( 255, 50, 50, 90 )
            love.graphics.circle( "fill", x + w/2, y + h/2, radiusValue )
            love.graphics.setColor( 255, 50, 50 )
            love.graphics.circle( "line", x + w/2, y + h/2, radiusValue )

        end


    end

end


-- ==========================================Type


function RadiusDrawer:Type()
    return "RadiusDrawer"
end


return  RadiusDrawer
