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
        local maxtime = motion.mPath.mPoints[#motion.mPath.mPoints].mTime

        if #motion.mPath.mPoints > 0 then
            if motion.mCurrentTime < maxtime or motion.mLoop then --running

                motion.mCurrentTime = ( motion.mCurrentTime + iDT )
                if motion.mLoop then
                    motion.mCurrentTime = motion.mCurrentTime % maxtime
                else
                    motion.mCurrentTime = min( motion.mCurrentTime, maxtime )
                end

                local pointidx1 = 1
                local pointidx2 = 1
                for i = 2, #motion.mPath.mPoints do
                    if motion.mPath.mPoints[i].mTime >= motion.mCurrentTime then
                        pointidx2 = i
                        pointidx1 = i - 1
                        break
                    end
                end

                local point1 = motion.mPath.mPoints[pointidx1]
                local point2 = motion.mPath.mPoints[pointidx2]

                assert( point1.mTime ~= point2.mTime )
                local dx = point2.mBody:getX() - point1.mBody:getX()
                local dy = point2.mBody:getY() - point1.mBody:getY()
                local vx = ( dx ) / ( point2.mTime - point1.mTime )
                local vy = ( dy ) / ( point2.mTime - point1.mTime )

                if motion.mCurrentPoint ~= pointidx1 then 
                    motion.mCurrentPoint = pointidx1
                    
                    -- setX/Y important
                    -- it fix the small accumulation of error due to floating positions
                    box2d.mBody:setX( point1.mBody:getX() ) 
                    box2d.mBody:setY( point1.mBody:getY() )

                    --set the joint when the body is synched with the path point
                    motion.mJoint = love.physics.newPrismaticJoint( point1.mBody, box2d.mBody, 0, 0, 0, 0, vx, vy )
                    motion.mJoint:setLimitsEnabled( true );
                    motion.mJoint:setLowerLimit( 0 );
                    motion.mJoint:setUpperLimit( math.sqrt(  dx *dx + dy * dy ) );
                    
                    -- position the body start point on the path according to mCurrentTime
                    -- Also fixes problems when iDT is big

                    local lineTime = ( motion.mCurrentTime - point1.mTime ) / ( point2.mTime - point1.mTime )
                    box2d.mBody:setX( point1.mBody:getX() + dx * lineTime )
                    box2d.mBody:setY( point1.mBody:getY() + dy * lineTime )
                end

                box2d.mBody:setLinearVelocity( vx, vy )

                if vx ~= 0 then
                    vx=vx/math.abs(vx)
                end
                if vy ~= 0 then
                    vy=vy/math.abs(vx)
                end
            else --not running
                box2d.mBody:setX( motion.mPath.mPoints[#motion.mPath.mPoints].mBody:getX() ) 
                box2d.mBody:setY( motion.mPath.mPoints[#motion.mPath.mPoints].mBody:getY() )
                box2d.mBody:setLinearVelocity( 0, 0 )
            end
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
