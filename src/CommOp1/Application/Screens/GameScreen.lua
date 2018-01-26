--[[===================================================================
    File: Application.Screens.GameScreen.lua

    @@@@: The Game Screen.
    Dedicated for the actual game, playing etc...

===================================================================--]]

-- INCLUDES ===========================================================
local Screen        = require "src/Application/Screens/Screen"


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

end


--USER INPUT============================================================================


function GameScreen:TextInput( iT )
    --Nothing special
end


function GameScreen:KeyPressed( iKey, iScancode, iIsRepeat )
end


function GameScreen:KeyReleased( iKey, iScancode )
end


function GameScreen:MouseMoved( iX, iY )
    --Nothing special
end


function GameScreen:mousepressed( iX, iY, iButton, iIsTouch )
end


function GameScreen:MouseReleased( iX, iY, iButton, iIsTouch )
    --Nothing special
end


function GameScreen:WheelMoved( iX, iY )
    --Nothing special
end


-- Release resources before Screen Switch or App Close ======================================
function GameScreen:Finalize()
end


-- RETURN CHUNK AS GLOBAL OBJECT ======================================
return GameScreen
