local Animation = require "src/Image/Animation"
local Object = require "src/Objects/Object"
local ObjectPool = require "src/Objects/Pools/ObjectPool"

local Fireball = Object:New( 0, 0, 0, 0, 0, 0, 0, 0 )


-- ==========================================Constructor/Destructor


function Fireball:New( iWorld, iX, iY, iVelocity )
    local newFireball = {}
    setmetatable( newFireball, self )
    self.__index = self

    newFireball.x = x
    newFireball.y = y
    newFireball.w = 90
    newFireball.h = 90


    --inherited values
    newFireball.body        = love.physics.newBody( iWorld, iX + newFireball.w/2, iY + newFireball.h/2, "dynamic" )
    newFireball.body:setFixedRotation( true )
    newFireball.body:setLinearVelocity( iVelocity, 0 )
    newFireball.body:setGravityScale( 0.0 )

    shape       = love.physics.newRectangleShape( newFireball.w, newFireball.h )
    fixture     = love.physics.newFixture( newFireball.body, shape )
    fixture:setFriction( 1.0 )
    fixture:setUserData( newFireball )

    newFireball.animations = {}
    newFireball.currentAnimation = 0
    newFireball.flipNeeded = iVelocity < 0

    if currentFireball then
        currentFireball:Destroy()
    end
    currentFireball = newFireball

    ObjectPool.AddObject( newFireball )

    return newFireball
end


-- ==========================================Type

function Fireball:Type()
    return "Fireball"
end


-- ==========================================Update/Draw

function Fireball:Update( dt )
    self:UpdateObject( dt )
end

function Fireball:Draw()
    self:DrawObject()
end


-- ==========================================Fireball specific overrides


function Fireball:AddAnimation( iImage )
    table.insert( self.animations, Animation:New( iImage, self.x, self.y, self.w, self.h, 0, 14, 24, self.flipNeeded, false ) )
end


-- ==========================================Collision stuff

function Fireball:Collide( iObject )
    self:Destroy()
    currentFireball = nil
end

return Fireball