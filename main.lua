MainMenu    = require( "MainMenu/MainMenu" )

-- States:
    -- kMainMenu
    -- kGaming

local sgGameState = kMainMenu

-- First setup of my game, called at launch
function love.load( args )
end

-- Updates the values of my game before drawing at screen
-- Called at each tick of the game before drawing
function love.update( dt )
end

-- The drawing function to draw the full game
function love.draw()
    MainMenu:Draw()
end

-- The function to launch a random particle
function launchParticle()
end

function love.keypressed( key, scancode, isrepeat )
end

function love.keyreleased( key, scancode )
end