local Screen = require "src/ApplicationManager/Screens/Screen"
local Widget = require "src/GUI/Widgets/Widget"

local EditorScreen = {}
setmetatable( EditorScreen, Screen )
Screen.__index = Screen


function EditorScreen:New()
    local newEditorScreen = {}
    setmetatable( newEditorScreen, self )
    self.__index = self

    return newEditorScreen
end

function EditorScreen:Initialize()
    testWidget1 = Widget:New( nil, 50, 50, 200, 300, nil);
    testWidget2 = Widget:New( nil, 300, 70, 220, 400, nil);
end

function EditorScreen:Update( dt )
end

function EditorScreen:Draw()
    love.graphics.setColor(255,255,255,255);
    love.graphics.clear( 200, 200, 200, 255 )

    testWidget1:Draw()
    testWidget2:Draw()
end

function EditorScreen:KeyPressed( key, scancode, isrepeat )
end

function EditorScreen:KeyReleased( key, scancode )
end

function EditorScreen:mousepressed( iX, iY, iButton, iIsTouch )
end

function EditorScreen:Finalize()
end 

return EditorScreen