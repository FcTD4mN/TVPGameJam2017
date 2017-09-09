--[[=================================================================== 
    File: Application.Screens.Screen.lua

    @@@@: The Base Screen.
    Do not use this File / Object / Class.
    Base class for all screens.

===================================================================--]]

-- INCLUDES ===========================================================
-- NONE
local Screen = {};

-- OBJECT INITIALISATION ==============================================
function Screen:New()
    newScreen = {}
    setmetatable( newScreen, self );
    self.__index = self;
    
    return  newScreen;

end

-- Called in Child Classes by Global Manager only on SetScreen.
function Screen:Initialize()
end

-- OBJECT FUNCTIONS ===================================================
function Screen:Type()
    return "Screen"
end

function Screen:Update( dt )    
end

function Screen:Draw()
    love.graphics.clear( 200, 200, 200, 255 )

end

function Screen:KeyPressed( key, scancode, isrepeat )
end

function Screen:KeyReleased( key, scancode )
end

function Screen:mousepressed( iX, iY, iButton, iIsTouch )
end

-- In childs: Release resources before Screen Switch or App Close
function Screen:Finalize()
end 

-- RETURN CHUNK AS GLOBAL OBJECT ======================================
return Screen
