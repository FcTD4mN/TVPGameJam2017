--[[===================================================================
    File: Application.Screens.MenuScreen.lua

    @@@@: The Menu Screen.
    Menu, select options & Stuff

===================================================================--]]

-- INCLUDES ===========================================================
local Screen    = require "src/Application/Screens/Screen"
local MainMenu  = require( "src/CommOp1/MainMenu/MainMenu" )

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
    return  false
end


function MenuScreen:KeyPressed( key, scancode, isrepeat )
    return  MainMenu:KeyPressed( iKey, iScancode, iIsRepeat )
end


function MenuScreen:KeyReleased( key, scancode )
    return  MainMenu:KeyReleased( iKey, iScancode )
end


function MenuScreen:MouseMoved( iX, iY )
    return  false
end


function MenuScreen:MousePressed( iX, iY, iButton, iIsTouch )
    return  MainMenu:MousePressed( iX, iY, iButton, iIsTouch )
end


function MenuScreen:MouseReleased( iX, iY, iButton, iIsTouch )
    return  false
end


function MenuScreen:WheelMoved( iX, iY )
    return  false
end


-- Release resources before Screen Switch or App Close ======================================
function MenuScreen:Finalize()
    -- nothing special here
end

-- RETURN CHUNK AS GLOBAL OBJECT ======================================
return MenuScreen
