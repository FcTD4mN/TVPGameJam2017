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

        love.graphics.setColor( 0, 0, 0 )
        love.graphics.rectangle( "fill", x1, y1, box2d.mBodyW * iCamera.mScale, box2d.mBodyH * iCamera.mScale )

        love.graphics.setColor( 255, 255, 255 )
        love.graphics.rectangle( "line", x1, y1, box2d.mBodyW * iCamera.mScale, box2d.mBodyH * iCamera.mScale )

    end

end


-- ==========================================Type


function WallDrawer:Type()
    return "WallDrawer"
end


return  WallDrawer
