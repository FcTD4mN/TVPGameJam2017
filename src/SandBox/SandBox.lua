GameScreen          = require("src/Application/Screens/GameScreen")
MenuScreen          = require("src/Application/Screens/MenuScreen")
EditorScreen        = require("src/Application/Screens/EditorScreen")

local SandBox = {}

function SandBox:Initialize()

    local gameScreen    = GameScreen:New();
    local menuScreen    = MenuScreen:New();
    local editorScreen  = EditorScreen:New();

    Manager:PushScreen( gameScreen );
    Manager:PushScreen( menuScreen );
    Manager:PushScreen( editorScreen );
    Manager:SetScreen( 3 ); -- Starts at 1 

end


function SandBox:Update( dt )

    Manager:UpdateScreen( dt );

    return 2 -- kSandBox = 2

end


function SandBox:Draw()
    Manager:DrawScreen();

end


function SandBox:KeyPressed( key, scancode, isrepeat )
    Manager:KeyPressed( key, scancode, isrepeat );
end

function SandBox:KeyReleased( key, scancode )
    Manager:KeyReleased( key, scancode );
end

function  SandBox:mousepressed( iX, iY, iButton, iIsTouch )
    Manager:mousepressed( iX, iY, iButton, iIsTouch );
end

return SandBox