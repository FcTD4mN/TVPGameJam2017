
local Camera = require "src/Camera/Camera"
local Object = require "src/Objects/Object"
local Fireball  = require "src/Objects/Projectiles/Fireball"

local AttackGenerator    = require "src/Game/AttackGenerator"

local Hero = Object:New( 0, 0, 0, 0, 0, 0, 0, 0 )

function Hero:New( world, x, y, type )
    local newHero = {}
    setmetatable( newHero, self )
    self.__index = self

    w = 90
    h = 120

    newHero.h = 120

    --inherited values
    newHero.body = love.physics.newBody( world, x, y, "dynamic" )
    newHero.body:setFixedRotation( true )
    newHero.shape = love.physics.newRectangleShape( w - 20, h )
    newHero.fixture = love.physics.newFixture( newHero.body, newHero.shape )
    newHero.fixture:setFriction( 1.0 )
    newHero.animations = {}
    newHero.currentAnimation = 0
    --newHero:AddAnimation( "runsprite.png", 1, 3, 0, 150, 120, 150 )

    --Hero values
    newHero.canJump = false
    newHero.type = type
    newHero.direction = 0
    newHero.moving = false
    newHero.attacking = false
<<<<<<< HEAD
<<<<<<< Updated upstream
=======

    newHero.fireBallTMP = 0
>>>>>>> scecsec
    --newHero:AddAnimation( "runsprite.png", 1, 3, 0, 150, 120, 150 )

    --Hero values
=======

>>>>>>> Stashed changes
    if type == 0 then
        newHero.w = 90
        local animCourse = love.graphics.newImage( "resources/Animation/Characters/singe-course.png" )
        local animInactif = love.graphics.newImage( "resources/Animation/Characters/singe-inactif-tout.png" )
        local animInvocation = love.graphics.newImage( "resources/Animation/Characters/singe-invocation.png" )
        newHero:AddAnimation( animCourse, 14, 24, 0, 0, 529, 694, false, false )--1
        newHero:AddAnimation( animCourse, 14, 24, 0, 0, 529, 694, true, false )--2
        newHero:AddAnimation( animCourse, 1, 24, 0, 0, 529, 694, false, false )--3
        newHero:AddAnimation( animCourse, 1, 24, 0, 0, 529, 694, true, false )--4
        newHero:AddAnimation( animInactif, 18, 24, 0, 0, 583, 667, false, false )--5
        newHero:AddAnimation( animInactif, 18, 24, 0, 0, 583, 667, true, false )--6
        newHero:AddAnimation( animInvocation, 7, 24, 0, 0, 540, 608, false, false )--7
        newHero:AddAnimation( animInvocation, 7, 24, 0, 0, 540, 608, true, false )--8
    elseif type == 1 then
        newHero.w = 90
        local animCourse = love.graphics.newImage( "resources/Animation/Characters/lapin-course.png" )
        local animInactif = love.graphics.newImage( "resources/Animation/Characters/lapin-inactif-tout.png" )
        local animInvocation = love.graphics.newImage( "resources/Animation/Characters/lapin-invocation.png" )
        newHero:AddAnimation( animCourse, 14, 24, 0, 0, 548, 826, false, false )
        newHero:AddAnimation( animCourse, 14, 24, 0, 0, 548, 826, true, false )
        newHero:AddAnimation( animCourse, 1, 24, 0, 0, 548, 826, false, false )
        newHero:AddAnimation( animCourse, 1, 24, 0, 0, 548, 826, true, false )
        newHero:AddAnimation( animInactif, 17, 24, 0, 0, 526, 843, true, false )--5
        newHero:AddAnimation( animInactif, 17, 24, 0, 0, 526, 843, false, false )--6
        newHero:AddAnimation( animInvocation, 5, 24, 0, 0, 548, 722, false, false )--7
        newHero:AddAnimation( animInvocation, 5, 24, 0, 0, 548, 722, true, false )--8
    end
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
    self.direction = 0
    self.moving = true
end

function Hero:runLeft()
    vx, vy = self.body:getLinearVelocity()
    self.body:setLinearVelocity( -300, vy )
    self.direction = 1
    self.moving = true
end

function Hero:StopRunning()
    vx, vy = self.body:getLinearVelocity()
    self.body:setLinearVelocity( 0, vy )
    self.moving = false
end

function Hero:Update( dt )
    -- Key holding detection
    if not self.attacking then
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
    end

    local contacts = self.body:getContactList()
    if #contacts > 0 then
        self.canJump = false
        for k, v in pairs(contacts) do
            if v:isTouching() then
                self.canJump = true
                break
            end
        end
    else
        self.canJump = false
    end

    if self.attacking then
        if self.direction == 0 then
            self:SetCurrentAnimation( 7 )
            self:Attack( 100 )
        end
        if self.direction == 1 then
            self:SetCurrentAnimation( 8 )
            self:Attack( -100 )
        end
    elseif self.canJump then
        if self.moving then
            if self.direction == 0 then
                self:SetCurrentAnimation( 1 )
            end
            if self.direction == 1 then
                self:SetCurrentAnimation( 2 )
            end
        else
            if self.direction == 0 then
                self:SetCurrentAnimation( 5 )
            end
            if self.direction == 1 then
                self:SetCurrentAnimation( 6 )
            end
        end
    else
        if self.direction == 0 then
            self:SetCurrentAnimation( 3 )
        end
        if self.direction == 1 then
            self:SetCurrentAnimation( 4 )
        end
    end

    self:UpdateObject( dt )

    if( self.fireBallTMP ~= 0 ) then
        self.fireBallTMP:Update( dt )
    end

    x, y, x2, y2 = self.shape:computeAABB( 0, 0, 0 )
    x, y, x2, y2 = self.body:getWorldPoints( x, y, x2, y2 )
    Camera.x = x - love.graphics.getWidth() / 2
    Camera.y = 0 --love.graphics.getHeight() / 2
end

function  Hero:Attack( iVel )
    shift = self.w / 2

    if iVel < 0 then
        shift = -shift - 90
    end

    x = self.body:getX() + shift
    y = self.body:getY() - self.h / 2
    self.fireBallTMP = Fireball:New( world, x, y , iVel )
end

function Hero:Draw()
    --love.graphics.polygon( "fill", self.body:getWorldPoints( self.shape:getPoints() ) )
    self:DrawObject()

    if( self.fireBallTMP ~= 0 ) then
        self.fireBallTMP:Draw()
    end
end

function Hero:KeyPressed( key, scancode, isrepeat )
    if self.type == 0 then
        if key == "rctrl" then
            self.attacking = true
            if direction == 0 then
                AttackGenerator:GenerateAttack( x, y, 0, 1000 )
            elseif direction == 1 then
                AttackGenerator:GenerateAttack( x, y, 0, -1000 )
            end
            self:StopRunning()
        elseif key == "up" and not isrepeat and self.canJump then
            self:jump()
        end
    elseif self.type == 1 then
        if key == "space" then
            self.attacking = true
            if direction == 0 then
                AttackGenerator:GenerateAttack( x, y, 1, 1000 )
            elseif direction == 1 then
                AttackGenerator:GenerateAttack( x, y, 1, -1000 )
            end
            self:StopRunning()
        elseif key == "z" and not isrepeat and self.canJump then
            self:jump()
        end
    end
end

function Hero:KeyReleased( key, scancode )
    if self.type == 0 then
        if key == "rctrl" then
            self.attacking = false
        end
        if key == "left" then
            self:StopRunning()
        end
        if key == "right" then
            self:StopRunning()
        end
    elseif self.type == 1 then
        if key == "space" then
            self.attacking = false
        end
        if key == "q" then
            self:StopRunning()
        end
        if key == "d" then
            self:StopRunning()
        end
    end
end

return Hero