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
    local faction = iEntity:GetComponentByName( "faction" )

    if position and radius and selectable and faction then
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
        local radius = entity:GetComponentByName( "radius" )
        local selectable = entity:GetComponentByName( "selectable" )
        local faction = entity:GetComponentByName( "faction" )

        local sprite = entity:GetComponentByName( "sprite" )
        local size = entity:GetComponentByName( "size" )

        if selectable.mSelected then

            local x, y = gCamera:MapToScreen( position.mX, position.mY )
            local w,h = 0, 0
            if sprite then
                w,h = sprite.mImage:getWidth() * gCamera.mScale, sprite.mImage:getHeight() * gCamera.mScale
            elseif size then
                w,h = size.mW * gCamera.mScale, size.mH * gCamera.mScale
            end
            x,y = x + w/2, y + h/2
            local radiusValue = radius.mRadius * gTileSize * gCamera.mScale

            local r,g,b = 0,0,0
            if faction.mFaction == "neutral" then
                r,g,b = 50,50,50
            elseif faction.mFaction == "capitalist" then
                r,g,b = 50,50,255
            else
                r,g,b = 255,50,50
            end

            love.graphics.setColor( r, g, b, 90 )
            love.graphics.rectangle( "fill", x - radiusValue, y- radiusValue, radiusValue*2, radiusValue*2 )
            love.graphics.setColor( r, g, b )
            love.graphics.rectangle( "line", x - radiusValue, y - radiusValue, radiusValue*2, radiusValue*2 )

        end


    end

end


-- ==========================================Type


function RadiusDrawer:Type()
    return "RadiusDrawer"
end


return  RadiusDrawer
