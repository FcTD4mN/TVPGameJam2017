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

    Manager.screens[ #Manager.screens ]:Finalize();
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
    love.graphics.clear( 0, 0, 0, 255 )
    Manager.screens[ #Manager.screens ]:Draw();
end


--USER INPUT============================================================================


function Manager:TextInput( iT )
    Manager.screens[ #Manager.screens ]:TextInput( iT );
end


function Manager:KeyPressed( iKey, iScancode, iIsRepeat )
    Manager.screens[ #Manager.screens ]:KeyPressed( iKey, iScancode, iIsRepeat );
end


function Manager:KeyReleased( iKey, iScancode )
    Manager.screens[ #Manager.screens ]:KeyReleased( iKey, iScancode );
end


function Manager:MouseMoved( iX, iY )
    Manager.screens[ #Manager.screens ]:MouseMoved( iX, iY );
end


function Manager:MousePressed( iX, iY, iButton, iIsTouch )
    Manager.screens[ #Manager.screens ]:MousePressed( iX, iY, iButton, iIsTouch );
end


function Manager:MouseReleased( iX, iY, iButton, iIsTouch )
    Manager.screens[ #Manager.screens ]:MouseReleased( iX, iY, iButton, iIsTouch );
end


function Manager:WheelMoved( iX, iY )
    Manager.screens[ #Manager.screens ]:WheelMoved( iX, iY );
end


function Manager:Finalize()
    Manager.screens[ #Manager.screens ]:Finalize()

end


-- RETURN CHUNK AS GLOBAL OBJECT ======================================
return Manager
