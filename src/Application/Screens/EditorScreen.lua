--[[=================================================================== 
    File: Application.Screens.EditorScreen.lua

    @@@@: The Editor Screen.
    Dedicated for the editor, creating map, drawing polygons etc...

===================================================================--]]

-- INCLUDES ===========================================================
local Screen = require "src/Application/Screens/Screen"
local Widget = require "src/GUI/Widgets/Widget"

-- OBJECT INITIALISATION ==============================================
local EditorScreen = {}
setmetatable( EditorScreen, Screen )
Screen.__index = Screen

-- Constructor
function EditorScreen:New()
    local newEditorScreen = {}
    setmetatable( newEditorScreen, self )
    self.__index = self

    return newEditorScreen
end

-- LOCAL MEMBERS =====================================================
    -- That way they are local to file
    local testWidget1;
    local testWidget2;

-- Called by Global Manager only on SetScreen.
function EditorScreen:Initialize()
    testWidget1 = Widget:New( nil, 50, 50, 300, 300, nil);
    testWidget2 = Widget:New( nil, 200, 200, 220, 400, nil);
end

-- OBJECT FUNCTIONS ===================================================
function EditorScreen:Update( dt )
end

function EditorScreen:Draw()
    love.graphics.setColor(255,255,255,255);
    love.graphics.clear( E_BACKGROUND:Red(), E_BACKGROUND:Green(), E_BACKGROUND:Blue(), 255 )

    testWidget1:Draw()
    testWidget2:Draw()
end

function EditorScreen:KeyPressed( key, scancode, isrepeat )
end

function EditorScreen:KeyReleased( key, scancode )
end

function EditorScreen:mousepressed( iX, iY, iButton, iIsTouch )
end

-- Release resources before Screen Switch or App Close
function EditorScreen:Finalize()
end 

-- RETURN CHUNK AS GLOBAL OBJECT ======================================
return EditorScreen
