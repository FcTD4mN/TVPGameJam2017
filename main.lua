MainMenu    = require( "src/MainMenu/MainMenu" )
Game        = require( "src/Game/Game" )
TestScreen    = require( "src/TestScreen/TestScreen" ) 

-- States:
    -- kMainMenu
    -- kGaming
local kMainMenu = 0
local kGaming = 1
local kTestScreen = 2

local sgGameState = kTestScreen

-- First setup of my game, called at launch
function love.load( args )
    TestScreen:Initialize()
    --MainMenu:Initialize()
    -- Game:Initialize()
    image = love.graphics.newImage( "resources/Images/Backgrounds/TERRAIN_MOCUP.png" )
end

-- Updates the values of my game before drawing at screen
-- Called at each tick of the game before drawing
function love.update( dt )
    if sgGameState == kTestScreen then
        sgGameState = TestScreen:Update( dt )
    elseif sgGameState == kMainMenu then
        sgGameState = MainMenu:Update( dt )
        if sgGameState == kGaming then
            Game:Initialize()
            sgGameState = Game:Update( dt )
        end
    elseif sgGameState == kGaming then
        sgGameState = Game:Update( dt )
    end
end

-- The drawing function to draw the full game
function love.draw()
    --love.graphics.setColor( 255, 255, 255, 255 )
    --love.graphics.draw( image, 0, 0 )

    if sgGameState == kTestScreen then
        TestScreen:Draw()
    elseif sgGameState == kMainMenu then
        MainMenu:Draw()
    elseif sgGameState == kGaming then
        Game:Draw()
    end
end

function love.keypressed( key, scancode, isrepeat )
    if sgGameState == kTestScreen then
        TestScreen:KeyPressed( key, scancode, isrepeat )
    elseif sgGameState == kMainMenu then
        MainMenu:KeyPressed( key, scancode, isrepeat )
    elseif sgGameState == kGaming then
        Game:KeyPressed( key, scancode, isrepeat )
    end
end

function love.keyreleased( key, scancode )
    if sgGameState == kTestScreen then
        TestScreen:KeyReleased( key, scancode )
    elseif sgGameState == kMainMenu then
        MainMenu:KeyReleased( key, scancode )
    elseif sgGameState == kGaming then
        Game:KeyReleased( key, scancode )
    end
end

function  love.mousepressed( iX, iY, iButton, iIsTouch )
    if sgGameState == kTestScreen then
        TestScreen:mousepressed( iX, iY, iButton, iIsTouch )
    elseif sgGameState == kMainMenu then
        MainMenu:mousepressed( iX, iY, iButton, iIsTouch )
    elseif sgGameState == kGaming then
        Game:mousepressed( iX, iY, iButton, iIsTouch )
    end
end
