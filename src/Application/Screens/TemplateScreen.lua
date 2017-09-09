--[[ 
    Do not use this File / Object / Class.
    It's just a template for making new screens quickly.
--]]

local Screen = require "src/Application/Screens/Screen"

local TemplateScreen = {}
setmetatable( TemplateScreen, Screen )
Screen.__index = Screen


function TemplateScreen:New()
    local newTemplateScreen = {}
    setmetatable( newTemplateScreen, self )
    self.__index = self

    return newTemplateScreen

end

function TemplateScreen:Initialize()
end

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

function TemplateScreen:Finalize()
end 

return TemplateScreen