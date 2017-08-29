
local Camera = require "src/Camera/Camera"
local Object = require "src/Objects/Object"
local AttackGenerator    = require "src/Game/AttackGenerator"

local Lapin = Object:New( 0, 0, 0, 0, 0, 0, 0, 0 )


-- ==========================================Constructor/Destructor


function Lapin:New( iWorld, iX, iY )
    local newLapin = {}
    setmetatable( newLapin, self )
    self.__index = self

    newLapin.w = 90
    newLapin.h = 120

    --inherited values
    newLapin.body     = love.physics.newBody( iWorld, iX + newLapin.w/2, iY + newLapin.h/2, "dynamic" )
    newLapin.body:setFixedRotation( true )

    newLapin.shape    = love.physics.newRectangleShape( newLapin.w - 30, newLapin.h )
    newLapin.fixture  = love.physics.newFixture( newLapin.body, newLapin.shape )
    newLapin.fixture:setFriction( 0.33 )
    newLapin.fixture:setUserData( newLapin )

    newLapin.animations         = {}
    newLapin.currentAnimation   = 0

    --Lapin values
    newLapin.canJump    = false
    newLapin.direction  = 0
    newLapin.moving     = false
    newLapin.attacking  = false

    newLapin.attack         = nil
    newLapin.sounds         = {}
    newLapin.sounds.step    = love.audio.newSource( "resources/Audio/FXSound/pasherbe.mp3", "stream" )
    newLapin.sounds.jump    = love.audio.newSource( "resources/Audio/FXSound/saut.mp3", "stream" )
    newLapin.sounds.step:setLooping( true )
    newLapin.sounds.jump:setVolume(0.4)

    --Lapin values
    local animCourse        = love.graphics.newImage( "resources/Animation/Characters/lapin-course.png" )
    local animInactif       = love.graphics.newImage( "resources/Animation/Characters/lapin-inactif-tout.png" )
    local animInvocation    = love.graphics.newImage( "resources/Animation/Characters/lapin-invocation.png" )
    newLapin:AddAnimation( animCourse, 14, 24, 0, 0, 548, 826, false, false )--1
    newLapin:AddAnimation( animCourse, 14, 24, 0, 0, 548, 826, true, false )--2
    newLapin:AddAnimation( animCourse, 1, 24, 0, 0, 548, 826, false, false )--3
    newLapin:AddAnimation( animCourse, 1, 24, 0, 0, 548, 826, true, false )--4
    newLapin:AddAnimation( animInactif, 17, 24, 0, 0, 526, 843, false, false )--5
    newLapin:AddAnimation( animInactif, 17, 24, 0, 0, 526, 843, true, false )--6
    newLapin:AddAnimation( animInvocation, 5, 24, 0, 0, 548, 722, false, false )--7
    newLapin:AddAnimation( animInvocation, 5, 24, 0, 0, 548, 722, true, false )--8

    newLapin:SetCurrentAnimation( 5 )

    return newLapin
end


-- ==========================================Type


function Lapin:Type()
    return "Lapin"
end


-- ==========================================Update/Draw


function Lapin:Update( dt )
    -- Key holding detection
    if not self.attacking then
        if love.keyboard.isDown( "q" ) then
            self:RunLeft()
        elseif love.keyboard.isDown( "d" ) then
            self:RunRight()
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

    if( self.attack ) then
        self.attack:Update( dt )
    end
end


function Lapin:Draw()
    self:DrawObject()
    self:DEBUGDrawHitBox()

    if( self.attack ) then
        self.attack:Draw()
    end
end


-- ==========================================Hero actions


function Lapin:Jump()
    vx, vy = self.body:getLinearVelocity()
    self.body:setLinearVelocity( vx, -400 )
    self.canJump = false
    love.audio.play( self.sounds.jump )
end


function Lapin:RunRight()
    vx, vy = self.body:getLinearVelocity()
    self.body:setLinearVelocity( 300, vy )
    self.direction = 0
    self.moving = true
    if self.canJump then
        love.audio.play( self.sounds.step )
    end
end


function Lapin:RunLeft()
    vx, vy = self.body:getLinearVelocity()
    self.body:setLinearVelocity( -300, vy )
    self.direction = 1
    self.moving = true
    if self.canJump then
        love.audio.play( self.sounds.step )
    end
end


function Lapin:StopRunning()
    vx, vy = self.body:getLinearVelocity()
    self.body:setLinearVelocity( 0, vy )
    self.moving = false

    love.audio.stop( self.sounds.step )
end


function  Lapin:Attack( iVel )
    shift = self.w / 2
    xShift = 5

    if iVel < 0 then
        shift = -shift - 90
        xShift =- xShift
    end

    x = self:GetX()
    y = self:GetY()
    if self.attack then
        self.attack:Destroy()
    end
    self.attack = AttackGenerator:GenerateAttack( x + xShift, y, "waterball", iVel )
end


function Lapin:KeyPressed( iKey, iScancode, iIsRepeat )
    if iKey == "space" then
        self.attacking = true
        self:StopRunning()
    elseif iKey == "z" and not isrepeat and self.canJump then
        self:Jump()
    end
end


function Lapin:KeyReleased( iKey, iScancode )
    if iKey == "space" then
        self.attacking = false
    end
    if iKey == "q" then
        self:StopRunning()
    end
    if iKey == "d" then
        self:StopRunning()
    end
end


return Lapin