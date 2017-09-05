
local AttackGenerator   = require "src/Game/AttackGenerator"
local Camera            = require "src/Camera/Camera"
local Object            = require "src/Objects/Object"
local ObjectPool        = require "src/Objects/Pools/ObjectPool"
local MonkeySpells      = require "src/Interface/MonkeySpells"


local Singe = {}
setmetatable( Singe, Object )
Object.__index = Object


-- ==========================================Constructor/Destructor


function Singe:New( iWorld, iX, iY )
    local newSinge = {}
    setmetatable( newSinge, Singe )
    Singe.__index = Singe

    newSinge:BuildSinge( iWorld, iX, iY )

    return newSinge
end


function  Singe:BuildSinge( iWorld, iX, iY )

    self:BuildObject( iWorld, iX, iY, 90, 120, "dynamic", true )
    self.mBody:setGravityScale( 1.0 )

    local stickyShape    = love.physics.newRectangleShape( self.mW - 30, self.mH )
    local fixture  = love.physics.newFixture( self.mBody, stickyShape )
    fixture:setFriction( 1.0 )
    fixture:setUserData( self )

    local slipperyShape    = love.physics.newRectangleShape( self.mW - 25, self.mH - 5 )
    fixture  = love.physics.newFixture( self.mBody, slipperyShape )
    fixture:setFriction( 0.0 )
    fixture:setUserData( self )

    --Singe values
    self.mCanJump    = false
    self.mDirection  = 0
    self.mMoving     = false
    self.mAttacking  = false

    self.mSounds         = {}
    self.mSounds.step    = love.audio.newSource( "resources/Audio/FXSound/pasherbe.mp3", "stream" )
    self.mSounds.jump    = love.audio.newSource( "resources/Audio/FXSound/saut.mp3", "stream" )
    self.mSounds.step:setLooping( true )
    self.mSounds.jump:setVolume(0.4)

    --Animations
    local animCourse        = love.graphics.newImage( "resources/Animation/Characters/singe-course.png" )
    local animSaut          = love.graphics.newImage( "resources/Animation/Characters/singe-saut.png" )
    local animInactif       = love.graphics.newImage( "resources/Animation/Characters/singe-inactif-tout.png" )
    local animInvocation    = love.graphics.newImage( "resources/Animation/Characters/singe-invocation.png" )
    self:AddAnimation( animCourse, 14, 24, false, false )   --1
    self:AddAnimation( animCourse, 14, 24, true, false )    --2
    self:AddAnimation( animSaut, 1, 24, false, false )      --3
    self:AddAnimation( animSaut, 1, 24, true, false )       --4
    self:AddAnimation( animInactif, 18, 24, false, false )  --5
    self:AddAnimation( animInactif, 18, 24, true, false )   --6
    self:AddAnimation( animInvocation, 7, 24, false, false )--7
    self:AddAnimation( animInvocation, 7, 24, true, false ) --8

    self:PlayAnimation( 5, 0 )

    -- Images
    MonkeySpells.Initialize() --TODO: move that thing elsewhere

end


-- ==========================================Type


function Singe:Type()
    return "Singe"
end


-- ==========================================Update/Draw


function Singe:Update( dt )
    -- Key holding detection
    if not self.mAttacking then
        if love.keyboard.isDown( "left" ) then
            self:RunLeft()
        elseif love.keyboard.isDown( "right" ) then
            self:RunRight()
        end
    end

    local contacts = self.mBody:getContactList()
    if #contacts > 0 then
        self.mCanJump = false
        for k, v in pairs( contacts ) do
            if v:isTouching() then
                self.mCanJump = true
                break
            end
        end
    else
        self.mCanJump = false
    end

    if self.mAttacking then
        if self.mDirection == 0 then
            self:PlayAnimation( 7, 0 )
            self:Attack( 500 )
        end
        if self.mDirection == 1 then
            self:PlayAnimation( 8, 0 )
            self:Attack( -500 )
        end
    elseif self.mCanJump then
        if self.mMoving then
            if self.mDirection == 0 then
                self:PlayAnimation( 1, 0 )
            end
            if self.mDirection == 1 then
                self:PlayAnimation( 2, 0 )
            end
        else
            if self.mDirection == 0 then
                self:PlayAnimation( 5, 0 )
            end
            if self.mDirection == 1 then
                self:PlayAnimation( 6, 0 )
            end
        end
    else
        if self.mDirection == 0 then
            self:PlayAnimation( 3, 0 )
        end
        if self.mDirection == 1 then
            self:PlayAnimation( 4, 0 )
        end
    end

    self:UpdateObject( dt )
end


function Singe:Draw()
    MonkeySpells.Draw()
    self:DrawObject()
end


-- ==========================================Hero actions


function Singe:Jump()
    vx, vy = self.mBody:getLinearVelocity()
    self.mBody:setLinearVelocity( vx, -400 )
    self.mCanJump = false
    love.audio.play( self.mSounds.jump )
end


function Singe:RunRight()
    vx, vy = self.mBody:getLinearVelocity()
    self.mBody:setLinearVelocity( 300, vy )
    self.mDirection = 0
    self.mMoving = true
    if self.mCanJump then
        love.audio.play( self.mSounds.step )
    end
end


function Singe:RunLeft()
    vx, vy = self.mBody:getLinearVelocity()
    self.mBody:setLinearVelocity( -300, vy )
    self.mDirection = 1
    self.mMoving = true
    if self.mCanJump then
        love.audio.play( self.mSounds.step )
    end
end


function Singe:StopRunning()
    vx, vy = self.mBody:getLinearVelocity()
    self.mBody:setLinearVelocity( 0, vy )
    self.mMoving = false

    love.audio.stop( self.mSounds.step )
end


function  Singe:Attack( iVel )
    shift = self.mW
    xShift = 5

    if iVel < 0 then
        shift  = - shift
        xShift = - xShift
    end

    x = self:GetX() + shift
    y = self:GetY()
    AttackGenerator:GenerateAttack( x + xShift, y, "Fireball", iVel )
end


function Singe:KeyPressed( key, scancode, isrepeat )
    if key == "rctrl" then
        self.mAttacking = true
        self:StopRunning()
    elseif key == "up" and not isrepeat and self.mCanJump then
        self:Jump()
    end
end


function Singe:KeyReleased( key, scancode )
    if key == "rctrl" then
        self.mAttacking = false
    end
    if key == "left" then
        self:StopRunning()
    end
    if key == "right" then
        self:StopRunning()
    end
end


return Singe