local Camera = require "src/Camera/Camera"
local Object = require "src/Objects/Object"

local Hero = Object:New( 0, 0, 0, 0, 0, 0, 0, 0 )

function Hero:New( world, x, y, type )
    local newHero = {}
    setmetatable( newHero, self )
    self.__index = self

    w = 90
    h = 120

    xShift = 20
    newHero.w = 90
    newHero.h = 120


    --inherited values
    newHero.body = love.physics.newBody( world, x, y, "dynamic" )
    newHero.body:setFixedRotation( true )
    newHero.shape = love.physics.newRectangleShape( w - 20, h )
    newHero.fixture = love.physics.newFixture( newHero.body, newHero.shape )
    newHero.fixture:setFriction( 1.0 )
    newHero.animations = {}
    newHero.currentAnimation = 0

    --Hero values
    newHero:AddAnimation( "resources/Animation/Characters/singe-course.png", 14, 24, 0, 0, 529, 694, false, false )
    newHero:AddAnimation( "resources/Animation/Characters/singe-course.png", 14, 24, 0, 0, 529, 694, true, false )
    --newHero:AddAnimation( "runsprite.png", 5, 3, 0, 150, 120, 150 )
    newHero:AddAnimation( "resources/Animation/Characters/singe-course.png", 1, 24, 0, 0, 529, 694, false, false )
    newHero:AddAnimation( "resources/Animation/Characters/singe-course.png", 1, 24, 0, 0, 529, 694, true, false )
    --newHero:AddAnimation( "runsprite.png", 1, 3, 0, 150, 120, 150 )
    newHero:SetCurrentAnimation( 1 )

    return newHero
end

function Hero:jump()
    self.body:applyLinearImpulse( 0, -300 )
end

function Hero:runRight()
    vx, vy = self.body:getLinearVelocity()
    self.body:setLinearVelocity( 300, vy )
    self:SetCurrentAnimation( 1 )
end

function Hero:runLeft()
    vx, vy = self.body:getLinearVelocity()
    self.body:setLinearVelocity( -300, vy )
    self:SetCurrentAnimation( 2 )
end

function Hero:StopRunning()
    vx, vy = self.body:getLinearVelocity()
    self.body:setLinearVelocity( 0, vy )
    if vx >= 0 then
        self:SetCurrentAnimation( 3 )
    end
    if vx < 0 then
        self:SetCurrentAnimation( 4 )
    end
end

function Hero:Update( dt )
    -- Key holding detection
    if love.keyboard.isDown( "left" ) then
        self:runLeft()
    elseif love.keyboard.isDown( "right" ) then
        self:runRight()
    end

    self:UpdateObject( dt )

    x, y, x2, y2 = self.shape:computeAABB( 0, 0, 0 )
    x, y, x2, y2 = self.body:getWorldPoints( x, y, x2, y2 )
    Camera.x = x - love.graphics.getWidth() / 2
    Camera.y = y - love.graphics.getHeight() / 2
end

function Hero:Draw()
    --love.graphics.polygon( "fill", self.body:getWorldPoints( self.shape:getPoints() ) )
    self:DrawObject()
end

function Hero:KeyPressed( key, scancode, isrepeat )
end

function Hero:KeyReleased( key, scancode )
    if key == "left" then
        self:StopRunning()
    end
    if key == "right" then
        self:StopRunning()
    end
end

return Hero