--[[=================================================================== 
    File: Application.Screens.GameScreen.lua

    @@@@: A Template Screen...
    Do not use this File / Object / Class.
    It's just a template for making new screens quickly.
    Just Copy Paste in another file and make your own screen.

===================================================================--]]

-- INCLUDES ===========================================================
local Screen = require "src/Application/Screens/Screen"

-- OBJECT INITIALISATION ==============================================
local TemplateScreen = {}
setmetatable( TemplateScreen, Screen )
Screen.__index = Screen

-- Constructor
function TemplateScreen:New()
    local newTemplateScreen = {}
    setmetatable( newTemplateScreen, self )
    self.__index = self

    return newTemplateScreen

end

-- LOCAL MEMBERS =====================================================
    -- That way they are local to file
    -- NONE YET

-- Called by Global Manager only on SetScreen.
function TemplateScreen:Initialize()
end

-- OBJECT FUNCTIONS ===================================================
function TemplateScreen:Update( dt )    
end

function TemplateScreen:Draw()
    love.graphics.clear( 0, 255, 200, 255 )

end

function TemplateScreen:KeyPressed( key, scancode, isrepeat )
end

function TemplateScreen:KeyReleased( key, scancode )
end

function TemplateScreen:mousepressed( iX, iY, iButton, iIsTouch )
end

-- Release resources before Screen Switch or App Close
function TemplateScreen:Finalize()
end 

-- RETURN CHUNK AS GLOBAL OBJECT ======================================
return TemplateScreen
