local Screen = require "src/Application/Screens/Screen"
local Widget = require "src/GUI/Widgets/Widget"

local EditorScreen = {}
setmetatable( EditorScreen, Screen )
Screen.__index = Screen


function EditorScreen:New()
    local newEditorScreen = {}
    setmetatable( newEditorScreen, self )
    self.__index = self

    Base:log( Base.name );

    return newEditorScreen
end

function EditorScreen:Initialize()
    testWidget1 = Widget:New( nil, 50, 50, 300, 300, nil);
    testWidget2 = Widget:New( nil, 200, 200, 220, 400, nil);
end

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

function EditorScreen:Finalize()
end 

return EditorScreen