io.stdout:setvbuf('no')

require "src/Application/Global"

MainMenu    = require( "src/MainMenu/MainMenu" )
Game        = require( "src/Game/Game" )
SandBox     = require( "src/SandBox/SandBox")

--TEST
require("src/ExtLibs/XML/xml2lua")

-- States:
    -- kMainMenu
    -- kGaming
local kMainMenu = 0
local kGaming = 1
local kSandBox = 2

local sgGameState = kMainMenu



-- First setup of my game, called at launch
function love.load( args )
    MainMenu:Initialize()

end



-- Updates the values of my game before drawing at screen
-- Called at each tick of the game before drawing
function love.update( dt )

    if sgGameState == kMainMenu then
        sgGameState = MainMenu:Update( dt )
        if sgGameState == kGaming then
            Game:Initialize()
            sgGameState = Game:Update( dt )
        elseif sgGameState == kSandBox then
            SandBox:Initialize()
            sgGameState = SandBox:Update( dt )
        end

    elseif sgGameState == kGaming then
        sgGameState = Game:Update( dt )
    elseif sgGameState == kSandBox then
        sgGameState = SandBox:Update( dt )
    end

end



-- The drawing function to draw the full game
function love.draw()

    if sgGameState == kMainMenu then
        MainMenu:Draw()
    elseif sgGameState == kGaming then
        Game:Draw()
    elseif sgGameState == kSandBox then
        SandBox:Draw()
    end

end



function love.keypressed( key, scancode, isrepeat )
    if sgGameState == kMainMenu then
        MainMenu:KeyPressed( key, scancode, isrepeat )
    elseif sgGameState == kGaming then
        Game:KeyPressed( key, scancode, isrepeat )
    elseif sgGameState == kSandBox then
        SandBox:KeyPressed( key, scancode, isrepeat )
    end
end

function love.keyreleased( key, scancode )
    if sgGameState == kMainMenu then
        MainMenu:KeyReleased( key, scancode )
    elseif sgGameState == kGaming then
        Game:KeyReleased( key, scancode )
    elseif sgGameState == kSandBox then
        SandBox:KeyReleased( key, scancode )
    end
end

function  love.mousepressed( iX, iY, iButton, iIsTouch )
    if sgGameState == kMainMenu then
        MainMenu:mousepressed( iX, iY, iButton, iIsTouch )
    elseif sgGameState == kGaming then
        Game:mousepressed( iX, iY, iButton, iIsTouch )
    elseif sgGameState == kSandBox then
        SandBox:mousepressed( iX, iY, iButton, iIsTouch )
    end
end
