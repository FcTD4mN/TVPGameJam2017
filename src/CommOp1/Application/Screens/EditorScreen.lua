--[[===================================================================
    File: Application.Screens.EditorScreen.lua

    @@@@: The Editor Screen.
    Dedicated for the editor, creating map, drawing polygons etc...

===================================================================--]]

-- INCLUDES ===========================================================
local Screen = require "src/Application/Screens/Screen"

local Editor = require "src/Editor/Editor"

-- OBJECT INITIALISATION ==============================================
local EditorScreen = {}
setmetatable( EditorScreen, Screen )
Screen.__index = Screen

-- Constructor
function EditorScreen:New()
    local newEditorScreen = {}
    setmetatable( newEditorScreen, EditorScreen )
    EditorScreen.__index = EditorScreen

    return newEditorScreen
end

-- LOCAL MEMBERS =====================================================

-- Called by Global Manager only on SetScreen.
function EditorScreen:Initialize()
end

-- OBJECT FUNCTIONS ===================================================
function EditorScreen:Update( iDT )
    Editor.Update( iDT )
end

function EditorScreen:Draw()
    love.graphics.setColor(255,255,255,255);
    love.graphics.clear( E_BACKGROUND:Red(), E_BACKGROUND:Green(), E_BACKGROUND:Blue(), 255 )
    Editor.Draw()
end


-- UNSER INPUTS ===================================================


function EditorScreen:TextInput( iT )
    return  Editor.TextInput( iT )
end


function EditorScreen:KeyPressed( iKey, iScancode, iIsRepeat )
    return  Editor.KeyPressed( iKey, iScancode, iIsRepeat )
end


function EditorScreen:KeyReleased( iKey, iScancode )
    return  Editor.KeyReleased( iKey, iScancode )
end


function EditorScreen:MouseMoved( iX, iY )
    return  Editor.MouseMoved( iX, iY )
end


function EditorScreen:MousePressed( iX, iY, iButton, iIsTouch )
    return  Editor.MousePressed( iX, iY, iButton, iIsTouch )
end


function EditorScreen:MouseReleased( iX, iY, iButton, iIsTouch )
    return  Editor.MouseReleased( iX, iY, iButton, iIsTouch )
end


function EditorScreen:WheelMoved( iX, iY )
    return  Editor.WheelMoved( iX, iY )
end

-- Release resources before Screen Switch or App Close
function EditorScreen:Finalize()
end

-- RETURN CHUNK AS GLOBAL OBJECT ======================================
return EditorScreen
