local Screen = require "src/ApplicationManager/Screens/Screen"


local MenuScreen = {}
setmetatable( MenuScreen, Screen )
Screen.__index = Screen


function MenuScreen:New()
    local newMenuScreen = {}
    setmetatable( newMenuScreen, self )
    self.__index = self

    self:Initialize()

    return newMenuScreen

end

function MenuScreen:Initialize()
end

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

function MenuScreen:Finalize()
end 

return MenuScreen