local SystemBase = require( "src/ECS/Systems/SystemBase" )
local Shortcuts = require( "src/Application/Shortcuts" )
ECSIncludes  = require "src/ECS/ECSIncludes"

local  InfluenceDrawer = {}
setmetatable( InfluenceDrawer, SystemBase )
SystemBase.__index = SystemBase


function  InfluenceDrawer:Initialize()

    self.mEntityGroup = {}

end


function InfluenceDrawer:IncomingEntity( iEntity )

    -- Here we decide if we are interested by iEntity or not
    -- =====================================================

    local position = iEntity:GetComponentByName( "position" )
    local faction = iEntity:GetComponentByName( "faction" )
    local selectable = iEntity:GetComponentByName( "selectable" )
    local size = iEntity:GetComponentByName( "size" )
    local sprite = iEntity:GetComponentByName( "sprite" )

    if position and faction and selectable and ( size or sprite ) then
        table.insert( self.mEntityGroup, iEntity )
        table.insert( iEntity.mObserverSystems, self )
    end

end


function InfluenceDrawer:Update( iDT )

end


function  InfluenceDrawer:Draw( iCamera )

    for i = 1, #self.mEntityGroup do

        local entity = self.mEntityGroup[ i ]
        local position = entity:GetComponentByName( "position" )
        local faction = entity:GetComponentByName( "faction" )
        local selectable = entity:GetComponentByName( "selectable" )
        local size = entity:GetComponentByName( "size" )
        local sprite = entity:GetComponentByName( "sprite" )

        if selectable.mSelected then

            local barWidth = 100
            local barHeight = 10

            local x, y = gCamera:MapToScreen( position.mX, position.mY )
            local w,h = 0, 0
            if sprite then
                w,h = sprite.mImage:getWidth() * gCamera.mScale, sprite.mImage:getHeight() * gCamera.mScale
            elseif size then
                w,h = size.mW * gCamera.mScale, size.mH * gCamera.mScale
            end
            x,y = x + w/2 - barWidth/2, y + h + barHeight/2 + 5

            love.graphics.setColor( 255,10,10)
            love.graphics.rectangle( "fill", x, y, barWidth*0.4, barHeight )
            love.graphics.setColor( 200,200,200)
            love.graphics.rectangle( "fill", x+barWidth*0.4, y, barWidth*0.2, barHeight )
            love.graphics.setColor( 50,50,255)
            love.graphics.rectangle( "fill", x + barWidth*0.6, y, barWidth*0.4, barHeight )

            local faction = faction.mFactionScore
            local crosshairPosX = x + faction * barWidth / 100
            love.graphics.setColor( 200,200,10)
            love.graphics.rectangle( "fill", crosshairPosX - 1, y - 2, 2, barHeight + 4 )

        end

    end

end


-- ==========================================Type


function InfluenceDrawer:Type()
    return "InfluenceDrawer"
end


return  InfluenceDrawer
