--[[===================================================================
    File: Application.Screens.MenuScreen.lua

    @@@@: The Menu Screen.
    Menu, select options & Stuff

===================================================================--]]

-- INCLUDES ===========================================================
local Screen    = require "src/Application/Screens/Screen"
local MainMenu  = require( "src/MainMenu/MainMenu" )

-- OBJECT INITIALISATION ==============================================
local MenuScreen = {}
setmetatable( MenuScreen, Screen )
Screen.__index = Screen

-- Constructor
function MenuScreen:New()
    local newMenuScreen = {}
    setmetatable( newMenuScreen, MenuScreen )
    MenuScreen.__index = MenuScreen

    return newMenuScreen

end

-- LOCAL MEMBERS =====================================================
    -- That way they are local to file

-- Called by Global Manager only on SetScreen.
function MenuScreen:Initialize()
    MainMenu:Initialize()
end

-- OBJECT FUNCTIONS ===================================================
function MenuScreen:Update( iDT )
    return  MainMenu:Update( iDT )
end

function MenuScreen:Draw()
    MainMenu:Draw()
end


--USER INPUT============================================================================


function MenuScreen:TextInput( iT )
    --Nothing special
end


function MenuScreen:KeyPressed( key, scancode, isrepeat )
    print( key )
    MainMenu:KeyPressed( iKey, iScancode, iIsRepeat )
end


function MenuScreen:KeyReleased( key, scancode )
    MainMenu:KeyReleased( iKey, iScancode )
end


function MenuScreen:MouseMoved( iX, iY )
    --Nothing special
end


function MenuScreen:mousepressed( iX, iY, iButton, iIsTouch )
    MainMenu:mousepressed( iX, iY, iButton, iIsTouch )
end


function MenuScreen:MouseReleased( iX, iY, iButton, iIsTouch )
    --Nothing special
end


function MenuScreen:WheelMoved( iX, iY )
    --Nothing special
end


-- Release resources before Screen Switch or App Close ======================================
function MenuScreen:Finalize()
    -- nothing special here
end

-- RETURN CHUNK AS GLOBAL OBJECT ======================================
return MenuScreen
