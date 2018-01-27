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
local Point             = require( "src/Math/Point" )
local Polygon           = require( "src/Math/Polygon" )

-- OBJECT INITIALISATION ==============================================
local TestScreen = {}
setmetatable( TestScreen, Screen )
Screen.__index = Screen


-- Constructor
function TestScreen:New()
    local newTestScreen = {}
    setmetatable( newTestScreen, TestScreen )
    TestScreen.__index = TestScreen

    newTestScreen.mCamera = Camera:New( 0, 0, 800, 600, 1.0 );

    return newTestScreen

end

-- LOCAL MEMBERS =====================================================
    -- That way they are local to file

-- Called by Global Manager only on SetScreen.
function TestScreen:Initialize()

    indexCount = 0
    process = false

    polygon = Polygon:New()
    -- polygon:AddPoint( Point:New( 200+500, 170 ) )
    -- polygon:AddPoint( Point:New( 200+500, 400 ) )
    -- polygon:AddPoint( Point:New( 340+500, 500 ) )
    -- polygon:AddPoint( Point:New( 520+500, 400 ) )
    -- polygon:AddPoint( Point:New( 520+500, 170 ) )

    polygon:AddPoint( Point:New( 160+50, 170 ) )
    polygon:AddPoint( Point:New( 160+50, 300 ) )
    polygon:AddPoint( Point:New( 250+50, 400 ) )
    polygon:AddPoint( Point:New( 300+50, 300 ) )
    polygon:AddPoint( Point:New( 300+50, 190 ) )

    -- polygon:AddPoint( Point:New( 200+50, 170+200 ) )
    -- polygon:AddPoint( Point:New( 160+50, 400+200 ) )
    -- polygon:AddPoint( Point:New( 340+50, 500+200 ) )
    -- polygon:AddPoint( Point:New( 520+50, 400+200 ) )
    -- polygon:AddPoint( Point:New( 500+50, 190+200 ) )

    print( love.math.isConvex( polygon:GetAsVertexesList() ) )
    print( polygon:IsConvex() )

end

-- OBJECT FUNCTIONS ===================================================
function TestScreen:Update( iDT )

end


function TestScreen:Draw()

    polygon:Draw( self.mCamera )

end


--USER INPUT============================================================================


function TestScreen:TextInput( iT )
    return  false
end


function TestScreen:KeyPressed( key, scancode, isrepeat )

    return  false
end


function TestScreen:KeyReleased( key, scancode )
    return  false
end


function TestScreen:MouseMoved( iX, iY )
    return  false
end


function TestScreen:MousePressed( iX, iY, iButton, iIsTouch )
    return  MainMenu:MousePressed( iX, iY, iButton, iIsTouch )
end


function TestScreen:MouseReleased( iX, iY, iButton, iIsTouch )
    return  false
end


function TestScreen:WheelMoved( iX, iY )
    return  false
end


-- Release resources before Screen Switch or App Close ======================================
function TestScreen:Finalize()
    -- nothing special here
end

-- RETURN CHUNK AS GLOBAL OBJECT ======================================
return TestScreen
