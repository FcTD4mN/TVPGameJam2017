--[[=================================================================== 
    File: Application.Screens.MenuScreen.lua

    @@@@: The Menu Screen.
    Menu, select options & Stuff

===================================================================--]]

-- INCLUDES ===========================================================
local Screen = require "src/Application/Screens/Screen"

-- OBJECT INITIALISATION ==============================================
local MenuScreen = {}
setmetatable( MenuScreen, Screen )
Screen.__index = Screen

-- Constructor
function MenuScreen:New()
    local newMenuScreen = {}
    setmetatable( newMenuScreen, self )
    self.__index = self

    return newMenuScreen

end

-- LOCAL MEMBERS =====================================================
    -- That way they are local to file
    -- NONE YET

-- Called by Global Manager only on SetScreen.
function MenuScreen:Initialize()
end

-- OBJECT FUNCTIONS ===================================================
function MenuScreen:Update( dt )   
end

function MenuScreen:Draw()
    love.graphics.clear( 0, 255, 200, 255 )

end

function MenuScreen:KeyPressed( key, scancode, isrepeat )
end

function MenuScreen:KeyReleased( key, scancode )
end

function MenuScreen:mousepressed( iX, iY, iButton, iIsTouch )
end

-- Release resources before Screen Switch or App Close
function MenuScreen:Finalize()
end 

-- RETURN CHUNK AS GLOBAL OBJECT ======================================
return MenuScreen
