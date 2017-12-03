local SystemBase = require( "src/ECS/Systems/SystemBase" )

local  SpikeDrawer = {}
setmetatable( SpikeDrawer, SystemBase )
SystemBase.__index = SystemBase


function  SpikeDrawer:Initialize()

    self.mEntityGroup = {}

end


function SpikeDrawer:Requirements()

    local requirements = {}
    table.insert( requirements, "spike" )
    table.insert( requirements, "box2d" )

    return  unpack( requirements )

end


function SpikeDrawer:Update( iDT )
end


function  SpikeDrawer:Draw( iCamera )

    for i = 1, #self.mEntityGroup do

        local box2d = self.mEntityGroup[ i ]:GetComponentByName( "box2d" )
        local spikeW = 20 * iCamera.mScale

        local x1, y1 = iCamera:MapToScreen( box2d.mBody:getX() - box2d.mBodyW / 2, box2d.mBody:getY() - box2d.mBodyH / 2 )

        love.graphics.setColor( 0, 0, 0 )
        for x = x1, x1 + box2d.mBodyW * iCamera.mScale - spikeW, spikeW do
            love.graphics.polygon( "fill", x, y1 + box2d.mBodyH * iCamera.mScale, x + spikeW / 2, y1, x + spikeW, y1 + box2d.mBodyH * iCamera.mScale )
        end

        love.graphics.setColor( 255, 255, 255 )
        for x = x1, x1 + box2d.mBodyW * iCamera.mScale - spikeW, spikeW do
            love.graphics.polygon( "line", x, y1 + box2d.mBodyH * iCamera.mScale, x + spikeW / 2, y1, x + spikeW, y1 + box2d.mBodyH * iCamera.mScale )
        end
        
    end

end


-- ==========================================Type


function SpikeDrawer:Type()
    return "SpikeDrawer"
end


return  SpikeDrawer