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
    newHero.canJump = false
    newHero.type = type
    
    --Hero values
    if type == 0 then
        newHero:AddAnimation( "resources/Animation/Characters/singe-course.png", 14, 24, 0, 0, 529, 694, false, false )--1
        newHero:AddAnimation( "resources/Animation/Characters/singe-course.png", 14, 24, 0, 0, 529, 694, true, false )--2
        newHero:AddAnimation( "resources/Animation/Characters/singe-course.png", 1, 24, 0, 0, 529, 694, false, false )--3
        newHero:AddAnimation( "resources/Animation/Characters/singe-course.png", 1, 24, 0, 0, 529, 694, true, false )--4
        newHero:AddAnimation( "resources/Animation/Characters/singe-inactif-tout.png", 18, 24, 0, 0, 583, 667, false, false )--5
        newHero:AddAnimation( "resources/Animation/Characters/singe-inactif-tout.png", 18, 24, 0, 0, 583, 667, true, false )--6
    elseif type == 1 then
        newHero:AddAnimation( "resources/Animation/Characters/lapin-course.png", 14, 24, 0, 0, 548, 826, false, false )
        newHero:AddAnimation( "resources/Animation/Characters/lapin-course.png", 14, 24, 0, 0, 548, 826, true, false )
        newHero:AddAnimation( "resources/Animation/Characters/lapin-course.png", 1, 24, 0, 0, 548, 826, false, false )
        newHero:AddAnimation( "resources/Animation/Characters/lapin-course.png", 1, 24, 0, 0, 548, 826, true, false )
        newHero:AddAnimation( "resources/Animation/Characters/lapin-inactif-tout.png", 17, 24, 0, 0, 526, 909, false, false )--5
        newHero:AddAnimation( "resources/Animation/Characters/lapin-inactif-tout.png", 17, 24, 0, 0, 526, 909, true, false )--6
    end
    --newHero:AddAnimation( "runsprite.png", 1, 3, 0, 150, 120, 150 )
    newHero:SetCurrentAnimation( 5 )

    return newHero
end

function Hero:jump()
    vx, vy = self.body:getLinearVelocity()
    self.body:setLinearVelocity( vx, -400 )
    self.canJump = false
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
        self:SetCurrentAnimation( 5 )
    end
    if vx < 0 then
        self:SetCurrentAnimation( 6 )
    end
end

function Hero:Update( dt )
    -- Key holding detection
    if self.type == 0 then
        if love.keyboard.isDown( "left" ) then
            self:runLeft()
        elseif love.keyboard.isDown( "right" ) then
            self:runRight()
        end
    elseif self.type == 1 then
        if love.keyboard.isDown( "q" ) then
            self:runLeft()
        elseif love.keyboard.isDown( "d" ) then
            self:runRight()
        end
    end

    local contacts = self.body:getContactList()
    print(#contacts)
    if #contacts > 0 then
        self.canJump = true
    else
        self.canJump = false
    end

    self:UpdateObject( dt )

    x, y, x2, y2 = self.shape:computeAABB( 0, 0, 0 )
    x, y, x2, y2 = self.body:getWorldPoints( x, y, x2, y2 )
    Camera.x = x - love.graphics.getWidth() / 2
    Camera.y = 0 --love.graphics.getHeight() / 2
end

function Hero:Draw()
    --love.graphics.polygon( "fill", self.body:getWorldPoints( self.shape:getPoints() ) )
    self:DrawObject()
end

function Hero:KeyPressed( key, scancode, isrepeat )
    if self.type == 0 then
        if key == "up" and not isrepeat and self.canJump then
            self:jump()
        end
    elseif self.type == 1 then
        if key == "z" and not isrepeat and self.canJump then
            self:jump()
        end
    end
end

function Hero:KeyReleased( key, scancode )
    if self.type == 0 then
        if key == "left" then
            self:StopRunning()
        end
        if key == "right" then
            self:StopRunning()
        end
    elseif self.type == 1 then
        if key == "q" then
            self:StopRunning()
        end
        if key == "d" then
            self:StopRunning()
        end
    end
end

return Hero