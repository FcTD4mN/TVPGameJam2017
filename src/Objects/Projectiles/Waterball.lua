local Animation = require "src/Image/Animation"
local Object = require "src/Objects/Object"
local ObjectPool = require "src/Objects/Pools/ObjectPool"

local Waterball = Object:New( 0, 0, 0, 0, 0, 0, 0, 0 )


-- ==========================================Constructor/Destructor


function Waterball:New( iWorld, iX, iY, iVelocity, iDirection )
    local newWaterball = {}
    setmetatable( newWaterball, self )
    self.__index = self

    newWaterball.x = x
    newWaterball.y = y
    newWaterball.w = 90
    newWaterball.h = 90


    --inherited values
    newWaterball.body        = love.physics.newBody( iWorld, iX + newWaterball.w/2, iY + newWaterball.h/2, "dynamic" )
    newWaterball.body:setFixedRotation( false )
    newWaterball.body:setGravityScale( 1.0 )
    if( iDirection == "horizontal" ) then
        newWaterball.body:setLinearVelocity( iVelocity, 0 )
    elseif( iDirection == "vertical" ) then
        newWaterball.body:setLinearVelocity( 0, iVelocity )
        newWaterball.body:setAngle( 90 )
    end

    shape       = love.physics.newRectangleShape( newWaterball.w, newWaterball.h )
    fixture     = love.physics.newFixture( newWaterball.body, shape )
    fixture:setFriction( 1.0 )
    fixture:setUserData( newWaterball )

    newWaterball.animations = {}
    newWaterball.currentAnimation = 0
    newWaterball.flipNeeded = iVelocity < 0

    if currentWaterball then
        currentWaterball:Destroy()
    end
    currentWaterball = newWaterball

    ObjectPool.AddObject( newWaterball )

    return newWaterball
end


-- ==========================================Type


function Waterball:Type()
    return "Waterball"
end


-- ==========================================Update/Draw


function Waterball:Update( dt )
    self:UpdateObject( dt )
end


function Waterball:Draw()
    self:DrawObject()
end


-- ==========================================Waterball specific overrides


function Waterball:AddAnimation( iImage )
    table.insert( self.animations, Animation:New( iImage, self.x, self.y, self.w, self.h, 0, 16, 24, self.flipNeeded, false ) )
end


-- ==========================================Collision stuff

function Waterball:Collide( iObject )
    self:Destroy()
    currentWaterball = nil
end


return Waterball