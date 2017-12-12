local SystemBase = require( "src/ECS/Systems/SystemBase" )

local  MotionPathDrawer = {}
setmetatable( MotionPathDrawer, SystemBase )
SystemBase.__index = SystemBase


function  MotionPathDrawer:Initialize()

    self.mEntityGroup = {}

end


function MotionPathDrawer:IncomingEntity( iEntity )

    -- Here we decide if we are interested by iEntity or not
    -- =====================================================

    local motion = iEntity:GetComponentByName( "motion" )
    if motion then
        table.insert( self.mEntityGroup, iEntity )
        table.insert( iEntity.mObserverSystems, self )
    end

end


function MotionPathDrawer:Update( iDT )
end


function  MotionPathDrawer:Draw( iCamera )

    for i = 1, #self.mEntityGroup do

        local motion = self.mEntityGroup[ i ]:GetComponentByName( "motion" )

        local x1 = nil
        local y1 = nil
        for i=1, #motion.mPath["points"] do
            local x2, y2 = iCamera:MapToScreen( motion.mPath["points"][i]["body"]:getX(), motion.mPath["points"][i]["body"]:getY() )
            if x1 and y1 then
                love.graphics.setColor( 0, 0, 255 )
                love.graphics.line( x1, y1, x2, y2 )
                --drawline to x2 y2
            end
            love.graphics.setColor( 0, 255, 0 )
            love.graphics.circle( "fill", x2, y2, 10 )
            x1 = x2
            y1 = y2
        end
    end

end


-- ==========================================Type


function MotionPathDrawer:Type()
    return "MotionPathDrawer"
end


return  MotionPathDrawer
