local Background            = require "src/Image/Background"
local Tree                  = require "src/Objects/Environnement/Tree"
local Singe                 = require "src/Objects/Heros/Singe"
local Lapin                 = require "src/Objects/Heros/Lapin"
local BigImage              = require "src/Image/BigImage"
local AttackGenerator       = require "src/Game/AttackGenerator"
local ImageShapeComputer    = require "src/Image/ImageShapeComputer"
local BabyTree              = require "src/Objects/Environnement/BabyTree"
local GrownTree             = require "src/Objects/Environnement/GrownTree"
local WaterPipe             = require "src/Objects/Environnement/WaterPipe"
local ObjectPool            = require "src/Objects/Pools/ObjectPool"
local CollidePool           = require "src/Objects/Pools/CollidePool"

local Terrain               = require "src/Objects/Terrain"
local Level1                = require "src/Game/Level/Level1"



local Game = {}

function beginContact( a, b, coll )
    if not coll:isTouching() then
        return
    end

    if a:getUserData() == nil or b:getUserData() == nil then
        return
    end

    if a:getUserData().needDestroy or b:getUserData().needDestroy then
        return
    end

    CollidePool.AddCollision( a:getUserData(), b:getUserData() )
    CollidePool.AddCollision( b:getUserData(), a:getUserData() )
end

function endContact( a, b, coll )

end

function preSolve( a, b, coll )

end

function postSolve( a, b, coll, normalimpulse, tangentimpulse )

end


function Game:Initialize()

    AttackGenerator:Initialize()

    love.physics.setMeter( 100 )
    world = love.physics.newWorld( 0, 9.81 * love.physics.getMeter(), true ) --normal gravity
    world:setCallbacks( beginContact, endContact, preSolve, postSolve )

    local level1        =  Level1:New( world )

end


function Game:Update( dt )

    Level1:Update( dt )

    if love.keyboard.isDown( "o" )  then
        Camera.scale = Camera.scale + 0.01
    elseif love.keyboard.isDown( "l" )  then
        Camera.scale = Camera.scale - 0.01
    elseif love.keyboard.isDown( "p" )  then
        Camera.scale = 1.0
    end

    return 1

end


function Game:Draw()

    Level1:Draw()
    self:DEBUGWorldHITBOXESDraw( "all" )

end



function Game:KeyPressed( iKey, iScancode, iIsRepeat )

    Level1:KeyPressed( iKey, iScancode, iIsRepeat )

end

function Game:KeyReleased( key, scancode )
    Level1:KeyReleased( key, scancode )
end

function  Game:mousepressed( iX, iY, iButton, iIsTouch )
    Level1:MousePressed(  iX, iY, iButton, iIsTouch )
end


function Game:DEBUGWorldHITBOXESDraw( iWhatToDraw )
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

                love.graphics.polygon( "fill", Camera.MapToScreenMultiple( b:getWorldPoints( v:getShape():getPoints() ) ) )

            -- CIRCLES
            elseif ( v:getShape():getType() == "circle" ) and ( iWhatToDraw == "all" or iWhatToDraw == "circle"  ) then

                radius  = v:getShape():getRadius()
                x, y    = v:getShape():getPoint()
                xBody, yBody = b:getPosition()

                -- x, y are coordinates from the center of body, so we offset to match center in screen coordinates
                x = x + xBody
                y = y + yBody
                x, y = Camera.MapToScreen( x, y )
                love.graphics.circle( "fill", x, y, radius )

            -- EDGES
            elseif ( v:getShape():getType() == "edge" ) and ( iWhatToDraw == "all" or iWhatToDraw == "edge"  ) then

                love.graphics.setColor( 255, 0, 0, 200 )
                love.graphics.line( Camera.MapToScreenMultiple( b:getWorldPoints( v:getShape():getPoints() ) ) )

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


return Game