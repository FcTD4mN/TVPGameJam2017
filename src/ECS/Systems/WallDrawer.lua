local SystemBase = require( "src/ECS/Systems/SystemBase" )

local  WallDrawer = {}
setmetatable( WallDrawer, SystemBase )
SystemBase.__index = SystemBase


function  WallDrawer:Initialize()

    self.mEntityGroup = {}

end


function WallDrawer:Requirements()

    local requirements = {}
    table.insert( requirements, "wall" )
    table.insert( requirements, "box2d" )

    return  unpack( requirements )

end


function WallDrawer:Update( iDT )
end


function  WallDrawer:Draw( iCamera )

    for i = 1, #self.mEntityGroup do

        local box2d = self.mEntityGroup[ i ]:GetComponentByName( "box2d" )

        local x1, y1 = iCamera:MapToScreen( box2d.mBody:getX() - box2d.mBodyW / 2, box2d.mBody:getY() - box2d.mBodyH / 2 )

        -- Only render if wall is on screen
        if not ( ( x1 + box2d.mBodyW < 0  ) or ( y1 + box2d.mBodyH < 0 ) or ( x1 > iCamera.mW  ) or ( y1 > iCamera.mH ) ) then
            love.graphics.setColor( 0, 0, 0 )
            love.graphics.rectangle( "fill", x1, y1, box2d.mBodyW * iCamera.mScale, box2d.mBodyH * iCamera.mScale )

            love.graphics.setColor( 255, 255, 255 )
            love.graphics.rectangle( "line", x1, y1, box2d.mBodyW * iCamera.mScale, box2d.mBodyH * iCamera.mScale )

            if( self.mEntityGroup[ i ]:GetTagByName( "canKill" ) == "1" ) then

                local spikeW = 20 * iCamera.mScale

                local x1, y1 = iCamera:MapToScreen( box2d.mBody:getX() - box2d.mBodyW / 2, box2d.mBody:getY() - box2d.mBodyH / 2 )
                local spikeHeight = 10
                y1 = y1 - 10

                love.graphics.setColor( 0, 0, 0 )
                for x = x1, x1 + box2d.mBodyW * iCamera.mScale - spikeW, spikeW do
                    love.graphics.polygon( "fill", x, y1 + spikeHeight * iCamera.mScale, x + spikeW / 2, y1, x + spikeW, y1 + spikeHeight * iCamera.mScale )
                end

                love.graphics.setColor( 255, 0, 0 )
                for x = x1, x1 + box2d.mBodyW * iCamera.mScale - spikeW, spikeW do
                    love.graphics.polygon( "line", x, y1 + spikeHeight * iCamera.mScale, x + spikeW / 2, y1, x + spikeW, y1 + spikeHeight * iCamera.mScale )
                end

            end

        end

    end

end


-- ==========================================Type


function WallDrawer:Type()
    return "WallDrawer"
end


return  WallDrawer
