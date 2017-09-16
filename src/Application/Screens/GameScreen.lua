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

    if love.keyboard.isDown( "o" )  then
        level1.mCamera.mScale = level1.mCamera.mScale + 0.01
    elseif love.keyboard.isDown( "l" )  then
        level1.mCamera.mScale = level1.mCamera.mScale - 0.01
    elseif love.keyboard.isDown( "p" )  then
        level1.mCamera.mScale = 1.0
    end

end


function GameScreen:Draw()

    level1:Draw()
    self:DEBUGWorldHITBOXESDraw( "all" )

end


function GameScreen:KeyPressed( iKey, iScancode, iIsRepeat )

    level1:KeyPressed( iKey, iScancode, iIsRepeat )
end

function GameScreen:KeyReleased( key, scancode )
    level1:KeyReleased( key, scancode )
end


function GameScreen:mousepressed( iX, iY, iButton, iIsTouch )
    level1:MousePressed(  iX, iY, iButton, iIsTouch )
end


-- DEBUG ===================================================
function GameScreen:DEBUGWorldHITBOXESDraw( iWhatToDraw )
    local red = 255
    local green = 0
    local blue = 0

    allBodies = world:getBodyList()

    for a, b in pairs( allBodies ) do
        red = 255
        green = 0
        blue = 0
        fixtures = b:getFixtureList()

        for k,v in pairs( fixtures ) do

            love.graphics.setColor( red, green, blue, 125 )

            -- POLYGONS
            if( v:getShape():getType() == "polygon" ) and ( iWhatToDraw == "all" or iWhatToDraw == "polygon"  ) then

                love.graphics.polygon( "fill", level1.mCamera:MapToScreenMultiple( b:getWorldPoints( v:getShape():getPoints() ) ) )

            -- CIRCLES
            elseif ( v:getShape():getType() == "circle" ) and ( iWhatToDraw == "all" or iWhatToDraw == "circle"  ) then

                radius  = v:getShape():getRadius()
                x, y    = v:getShape():getPoint()
                xBody, yBody = b:getPosition()

                -- x, y are coordinates from the center of body, so we offset to match center in screen coordinates
                x = x + xBody
                y = y + yBody
                x, y = level1.mCamera:MapToScreen( x, y )
                love.graphics.circle( "fill", x, y, radius )

            -- EDGES
            elseif ( v:getShape():getType() == "edge" ) and ( iWhatToDraw == "all" or iWhatToDraw == "edge"  ) then

                love.graphics.setColor( 255, 0, 0, 200 )
                love.graphics.line( level1.mCamera:MapToScreenMultiple( b:getWorldPoints( v:getShape():getPoints() ) ) )

            -- CHAINS
            elseif ( v:getShape():getType() == "chain" ) and ( iWhatToDraw == "all" or iWhatToDraw == "chain"  ) then

                --TODO
            end

            -- We cycle through colors
            red = red + 100
            green = green + math.floor( red / 255 ) * 100
            blue = blue + math.floor( blue / 255 ) * 100
            red = red % 256
            green = green % 256
            blue = blue % 256

        end

    end

end

-- Release resources before Screen Switch or App Close
function GameScreen:Finalize()
end

-- RETURN CHUNK AS GLOBAL OBJECT ======================================
return GameScreen
