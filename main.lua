io.stdout:setvbuf('no')

require "src/Application/Global"

local  MenuScreen   = require( "src/Application/Screens/MenuScreen" )


-- First setup of my game, called at launch
function love.load( args )

    Manager:PushScreen( MenuScreen:New() )

end


-- Updates the values of my game before drawing at screen
-- Called at each tick of the game before drawing
function love.update( dt )

    Manager:Update( dt )
end



-- The drawing function to draw the full game
function love.draw()

    Manager:Draw()

end



function love.keypressed( iKey, iScancode, iIsRepeat )

    Manager:KeyPressed( iKey, iScancode, iIsRepeat )

end

function love.keyreleased( iKey, iScancode )

    Manager:KeyReleased( iKey, iScancode )

end

function  love.mousepressed( iX, iY, iButton, iIsTouch )

    Manager:mousepressed( iX, iY, iButton, iIsTouch )

end
