local Hero = require "src/Game/Hero"
local Object_Box = require "src/Objects/Object_Box"

local Game = {}

function Game:Initialize()
    love.physics.setMeter( 100 )
    world = love.physics.newWorld( 0, 9.81 * love.physics.getMeter(), true ) --normal gravity

    hero1 = Hero:New( world, love.graphics.getWidth() / 2, love.graphics.getHeight() / 2, 0 )
    object_box1 = Object_Box:New( world, 200, 50, 0 )
    object_box2 = Object_Box:New( world,200, -80, 0 )

    floor = {}
    floor.body = love.physics.newBody( world, love.graphics.getWidth() / 2, love.graphics.getHeight() - 50, "static" )
    floor.shape = love.physics.newRectangleShape( love.graphics.getWidth(), 100 )
    floor.fixture = love.physics.newFixture( floor.body, floor.shape )
    floor.fixture:setFriction( 1.0 )
end

function Game:Draw()
    object_box1:Draw()
    object_box2:Draw()
    hero1:Draw()
    --hero2:Draw()
    love.graphics.polygon( "fill", floor.body:getWorldPoints( floor.shape:getPoints() ) )
end

function Game:Update( dt )
    object_box1:Update( dt )
    object_box2:Update( dt )
    hero1:Update( dt )
    --hero2:Update( dt )
    world:update( dt )
    return 1
end

function Game:KeyPressed( key, scancode, isrepeat )
    hero1:KeyPressed( key, scancode, isrepeat )
    --hero2:KeyPressed( key, scancode, isrepeat )
end

function Game:KeyReleased( key, scancode )
    hero1:KeyReleased( key, scancode )
    --hero2:KeyPressed( key, scancode )
end

function  Game:mousepressed( iX, iY, iButton, iIsTouch )
    --
end


return Game