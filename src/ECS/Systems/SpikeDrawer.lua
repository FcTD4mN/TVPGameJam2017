local SystemBase = require( "src/ECS/Systems/SystemBase" )

local  SpikeDrawer = {}
setmetatable( SpikeDrawer, SystemBase )
SystemBase.__index = SystemBase


function  SpikeDrawer:Initialize()

    self.mEntityGroup = {}

end


function SpikeDrawer:IncomingEntity( iEntity )

    -- Here we decide if we are interested by iEntity or not
    -- =====================================================

    local spike = iEntity:GetTagByName( "spike" )
    local box2d = iEntity:GetComponentByName( "box2d" )

    if box2d and spike == "1" then
        table.insert( self.mEntityGroup, iEntity )
        table.insert( iEntity.mObserverSystems, self )
    end

end


function SpikeDrawer:Update( iDT )
end


function SpikeDrawer:DrawSpikeUp( iCamera, iBox2d )

    local spikeW = 20 * iCamera.mScale

    local x1, y1 = iCamera:MapToScreen( iBox2d.mBody:getX() - iBox2d.mBodyW / 2, iBox2d.mBody:getY() - iBox2d.mBodyH / 2 )
    love.graphics.setColor( 0, 0, 0 )
    for x = x1, x1 + iBox2d.mBodyW * iCamera.mScale - spikeW, spikeW do
        love.graphics.polygon( "fill", x, y1 + iBox2d.mBodyH * iCamera.mScale, x + spikeW / 2, y1, x + spikeW, y1 + iBox2d.mBodyH * iCamera.mScale )
    end

    love.graphics.setColor( 255, 0, 0 )
    for x = x1, x1 + iBox2d.mBodyW * iCamera.mScale - spikeW, spikeW do
        love.graphics.polygon( "line", x, y1 + iBox2d.mBodyH * iCamera.mScale, x + spikeW / 2, y1, x + spikeW, y1 + iBox2d.mBodyH * iCamera.mScale )
    end

end


function SpikeDrawer:DrawSpikeDown( iCamera, iBox2d )

    local spikeW = 20 * iCamera.mScale

    local x1, y1 = iCamera:MapToScreen( iBox2d.mBody:getX() - iBox2d.mBodyW / 2, iBox2d.mBody:getY() - iBox2d.mBodyH / 2 )
    love.graphics.setColor( 0, 0, 0 )
    for x = x1, x1 + iBox2d.mBodyW * iCamera.mScale - spikeW, spikeW do
        love.graphics.polygon( "fill", x, y1, x + spikeW / 2, y1 + iBox2d.mBodyH * iCamera.mScale, x + spikeW, y1 )
    end

    love.graphics.setColor( 255, 0, 0 )
    for x = x1, x1 + iBox2d.mBodyW * iCamera.mScale - spikeW, spikeW do
        love.graphics.polygon( "line", x, y1, x + spikeW / 2, y1 + iBox2d.mBodyH * iCamera.mScale, x + spikeW, y1 )
    end

end


function SpikeDrawer:DrawSpikeLeft( iCamera, iBox2d )

    local spikeH = 20 * iCamera.mScale

    local x1, y1 = iCamera:MapToScreen( iBox2d.mBody:getX() - iBox2d.mBodyW / 2, iBox2d.mBody:getY() - iBox2d.mBodyH / 2 )
    love.graphics.setColor( 0, 0, 0 )
    for y = y1, y1 + iBox2d.mBodyH * iCamera.mScale - spikeH, spikeH do
        love.graphics.polygon( "fill", x1 + iBox2d.mBodyW * iCamera.mScale, y, x1, y + spikeH / 2, x1 + iBox2d.mBodyW * iCamera.mScale, y + spikeH )
    end

    love.graphics.setColor( 255, 0, 0 )
    for x = x1, x1 + iBox2d.mBodyW * iCamera.mScale - spikeW, spikeW do
        love.graphics.polygon( "fill", x1 + iBox2d.mBodyW * iCamera.mScale, y, x1, y + spikeH / 2, x1 + iBox2d.mBodyW * iCamera.mScale, y + spikeH )
    end

end


function SpikeDrawer:DrawSpikeRight( iCamera, iBox2d )

    local spikeH = 20 * iCamera.mScale

    local x1, y1 = iCamera:MapToScreen( iBox2d.mBody:getX() - iBox2d.mBodyW / 2, iBox2d.mBody:getY() - iBox2d.mBodyH / 2 )
    love.graphics.setColor( 0, 0, 0 )
    for y = y1, y1 + iBox2d.mBodyH * iCamera.mScale - spikeH, spikeH do
        love.graphics.polygon( "fill", x1, y, x1 + iBox2d.mBodyW * iCamera.mScale, y + spikeH / 2, x1, y + spikeH )
    end

    love.graphics.setColor( 255, 0, 0 )
    for x = x1, x1 + iBox2d.mBodyW * iCamera.mScale - spikeW, spikeW do
        love.graphics.polygon( "fill", x1, y, x1 + iBox2d.mBodyW * iCamera.mScale, y + spikeH / 2, x1, y + spikeH )
    end

end


function  SpikeDrawer:Draw( iCamera )

    for i = 1, #self.mEntityGroup do

        local box2d = self.mEntityGroup[ i ]:GetComponentByName( "box2d" )
        local direction = self.mEntityGroup[ i ]:GetComponentByName( "direction" )

        if direction then
            if direction.mDirectionH == "left" then
                self:DrawSpikeLeft( iCamera, box2d )
            elseif direction.mDirectionH == "right" then
                self:DrawSpikeRight( iCamera, box2d )
            elseif direction.mDirectionV == "up" then
                self:DrawSpikeUp( iCamera, box2d )
            elseif direction.mDirectionV == "down" then
                self:DrawSpikeDown( iCamera, box2d )
            end
        else
            self:DrawSpikeUp( iCamera, box2d )
        end

    end

end


-- ==========================================Type


function SpikeDrawer:Type()
    return "SpikeDrawer"
end


return  SpikeDrawer