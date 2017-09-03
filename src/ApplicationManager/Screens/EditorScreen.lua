local Screen = require "src/ApplicationManager/Screens/Screen"
local Widget = require "src/GUI/Widgets/Widget"

local EditorScreen = {}
setmetatable( EditorScreen, Screen )
Screen.__index = Screen


function EditorScreen:New()
    local newEditorScreen = {}
    setmetatable( newEditorScreen, self )
    self.__index = self

    self:Initialize()
    myTestWidget = Widget:New( nil, 5, 5, 10, 10, 6);
    return newEditorScreen

end

function EditorScreen:Initialize()
    
end

function EditorScreen:Update( dt )
end

function EditorScreen:Draw()
    love.graphics.clear( 200, 200, 200, 255 )

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