MainMenu    = require( "src/MainMenu/MainMenu" )
Game    = require( "src/Game/Game" )

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
    if sgGameState == kMainMenu then
        MainMenu:Update( dt )
    elseif sgGameState == kGaming then
        Game:Update( dt )
end

-- The drawing function to draw the full game
function love.draw()
    if sgGameState == kMainMenu then
        MainMenu:Draw()
    elseif sgGameState == kGaming then
        Game:Draw()
end

function love.keypressed( key, scancode, isrepeat )
    if sgGameState == kMainMenu then
        MainMenu:KeyPressed( key, scancode, isrepeat )
    elseif sgGameState == kGaming then
        Game:KeyPressed( key, scancode, isrepeat )
end

function love.keyreleased( key, scancode )
    if sgGameState == kMainMenu then
        MainMenu:KeyReleased( key, scancode )
    elseif sgGameState == kGaming then
        Game:KeyReleased( key, scancode )
end