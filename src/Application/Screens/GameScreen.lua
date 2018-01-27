--[[===================================================================
    File: Application.Screens.GameScreen.lua

    @@@@: The Game Screen.
    Dedicated for the actual game, playing etc...

===================================================================--]]

-- INCLUDES ===========================================================
local Screen        = require "src/Application/Screens/Screen"

local CollidePool   = require "src/Objects/Pools/CollidePool"
local Level1        = require "src/Game/Level/Level1"


-- OBJECT INITIALISATION ==============================================
local GameScreen = {}
setmetatable( GameScreen, Screen )
Screen.__index = Screen


-- Constructor
function GameScreen:New()
    local newGameScreen = {}
    setmetatable( newGameScreen, self )
    self.__index = self

    return newGameScreen

end


function beginContact( a, b, coll )

    if not coll:isTouching() then
        return
    end

    if a:getUserData() == nil or b:getUserData() == nil then
        return
    end

    if a:getUserData().mDestroy or b:getUserData().mDestroy then
        return
    end

    CollidePool.AddCollisionBeginning( a:getUserData(), b:getUserData() )
    CollidePool.AddCollisionBeginning( b:getUserData(), a:getUserData() )

end


function endContact( a, b, coll )

    if a:getUserData() == nil or b:getUserData() == nil then
        return
    end

    if a:getUserData().mDestroy or b:getUserData().mDestroy then
        return
    end

    CollidePool.AddCollisionEnding( a:getUserData(), b:getUserData() )
    CollidePool.AddCollisionEnding( b:getUserData(), a:getUserData() )

end


function preSolve( a, b, coll )

    if a:getUserData() == nil or b:getUserData() == nil then
        return
    end

    if a:getUserData().mDestroy or b:getUserData().mDestroy then
        return
    end

    CollidePool.AddCollisionPre( a:getUserData(), b:getUserData() )
    CollidePool.AddCollisionPre( b:getUserData(), a:getUserData() )

end


function postSolve( a, b, coll, normalimpulse, tangentimpulse )

    if a:getUserData() == nil or b:getUserData() == nil then
        return
    end

    if a:getUserData().mDestroy or b:getUserData().mDestroy then
        return
    end

    CollidePool.AddCollisionPost( a:getUserData(), b:getUserData(), normalimpulse, tangentimpulse )
    CollidePool.AddCollisionPost( b:getUserData(), a:getUserData(), normalimpulse, tangentimpulse )

end


-- LOCAL MEMBERS =====================================================
    -- That way they are local to file
    -- NONE YET

-- Called by Global Manager only on SetScreen.
function GameScreen:Initialize()

    AttackGenerator:Initialize()

    love.physics.setMeter( 100 )
    world = love.physics.newWorld( 0, 9.81 * love.physics.getMeter(), true ) --normal gravity
    world:setCallbacks( beginContact, endContact, preSolve, postSolve )

    level1        =  Level1:NewFromXML( world )
    -- level1        =  Level1:New( world )
end


-- OBJECT FUNCTIONS ===================================================
function GameScreen:Update( dt )

    level1:Update( dt )

    -- if love.keyboard.isDown( "o" )  then
    --     level1.mCamera.mScale = level1.mCamera.mScale + 0.01
    -- elseif love.keyboard.isDown( "l" )  then
    --     level1.mCamera.mScale = level1.mCamera.mScale - 0.01
    -- elseif love.keyboard.isDown( "p" )  then
    --     level1.mCamera.mScale = 1.0
    -- end

end


function GameScreen:Draw()

    level1:Draw()
    --DEBUGWorldHITBOXESDraw( world, level1.mCamera, "all" )

end


--USER INPUT============================================================================


function GameScreen:TextInput( iT )
    return  false
end


function GameScreen:KeyPressed( iKey, iScancode, iIsRepeat )
    return  level1:KeyPressed( iKey, iScancode, iIsRepeat )
end


function GameScreen:KeyReleased( iKey, iScancode )
    return  level1:KeyReleased( iKey, iScancode )
end


function GameScreen:MouseMoved( iX, iY )
    return   false
end


function GameScreen:MousePressed( iX, iY, iButton, iIsTouch )
    return  level1:MousePressed(  iX, iY, iButton, iIsTouch )
end


function GameScreen:MouseReleased( iX, iY, iButton, iIsTouch )
    return  false
end


function GameScreen:WheelMoved( iX, iY )
    return  false
end


-- Release resources before Screen Switch or App Close ======================================
function GameScreen:Finalize()
end


-- RETURN CHUNK AS GLOBAL OBJECT ======================================
return GameScreen
