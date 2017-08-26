--local Hero = require "src/Game/Hero"
local Box = require "src/Objects/Object"

local Test = {}

function Test:Initialize()
    love.physics.setMeter( 100 )
    world = love.physics.newWorld( 0, 9.81 * love.physics.getMeter(), true ) --normal gravity

    box = Box:New( world, 50, 50, 110, 95, "dynamic", false, 0.5 )
    box:AddAnimation( "resources/Images/Objects/Object_Box.png", 1, 1, 0, 0, 110, 95 )
    box:SetCurrentAnimation( 1 )

  --  hero1 = Hero:New( world, love.graphics.getWidth() / 2, love.graphics.getHeight() / 2, 0 )
    --hero2 = Hero:New( world, love.graphics.getWidth() / 2, love.graphics.getHeight() / 2, 1 )

    floor = {}
    floor.body = love.physics.newBody( world, love.graphics.getWidth() / 2, love.graphics.getHeight() - 50, "static" )
    floor.shape = love.physics.newRectangleShape( love.graphics.getWidth(), 100 )
    floor.fixture = love.physics.newFixture( floor.body, floor.shape )
    floor.fixture:setFriction( 0.0 )
end

function Test:Draw()
    box:DrawObject()
end

function Test:Update( dt )
    box:UpdateObject( dt )
end

function Test:KeyPressed( key, scancode, isrepeat )
end

function Test:KeyReleased( key, scancode )
end

return Game