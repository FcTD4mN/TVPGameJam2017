ApplicationManager  = require("src/ApplicationManager/ApplicationManager")

GameScreen          = require("src/ApplicationManager/Screens/GameScreen")
MenuScreen          = require("src/ApplicationManager/Screens/MenuScreen")
EditorScreen        = require("src/ApplicationManager/Screens/EditorScreen")

local SandBox = {}

function SandBox:Initialize()

    manager = ApplicationManager:New();

    local gameScreen    = GameScreen:New();
    local menuScreen    = MenuScreen:New();
    local editorScreen  = EditorScreen:New();

    manager:PushScreen( gameScreen );
    manager:PushScreen( menuScreen );
    manager:PushScreen( editorScreen );
    manager:SetScreen( 3 ); -- Starts at 1 

end


function SandBox:Update( dt )

    manager:UpdateScreen( dt );

    return 2 -- kSandBox = 2

end


function SandBox:Draw()
    love.graphics.clear( 200, 200, 200, 255 )

    manager:DrawScreen();

end


function SandBox:KeyPressed( key, scancode, isrepeat )
    manager:KeyPressed( key, scancode, isrepeat );
end

function SandBox:KeyReleased( key, scancode )
    manager:KeyReleased( key, scancode );
end

function  SandBox:mousepressed( iX, iY, iButton, iIsTouch )
    manager:mousepressed( iX, iY, iButton, iIsTouch );
end

return SandBox