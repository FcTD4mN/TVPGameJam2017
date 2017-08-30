
local Camera            = require "src/Camera/Camera"
local Object            = require "src/Objects/Object"
local AttackGenerator   = require "src/Game/AttackGenerator"

local Singe = Object:New( 0, 0, 0, 0, 0, 0, 0, 0 )


-- ==========================================Constructor/Destructor


function Singe:New( iWorld, iX, iY )
    local newSinge = {}
    setmetatable( newSinge, self )
    self.__index = self

    newSinge.w = 90
    newSinge.h = 120

    --inherited values
    newSinge.body     = love.physics.newBody( iWorld, iX + newSinge.w/2, iY + newSinge.h/2, "dynamic" )
    newSinge.body:setFixedRotation( true )

    newSinge.shape    = love.physics.newRectangleShape( newSinge.w - 30, newSinge.h )
    newSinge.fixture  = love.physics.newFixture( newSinge.body, newSinge.shape )
    newSinge.fixture:setFriction( 0.33 )
    newSinge.fixture:setUserData( newSinge )

    newSinge.animations         = {}
    newSinge.currentAnimation   = 0

    --Singe values
    newSinge.canJump    = false
    newSinge.direction  = 0
    newSinge.moving     = false
    newSinge.attacking  = false

    newSinge.attack         = nil
    newSinge.sounds         = {}
    newSinge.sounds.step    = love.audio.newSource( "resources/Audio/FXSound/pasherbe.mp3", "stream" )
    newSinge.sounds.jump    = love.audio.newSource( "resources/Audio/FXSound/saut.mp3", "stream" )
    newSinge.sounds.step:setLooping( true )
    newSinge.sounds.jump:setVolume(0.4)

    --Singe values
    local animCourse        = love.graphics.newImage( "resources/Animation/Characters/singe-course.png" )
    local animSaut          = love.graphics.newImage( "resources/Animation/Characters/singe-saut.png" )
    local animInactif       = love.graphics.newImage( "resources/Animation/Characters/singe-inactif-tout.png" )
    local animInvocation    = love.graphics.newImage( "resources/Animation/Characters/singe-invocation.png" )
    newSinge:AddAnimation( animCourse, 14, 24, false, false )   --1
    newSinge:AddAnimation( animCourse, 14, 24, true, false )    --2
    newSinge:AddAnimation( animSaut, 1, 24, false, false )      --3
    newSinge:AddAnimation( animSaut, 1, 24, true, false )       --4
    newSinge:AddAnimation( animInactif, 18, 24, false, false )  --5
    newSinge:AddAnimation( animInactif, 18, 24, true, false )   --6
    newSinge:AddAnimation( animInvocation, 7, 24, false, false )--7
    newSinge:AddAnimation( animInvocation, 7, 24, true, false ) --8

    newSinge:PlayAnimation( 5, 0 )

    return newSinge
end


-- ==========================================Type


function Singe:Type()
    return "Singe"
end


-- ==========================================Update/Draw


function Singe:Update( dt )
    -- Key holding detection
    if not self.attacking then
        if love.keyboard.isDown( "left" ) then
            self:RunLeft()
        elseif love.keyboard.isDown( "right" ) then
            self:RunRight()
        end
    end

    local contacts = self.body:getContactList()
    if #contacts > 0 then
        self.canJump = false
        for k, v in pairs( contacts ) do
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


function Singe:Draw()
    self:DrawObject()
    -- self:DEBUGDrawHitBox()

    if( self.attack ) then
        self.attack:Draw()
    end
end


-- ==========================================Hero actions


function Singe:Jump()
    vx, vy = self.body:getLinearVelocity()
    self.body:setLinearVelocity( vx, -400 )
    self.canJump = false
    love.audio.play( self.sounds.jump )
end


function Singe:RunRight()
    vx, vy = self.body:getLinearVelocity()
    self.body:setLinearVelocity( 300, vy )
    self.direction = 0
    self.moving = true
    if self.canJump then
        love.audio.play( self.sounds.step )
    end
end


function Singe:RunLeft()
    vx, vy = self.body:getLinearVelocity()
    self.body:setLinearVelocity( -300, vy )
    self.direction = 1
    self.moving = true
    if self.canJump then
        love.audio.play( self.sounds.step )
    end
end


function Singe:StopRunning()
    vx, vy = self.body:getLinearVelocity()
    self.body:setLinearVelocity( 0, vy )
    self.moving = false

    love.audio.stop( self.sounds.step )
end


function  Singe:Attack( iVel )
    shift = self.w
    xShift = 5

    if iVel < 0 then
        shift  = - shift
        xShift = - xShift
    end

    x = self:GetX() + shift
    y = self:GetY()
    if self.attack then
        self.attack:Destroy()
    end
    self.attack = AttackGenerator:GenerateAttack( x + xShift, y, "fireball", iVel )
end


function Singe:KeyPressed( key, scancode, isrepeat )
    if key == "rctrl" then
        self.attacking = true
        self:StopRunning()
    elseif key == "up" and not isrepeat and self.canJump then
        self:Jump()
    end
end


function Singe:KeyReleased( key, scancode )
    if key == "rctrl" then
        self.attacking = false
    end
    if key == "left" then
        self:StopRunning()
    end
    if key == "right" then
        self:StopRunning()
    end
end


return Singe