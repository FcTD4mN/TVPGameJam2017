
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

    stickyShape    = love.physics.newRectangleShape( newLapin.w - 30, newLapin.h )
    fixture  = love.physics.newFixture( newLapin.body, stickyShape )
    fixture:setFriction( 1.0 )
    fixture:setUserData( newLapin )

    slipperyShape    = love.physics.newRectangleShape( newLapin.w - 25, newLapin.h - 5 )
    fixture  = love.physics.newFixture( newLapin.body, slipperyShape )
    fixture:setFriction( 0.0 )
    fixture:setUserData( newLapin )

    newLapin.animations         = {}
    newLapin.currentAnimation   = 0

    --Lapin values
    newLapin.canJump    = false
    newLapin.direction  = 0
    newLapin.moving     = false
    newLapin.attacking  = false

    newLapin.sounds         = {}
    newLapin.sounds.step    = love.audio.newSource( "resources/Audio/FXSound/pasherbe.mp3", "stream" )
    newLapin.sounds.jump    = love.audio.newSource( "resources/Audio/FXSound/saut.mp3", "stream" )
    newLapin.sounds.step:setLooping( true )
    newLapin.sounds.jump:setVolume(0.4)

    --Lapin values
    local animCourse        = love.graphics.newImage( "resources/Animation/Characters/lapin-course.png" )
    local animSaut          = love.graphics.newImage( "resources/Animation/Characters/lapin-saut.png" )
    local animInactif       = love.graphics.newImage( "resources/Animation/Characters/lapin-inactif-tout.png" )
    local animInvocation    = love.graphics.newImage( "resources/Animation/Characters/lapin-invocation.png" )
    newLapin:AddAnimation( animCourse, 14, 24, false, false )   --1
    newLapin:AddAnimation( animCourse, 14, 24, true, false )    --2
    newLapin:AddAnimation( animSaut, 1, 24, false, false )      --3
    newLapin:AddAnimation( animSaut, 1, 24, true, false )       --4
    newLapin:AddAnimation( animInactif, 17, 24, true, false )   --6
    newLapin:AddAnimation( animInactif, 17, 24, false, false )  --5
    newLapin:AddAnimation( animInvocation, 5, 24, false, false )--7
    newLapin:AddAnimation( animInvocation, 5, 24, true, false ) --8

    newLapin:PlayAnimation( 5, 0 )

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
            self:PlayAnimation( 7, 0 )
            self:Attack( 500 )
        end
        if self.direction == 1 then
            self:PlayAnimation( 8, 0 )
            self:Attack( -500 )
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
end


function Lapin:Draw()
    self:DrawObject()
    -- self:DEBUGDrawHitBox()
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
    shift = self.w
    xShift = 5

    if iVel < 0 then
        shift  = - shift
        xShift = - xShift
    end

    x = self:GetX() + shift
    y = self:GetY()
    AttackGenerator:GenerateAttack( x + xShift, y, "waterball", iVel, "horizontal" )
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