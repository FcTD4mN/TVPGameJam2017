
local Camera = require "src/Camera/Camera"
local Object = require "src/Objects/Object"
local AttackGenerator    = require "src/Game/AttackGenerator"

local Hero = Object:New( 0, 0, 0, 0, 0, 0, 0, 0 )

function Hero:New( iWorld, iX, iY, iPhysicType )
    local newHero = {}
    setmetatable( newHero, self )
    self.__index = self

    newHero.w = 90
    newHero.h = 120

    --inherited values
    newHero.body = love.physics.newBody( world, x, y, "dynamic" )
    newHero.body:setFixedRotation( true )
    newHero.shape = love.physics.newCircleShape( 50 )
    newHero.shape2 = love.physics.newRectangleShape( w - 30, h-10 )
    newHero.fixture = love.physics.newFixture( newHero.body, newHero.shape )
    newHero.fixture = love.physics.newFixture( newHero.body, newHero.shape2 )
    newHero.fixture:setFriction( 0.33 )
    newHero.fixture:setUserData( nil )

    newHero.animations = {}
    newHero.currentAnimation = 0

    --Hero values
    newHero.canJump = false
    newHero.type = type
    newHero.direction = 0
    newHero.moving = false
    newHero.attacking = false

    newHero.attack = nil
    newHero.sounds = {}
    newHero.sounds.step = love.audio.newSource( "resources/Audio/FXSound/pasherbe.mp3", "stream" )
    newHero.sounds.step:setLooping( true )
    newHero.sounds.jump = love.audio.newSource( "resources/Audio/FXSound/saut.mp3", "stream" )
    newHero.sounds.jump:setVolume(0.4)

    --Hero values
    if type == 0 then
        newHero.w = 90
        local animCourse = love.graphics.newImage( "resources/Animation/Characters/singe-course.png" )
        local animSaut = love.graphics.newImage( "resources/Animation/Characters/singe-saut.png" )
        local animInactif = love.graphics.newImage( "resources/Animation/Characters/singe-inactif-tout.png" )
        local animInvocation = love.graphics.newImage( "resources/Animation/Characters/singe-invocation.png" )
        newHero:AddAnimation( animCourse, 14, 24, false, false )--1
        newHero:AddAnimation( animCourse, 14, 24, true, false )--2
        newHero:AddAnimation( animSaut, 1, 24, false, false )--3
        newHero:AddAnimation( animSaut, 1, 24, true, false )--4
        newHero:AddAnimation( animInactif, 18, 24, false, false )--5
        newHero:AddAnimation( animInactif, 18, 24, true, false )--6
        newHero:AddAnimation( animInvocation, 7, 24, false, false )--7
        newHero:AddAnimation( animInvocation, 7, 24, true, false )--8
    elseif type == 1 then
        newHero.w = 90
        local animCourse = love.graphics.newImage( "resources/Animation/Characters/lapin-course.png" )
        local animSaut = love.graphics.newImage( "resources/Animation/Characters/lapin-saut.png" )
        local animInactif = love.graphics.newImage( "resources/Animation/Characters/lapin-inactif-tout.png" )
        local animInvocation = love.graphics.newImage( "resources/Animation/Characters/lapin-invocation.png" )
        newHero:AddAnimation( animCourse, 14, 24, false, false )
        newHero:AddAnimation( animCourse, 14, 24, true, false )
        newHero:AddAnimation( animSaut, 1, 24, false, false )
        newHero:AddAnimation( animSaut, 1, 24, true, false )
        newHero:AddAnimation( animInactif, 17, 24, true, false )--5
        newHero:AddAnimation( animInactif, 17, 24, false, false )--6
        newHero:AddAnimation( animInvocation, 5, 24, false, false )--7
        newHero:AddAnimation( animInvocation, 5, 24, true, false )--8
    end
    newHero:PlayAnimation( 5, 0 )

    return newHero
end

function Hero:jump()
    vx, vy = self.body:getLinearVelocity()
    self.body:setLinearVelocity( vx, -400 )
    self.canJump = false
    love.audio.play( self.sounds.jump )
end

function Hero:runRight()
    vx, vy = self.body:getLinearVelocity()
    self.body:setLinearVelocity( 300, vy )
    self.direction = 0
    self.moving = true
    if self.canJump then
        love.audio.play( self.sounds.step )
    end
end

function Hero:runLeft()
    vx, vy = self.body:getLinearVelocity()
    self.body:setLinearVelocity( -300, vy )
    self.direction = 1
    self.moving = true
    if self.canJump then
        love.audio.play( self.sounds.step )
    end
end

function Hero:StopRunning()
    vx, vy = self.body:getLinearVelocity()
    self.body:setLinearVelocity( 0, vy )
    self.moving = false

    love.audio.stop( self.sounds.step )
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
            self:PlayAnimation( 7, 0 )
            self:Attack( 100 )
        end
        if self.direction == 1 then
            self:PlayAnimation( 8, 0 )
            self:Attack( -100 )
        end
    elseif self.canJump then
        if self.moving then
            if self.direction == 0 then
                self:PlayAnimation( 1, 0 )
            end
            if self.direction == 1 then
                self:PlayAnimation( 2, 0 )
            end
        else
            if self.direction == 0 then
                self:PlayAnimation( 5, 0 )
            end
            if self.direction == 1 then
                self:PlayAnimation( 6, 0 )
            end
        end
    else
        if self.direction == 0 then
            self:PlayAnimation( 3, 0 )
        end
        if self.direction == 1 then
            self:PlayAnimation( 4, 0 )
        end
    end

    self:UpdateObject( dt )

    if( self.attack ) then
        self.attack:Update( dt )
    end
end

function  Hero:Attack( iVel )
    shift = self.w / 2
    xShift = 10

    if iVel < 0 then
        shift = -shift - 90
        xShift =- xShift
    end

    x = self.body:getX() + shift
    y = self.body:getY() - self.h / 2
    if( self.type == 0 ) then
        if self.attack then
            self.attack:Destroy()
        end
        self.attack = AttackGenerator:GenerateAttack( x + xShift, y, "fireball", iVel )
    elseif( self.type == 1 ) then
        if self.attack then
            self.attack:Destroy()
        end
        self.attack = AttackGenerator:GenerateAttack( x + xShift, y, "waterball", iVel )
    end
end

function Hero:Draw()
    --love.graphics.polygon( "fill", self.body:getWorldPoints( self.shape:getPoints() ) )
    self:DrawObject()

    if( self.attack ) then
        self.attack:Draw()
    end
end

function Hero:KeyPressed( key, scancode, isrepeat )
    if self.type == 0 then
        if key == "rctrl" then
            self.attacking = true
            self:StopRunning()
        elseif key == "up" and not isrepeat and self.canJump then
            self:jump()
        end
    elseif self.type == 1 then
        if key == "space" then
            self.attacking = true
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