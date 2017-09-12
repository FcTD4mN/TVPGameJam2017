
local AttackGenerator   = require "src/Game/AttackGenerator"
local Camera            = require "src/Camera/Camera"
local Object            = require "src/Objects/Object"
local ObjectPool        = require "src/Objects/Pools/ObjectPool"
      ObjectRegistry    = require "src/Base/ObjectRegistry"
local RabbitSpells      = require "src/Interface/RabbitSpells"


local Lapin = {}
setmetatable( Lapin, Object )
Object.__index = Object

ObjectRegistry.RegisterXMLCreation( "lapin", Lapin )


-- ==========================================Constructor/Destructor


function Lapin:New( iWorld, iX, iY )
    local newLapin = {}
    setmetatable( newLapin, Lapin )
    Lapin.__index = Lapin

    newLapin:BuildLapin( iWorld, iX, iY )

    return newLapin
end


function Lapin:NewFromXML( iNode, iWorld )
    local newLapin = {}
    setmetatable( newLapin, Lapin )
    Lapin.__index = Lapin

    newLapin:LoadLapinXML( iNode, iWorld )

    return newLapin
end


function  Lapin:BuildLapin( iWorld, iX, iY )

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

    --Lapin values
    self.mCanJump    = false
    self.mDirection  = 0
    self.mMoving     = false
    self.mAttacking  = false

    self.mSounds         = {}
    self.mSounds.step    = love.audio.newSource( "resources/Audio/FXSound/pasherbe.mp3", "stream" )
    self.mSounds.jump    = love.audio.newSource( "resources/Audio/FXSound/saut.mp3", "stream" )
    self.mSounds.step:setLooping( true )
    self.mSounds.jump:setVolume(0.4)

    -- Animations
    local animCourse        = love.graphics.newImage( "resources/Animation/Characters/lapin-course.png" )
    local animSaut          = love.graphics.newImage( "resources/Animation/Characters/lapin-saut.png" )
    local animInactif       = love.graphics.newImage( "resources/Animation/Characters/lapin-inactif-tout.png" )
    local animInvocation    = love.graphics.newImage( "resources/Animation/Characters/lapin-invocation.png" )
    self:AddAnimation( animCourse, 14, 24, false, false )   --1
    self:AddAnimation( animCourse, 14, 24, true, false )    --2
    self:AddAnimation( animSaut, 1, 24, false, false )      --3
    self:AddAnimation( animSaut, 1, 24, true, false )       --4
    self:AddAnimation( animInactif, 17, 24, true, false )   --6
    self:AddAnimation( animInactif, 17, 24, false, false )  --5
    self:AddAnimation( animInvocation, 5, 24, false, false )--7
    self:AddAnimation( animInvocation, 5, 24, true, false ) --8

    self:PlayAnimation( 5, 0 )

    -- Images
    RabbitSpells.Initialize() --TODO: move that thing elsewhere

end


-- ==========================================Type


function Lapin:Type()
    return "Lapin"
end


-- ==========================================Update/Draw


function Lapin:Update( iDT )
    -- Key holding detection
    if not self.mAttacking then
        if love.keyboard.isDown( "q" ) then
            self:RunLeft()
        elseif love.keyboard.isDown( "d" ) then
            self:RunRight()
        end
    end

    local contacts = self.mBody:getContactList()
    if #contacts > 0 then
        self.mCanJump = false
        for k, v in pairs(contacts) do
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

    self:UpdateObject( iDT )
end


function Lapin:Draw( iCamera )
    RabbitSpells.Draw( iCamera )
    self:DrawObject( iCamera )
end


-- ==========================================Hero actions


function Lapin:Jump()
    vx, vy = self.mBody:getLinearVelocity()
    self.mBody:setLinearVelocity( vx, -400 )
    self.mCanJump = false
    love.audio.play( self.mSounds.jump )
end


function Lapin:RunRight()
    vx, vy = self.mBody:getLinearVelocity()
    self.mBody:setLinearVelocity( 300, vy )
    self.mDirection = 0
    self.mMoving = true
    if self.mCanJump then
        love.audio.play( self.mSounds.step )
    end
end


function Lapin:RunLeft()
    vx, vy = self.mBody:getLinearVelocity()
    self.mBody:setLinearVelocity( -300, vy )
    self.mDirection = 1
    self.mMoving = true
    if self.mCanJump then
        love.audio.play( self.mSounds.step )
    end
end


function Lapin:StopRunning()
    vx, vy = self.mBody:getLinearVelocity()
    self.mBody:setLinearVelocity( 0, vy )
    self.mMoving = false

    love.audio.stop( self.mSounds.step )
end


function  Lapin:Attack( iVel )
    shift = self.mW
    xShift = 5

    if iVel < 0 then
        shift  = - shift
        xShift = - xShift
    end

    x = self:GetX() + shift
    y = self:GetY()
    AttackGenerator:GenerateAttack( x + xShift, y, "Waterball", iVel, "horizontal" )
end


function Lapin:KeyPressed( iKey, iScancode, iIsRepeat )
    if iKey == "space" then
        self.mAttacking = true
        self:StopRunning()
    elseif iKey == "z" and not isrepeat and self.mCanJump then
        self:Jump()
    end
end


function Lapin:KeyReleased( iKey, iScancode )
    if iKey == "space" then
        self.mAttacking = false
    end
    if iKey == "q" then
        self:StopRunning()
    end
    if iKey == "d" then
        self:StopRunning()
    end
end


-- ==========================================XML IO


function  Lapin:SaveXML()
    return  self:SaveLapinXML()
end


function  Lapin:SaveLapinXML()

    xmlData = "<lapin>\n"

    xmlData = xmlData .. self:SaveObjectXML()

    xmlData = xmlData ..  "</lapin>\n"

    return  xmlData

end


function  Lapin:LoadLapinXML( iNode, iWorld )

    assert( iNode.name == "lapin" )
    self:LoadObjectXML( iNode.el[ 1 ], iWorld )

    -- Those are transient values, so no point saving/loading them
    self.mCanJump    = false
    self.mDirection  = 0
    self.mMoving     = false
    self.mAttacking  = false

    self.mSounds         = {}
    self.mSounds.step    = love.audio.newSource( "resources/Audio/FXSound/pasherbe.mp3", "stream" )
    self.mSounds.jump    = love.audio.newSource( "resources/Audio/FXSound/saut.mp3", "stream" )
    self.mSounds.step:setLooping( true )
    self.mSounds.jump:setVolume(0.4)

    -- Animations
    local animCourse        = love.graphics.newImage( "resources/Animation/Characters/lapin-course.png" )
    local animSaut          = love.graphics.newImage( "resources/Animation/Characters/lapin-saut.png" )
    local animInactif       = love.graphics.newImage( "resources/Animation/Characters/lapin-inactif-tout.png" )
    local animInvocation    = love.graphics.newImage( "resources/Animation/Characters/lapin-invocation.png" )
    self:AddAnimation( animCourse, 14, 24, false, false )   --1
    self:AddAnimation( animCourse, 14, 24, true, false )    --2
    self:AddAnimation( animSaut, 1, 24, false, false )      --3
    self:AddAnimation( animSaut, 1, 24, true, false )       --4
    self:AddAnimation( animInactif, 17, 24, true, false )   --6
    self:AddAnimation( animInactif, 17, 24, false, false )  --5
    self:AddAnimation( animInvocation, 5, 24, false, false )--7
    self:AddAnimation( animInvocation, 5, 24, true, false ) --8

    self:PlayAnimation( 5, 0 )

    -- Images
    RabbitSpells.Initialize() --TODO: move that thing elsewhere

end


return Lapin