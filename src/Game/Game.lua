local Hero = require "src/Game/Hero"

local Game = {}

function Game:Initialize()
    love.physics.setMeter( 100 )
    world = love.physics.newWorld( 0, 9.81 * love.physics.getMeter(), true ) --normal gravity

    hero1 = Hero:New( world, love.graphics.getWidth() / 2, love.graphics.getHeight() / 2, 0 )
    --hero2 = Hero:New( world, love.graphics.getWidth() / 2, love.graphics.getHeight() / 2, 1 )

    floor = {}
    floor.body = love.physics.newBody( world, love.graphics.getWidth() / 2, love.graphics.getHeight() - 50, "static" )
    floor.shape = love.physics.newRectangleShape( love.graphics.getWidth(), 100 )
    floor.fixture = love.physics.newFixture( floor.body, floor.shape )
    floor.fixture:setFriction( 0.0 )
end

function Game:Draw()
    hero1:Draw()
    --hero2:Draw()
    
    love.graphics.polygon( "fill", floor.body:getWorldPoints( floor.shape:getPoints() ) )
end

function Game:Update( dt )
    hero1:Update( dt )
    --hero2:Update( dt )
    world:update( dt )
end

function Game:KeyPressed( key, scancode, isrepeat )
    hero1:KeyPressed( key, scancode, isrepeat )
    --hero2:KeyPressed( key, scancode, isrepeat )
end

function Game:KeyReleased( key, scancode )
    hero1:KeyReleased( key, scancode )
    --hero2:KeyPressed( key, scancode )
end

return Game