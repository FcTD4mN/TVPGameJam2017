local Background    = require "src/Objects/Background"
local Hero          = require "src/Game/Hero"
local Object_Box    = require "src/Objects/Object_Box"

local Game = {}

function Game:Initialize()
    love.physics.setMeter( 100 )
    world = love.physics.newWorld( 0, 9.81 * love.physics.getMeter(), true ) --normal gravity

    hero1 = Hero:New( world, love.graphics.getWidth() / 2, love.graphics.getHeight() / 2, 0 )
    object_box1 = Object_Box:New( world, 200, 50, 0 )
    object_box2 = Object_Box:New( world,600, -80, 0 )

    backgrounds = {}
    foregrounds = {}
    table.insert( backgrounds, Background:New( "resources/Images/Backgrounds/Background3000x720.png", -100, 0, 3000, 720, 0 ) )
    table.insert( backgrounds, Background:New( "resources/Images/Backgrounds/Terrain3000x720.png", -100, 0, 3000, 720, 0 ) )
    table.insert( foregrounds, Background:New( "resources/Images/Backgrounds/Foreground3000x720.png", -100, 0, 3000, 720, -2 ) )

    floor = {}
    floor.body = love.physics.newBody( world, love.graphics.getWidth() / 2, love.graphics.getHeight() - 10, "static" )
    floor.shape = love.physics.newRectangleShape( 3000, 10 )
    floor.fixture = love.physics.newFixture( floor.body, floor.shape )
    floor.fixture:setFriction( 1.0 )
end

function Game:Draw()
    x, y = Camera.MapToScreen( 0, 0 )
    for k,v in pairs( backgrounds ) do
        v:Draw()
    end

    object_box1:Draw()
    object_box2:Draw()


    hero1:Draw()
    --hero2:Draw()
    x, y, x2, y2 = floor.shape:computeAABB( 0, 0, 0 )
    x, y, x2, y2 = floor.body:getWorldPoints( x, y, x2, y2 )
    x, y = Camera.MapToScreen( x, y )
    x2, y2 = Camera.MapToScreen( x2, y2 )

    love.graphics.rectangle( "fill", x, y, x2-x, y2-y )


    for k,v in pairs( foregrounds ) do
        v:Draw()
    end
end

function Game:Update( dt )

    for k,v in pairs( backgrounds ) do
        v:Update( dt )
    end

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