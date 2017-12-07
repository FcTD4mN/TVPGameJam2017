local SystemBase = require( "src/ECS/Systems/SystemBase" )

local  MotionAI = {}
setmetatable( MotionAI, SystemBase )
SystemBase.__index = SystemBase


function  MotionAI:Initialize()

    self.mEntityGroup = {}

end


function MotionAI:IncomingEntity( iEntity )

    -- Here we decide if we are interested by iEntity or not
    -- =====================================================

    local motion = iEntity:GetComponentByName( "motion" )
    local box2d = iEntity:GetComponentByName( "box2d" )

    if box2d and motion then
        table.insert( self.mEntityGroup, iEntity )
        table.insert( iEntity.mObserverSystems, self )
    end

end


function MotionAI:Update( iDT )
    --does nothing
    for i = 1, #self.mEntityGroup do
        local box2d = self.mEntityGroup[ i ]:GetComponentByName( "box2d" )
        local motion = self.mEntityGroup[ i ]:GetComponentByName( "motion" )

        if #motion.mPath["points"] > 0 and ( motion.mCurrentTime < 1 or motion.mLoop ) then

            local maxtime = motion.mPath["points"][#motion.mPath["points"]]["time"]

            motion.mCurrentTime = ( motion.mCurrentTime + iDT )
            if motion.mLoop then
                motion.mCurrentTime = motion.mCurrentTime % maxtime
            else
                motion.mCurrentTime = min( motion.mCurrentTime, maxtime )
            end

            point1 = motion.mPath["points"][1]
            point2 = motion.mPath["points"][1]

            for i = 2, #motion.mPath["points"] do
                if motion.mPath["points"][i]["time"] >= motion.mCurrentTime then
                    point2 = motion.mPath["points"][i]
                    point1 = motion.mPath["points"][i-1]
                    break
                end
            end

            local x = 0
            local y = 0
            local vx = 0
            local vy = 0
            if point1 == point2 or point1["time"] == point2["time"] then
                x = point1["x"]
                y = point1["y"]
                v = 0
            else
                lineTime = ( motion.mCurrentTime - point1["time"] ) / ( point2["time"] - point1["time"] )
                x = point1["x"] + ( point2["x"] - point1["x"] ) * lineTime
                y = point1["y"] + ( point2["y"] - point1["y"] ) * lineTime
                vx = ( point2["x"] - point1["x"] ) / ( point2["time"] - point1["time"] )
                vy = ( point2["y"] - point1["y"] ) / ( point2["time"] - point1["time"] )
            end
            --box2d.mBody:setX( x )
            --box2d.mBody:setY( y )
            motion.mJoint = love.physics.newPrismaticJoint( point1["body"], box2d.mBody, box2d.mBody:getX(), box2d.mBody:getY(), vx, vy, false )
            box2d.mBody:setLinearVelocity( vx, vy )
        end
    end
end


function  MotionAI:Draw( iCamera )

end


-- ==========================================Type


function MotionAI:Type()
    return "MotionAI"
end


return  MotionAI
