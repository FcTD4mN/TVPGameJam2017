--[[===================================================================
    File: Application.Screens.TestScreen.lua

    @@@@: The Menu Screen.
    Menu, select options & Stuff

===================================================================--]]

-- INCLUDES ===========================================================
local Screen            = require "src/Application/Screens/Screen"
local Camera            = require( "src/Camera/Camera" )
local ShapeAnalyser     = require( "src/Image/ShapeAnalyser" )
local Rectangle         = require( "src/Math/Rectangle" )

-- OBJECT INITIALISATION ==============================================
local TestScreen = {}
setmetatable( TestScreen, Screen )
Screen.__index = Screen

-- Constructor
function TestScreen:New()
    local newTestScreen = {}
    setmetatable( newTestScreen, TestScreen )
    TestScreen.__index = TestScreen

    newTestScreen.mCamera = Camera:New( 100, 100, 800, 600, 1.0 );

    return newTestScreen

end

-- LOCAL MEMBERS =====================================================
    -- That way they are local to file

-- Called by Global Manager only on SetScreen.
function TestScreen:Initialize()
    ShapeAnalyser.Initialize( "resources/Images/AlgoTest.png" )
    ShapeAnalyser.Run( Rectangle:New( 0, 0, 200, 200 ), 200, 1 )

end

-- OBJECT FUNCTIONS ===================================================
function TestScreen:Update( iDT )
end

function TestScreen:Draw()
    ShapeAnalyser.DebugDraw( self.mCamera )
end


--USER INPUT============================================================================


function TestScreen:TextInput( iT )
    --Nothing special
end


function TestScreen:KeyPressed( key, scancode, isrepeat )
    MainMenu:KeyPressed( iKey, iScancode, iIsRepeat )
end


function TestScreen:KeyReleased( key, scancode )
    MainMenu:KeyReleased( iKey, iScancode )
end


function TestScreen:MouseMoved( iX, iY )
    --Nothing special
end


function TestScreen:mousepressed( iX, iY, iButton, iIsTouch )
    MainMenu:mousepressed( iX, iY, iButton, iIsTouch )
end


function TestScreen:MouseReleased( iX, iY, iButton, iIsTouch )
    --Nothing special
end


function TestScreen:WheelMoved( iX, iY )
    --Nothing special
end


-- Release resources before Screen Switch or App Close ======================================
function TestScreen:Finalize()
    -- nothing special here
end

-- RETURN CHUNK AS GLOBAL OBJECT ======================================
return TestScreen
