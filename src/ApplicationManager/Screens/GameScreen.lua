local Screen = require "src/ApplicationManager/Screens/Screen"


local GameScreen = {}
setmetatable( GameScreen, Screen )
Screen.__index = Screen


function GameScreen:New()
    local newGameScreen = {}
    setmetatable( newGameScreen, self )
    self.__index = self
    
    return newGameScreen

end

function GameScreen:Initialize()
end

function GameScreen:Update( dt )    
end

function GameScreen:Draw()
    love.graphics.clear( 255, 200, 200, 255 )

end

function GameScreen:KeyPressed( key, scancode, isrepeat )
end

function GameScreen:KeyReleased( key, scancode )
end

function GameScreen:mousepressed( iX, iY, iButton, iIsTouch )
end

function GameScreen:Finalize()
end 

return GameScreen