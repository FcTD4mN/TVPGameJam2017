local SystemBase = require( "src/ECS/Systems/SystemBase" )

local  HangingBallRenderer = {}
setmetatable( HangingBallRenderer, SystemBase )
SystemBase.__index = SystemBase


function  HangingBallRenderer:Initialize()

    self.mEntityGroup = {}

end


function HangingBallRenderer:Requirements()

    local requirements = {}
    table.insert( requirements, "ropeorigin" )
    table.insert( requirements, "box2d" )

    return  unpack( requirements )

end


function HangingBallRenderer:Update( iDT )
    --does nothing
end


function  HangingBallRenderer:Draw( iCamera )

    for i = 1, #self.mEntityGroup do

        local entity = self.mEntityGroup[ i ]

        local box2d         = self.mEntityGroup[ i ]:GetComponentByName( "box2d" )
        local ropeOrigin    = self.mEntityGroup[ i ]:GetComponentByName( "ropeorigin" )


        local ballX, ballY              = iCamera:MapToScreen( box2d.mBody:getX(), box2d.mBody:getY() )
        local ropeOriginX, ropeOriginY  = iCamera:MapToScreen( ropeOrigin.mBody:getX(), ropeOrigin.mBody:getY() )

        -- Only render balls if they are on screen
        if  not ( ( ballX  < -15 and ropeOriginX < 0 ) or ( ballY < -15 )
                or
                ( ballX > iCamera.mW +15 and ropeOriginX > iCamera.mW ) or ( ropeOriginY > iCamera.mH ) ) then

                love.graphics.setColor( 255,255,255 )
                love.graphics.circle( "fill", ballX, ballY, 30 )
                love.graphics.setColor( 0,0,0 )
                love.graphics.circle( "fill", ballX, ballY, 28 )

                love.graphics.setColor( 100,100,0 )
                love.graphics.line( ropeOriginX, ropeOriginY, ballX, ballY )
                love.graphics.line( ropeOriginX-1, ropeOriginY-1, ballX-1, ballY-1 )
                love.graphics.line( ropeOriginX+1, ropeOriginY+1, ballX+1, ballY+1 )
                love.graphics.line( ropeOriginX+1, ropeOriginY, ballX+1, ballY )
                love.graphics.line( ropeOriginX+1, ropeOriginY+1, ballX+1, ballY+1 )

                if( entity:GetTagByName( "canKill" ) == "1" ) then

                    love.graphics.setColor( 200,10,10 )

                    local  nbSpikes = 8
                    local  angles = 2*math.pi / nbSpikes
                    local  shift = 0.2

                    for pos = 0, nbSpikes, angles do

                        local  sinPrev = math.sin( pos + shift )
                        local  sinNext = math.sin( pos - shift )
                        local  cosPrev = math.cos( pos + shift )
                        local  cosNext = math.cos( pos - shift )

                        local  sin = math.sin( pos )
                        local  cos = math.cos( pos )


                        local endX = ballX + cos * 50
                        local endY = ballY + sin * 50

                        local firstX = ballX + cosPrev * 30
                        local firstY = ballY + sinPrev * 30

                        local secondX = ballX + cosNext * 30
                        local secondY = ballY + sinNext * 30

                        love.graphics.polygon( "fill", endX, endY, firstX, firstY, secondX, secondY )

                    end

                end

        end

    end

end


-- ==========================================Type


function HangingBallRenderer:Type()
    return "HangingBallRenderer"
end


return  HangingBallRenderer
