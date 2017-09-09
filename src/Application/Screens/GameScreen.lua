--[[=================================================================== 
    File: Application.Screens.GameScreen.lua

    @@@@: The Game Screen.
    Dedicated for the actual game, playing etc...

===================================================================--]]

-- INCLUDES ===========================================================
local Screen = require "src/Application/Screens/Screen"

-- OBJECT INITIALISATION ==============================================
local GameScreen = {}
setmetatable( GameScreen, Screen )
Screen.__index = Screen

-- Constructor
function GameScreen:New()
    local newGameScreen = {}
    setmetatable( newGameScreen, self )
    self.__index = self
    
    return newGameScreen

end

-- LOCAL MEMBERS =====================================================
    -- That way they are local to file
    -- NONE YET

-- Called by Global Manager only on SetScreen.
function GameScreen:Initialize()
end

-- OBJECT FUNCTIONS ===================================================
function GameScreen:Update( dt )    
end

function GameScreen:Draw()
    love.graphics.clear( 255, 200, 200, 255 )

end

function GameScreen:KeyPressed( key, scancode, isrepeat )
end

function GameScreen:KeyReleased( key, scancode )
end

function GameScreen:mousepressed( iX, iY, iButton, iIsTouch )
end

-- Release resources before Screen Switch or App Close
function GameScreen:Finalize()
end 

-- RETURN CHUNK AS GLOBAL OBJECT ======================================
return GameScreen
