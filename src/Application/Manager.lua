--[[===================================================================
    File: Base.Base.lua

    @@@@: This is the Base Module.
    A module is a Global Singleton Objects that will act like a
    namespace. See Base.Module.lua for more details.
    This class is SINGLETON

===================================================================--]]

-- INCLUDES ===========================================================
-- NONE

-- OBJECT INITIALISATION ==============================================
local Manager = {};

function Manager:Initialize()

    Manager.screens = {}
    -- Manager.currentScreen = 1;
    Manager.running = true;

    return  Manager;

end

-- OBJECT FUNCTIONS ===================================================

function Manager:PushScreen( iScreen )
    if( iScreen:Type() == "Screen" ) then
        iScreen:Initialize()
        table.insert( Manager.screens, iScreen );
    end

end


function Manager:PopScreen()

    table.remove( Manager.screens, #Manager.screens );

end


-- function Manager:SetScreen( iNumScreen )

--     Manager.currentScreen = iNumScreen;
--     Manager.screens[ Manager.currentScreen ]:Initialize();

-- end


function Manager:Update( dt )
    -- Manager.currentScreen = Manager.screens[ Manager.currentScreen ]:Update( dt );
    Manager.screens[ #Manager.screens ]:Update( dt );

end


function Manager:Draw()
    love.graphics.setColor(255,255,255,255);
    love.graphics.clear( 200, 200, 200, 255 )
    Manager.screens[ #Manager.screens ]:Draw();
end


function Manager:KeyPressed( iKey, iScancode, iIsRepeat )
    Manager.screens[ #Manager.screens ]:KeyPressed( iKey, iScancode, iIsRepeat );

end


function Manager:KeyReleased( iKey, iScancode )
    Manager.screens[ #Manager.screens ]:KeyReleased( iKey, iScancode );

end


function Manager:mousepressed( iX, iY, iButton, iIsTouch )
    Manager.screens[ #Manager.screens ]:mousepressed( iX, iY, iButton, iIsTouch );

end


function Manager:Finalize()
    Manager.screens[ #Manager.screens ]:Finalize()

end


-- RETURN CHUNK AS GLOBAL OBJECT ======================================
return Manager
