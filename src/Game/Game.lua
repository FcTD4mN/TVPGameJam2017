local Game = {}

function Game:Load()
    love.physics.setMeter( 100 )
    world = love.physics.newWorld( 0, 9.81 * love.physics.getMeter(), true ) --normal gravity

    hero1 = Hero:New( world, love.graphics.getWidth() / 2, love.graphics.getHeight() / 2, 0 )
    hero2 = Hero:New( world, love.graphics.getWidth() / 2, love.graphics.getHeight() / 2, 1 )
end

function Game:Draw()
    hero1:Draw()
    hero2:Draw()
end

function Game:Update( dt )
    hero1:Update( dt )
    hero2:Update( dt )
end

function Game:KeyPressed( key, scancode, isrepeat )
    hero1:KeyPressed( key, scancode, isrepeat )
    hero2:KeyPressed( key, scancode, isrepeat )
end

function Game:KeyReleased( key, scancode )
    hero1:KeyPressed( key, scancode )
    hero2:KeyPressed( key, scancode )
end

return Game