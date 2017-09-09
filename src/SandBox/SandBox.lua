Manager  = require("src/Application/Manager")

GameScreen          = require("src/Application/Screens/GameScreen")
MenuScreen          = require("src/Application/Screens/MenuScreen")
EditorScreen        = require("src/Application/Screens/EditorScreen")

local SandBox = {}

function SandBox:Initialize()

    manager = Manager:New();

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