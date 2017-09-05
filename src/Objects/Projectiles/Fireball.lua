local Animation = require "src/Image/Animation"
local Object = require "src/Objects/Object"
local ObjectPool = require "src/Objects/Pools/ObjectPool"

local Fireball = {}
setmetatable( Fireball, Object )
Object.__index = Object


-- ==========================================Constructor/Destructor


function Fireball:New( iWorld, iX, iY, iVelocity )
    local newFireball = {}
    setmetatable( newFireball, Fireball )
    Fireball.__index = Fireball

    newFireball:BuildFireball( iWorld, iX, iY, iVelocity )

    if currentFireball then
        currentFireball:Destroy()
    end

    currentFireball = newFireball

    return newFireball

end


function  Fireball:BuildFireball( iWorld, iX, iY, iVelocity )

    self:BuildObject( iWorld, iX, iY, 90, 90, "dynamic", true )
    self.mBody:setLinearVelocity( iVelocity, 0 )
    self.mBody:setGravityScale( 0.0 )

    local shape    = love.physics.newRectangleShape( self.mW, self.mH )
    local fixture  = love.physics.newFixture( self.mBody, shape )
    fixture:setFriction( 1.0 )
    fixture:setUserData( self )

    self.mFlipNeeded = iVelocity < 0

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
    table.insert( self.mAnimations, Animation:New( iImage, self.mX, self.mY, self.mW, self.mH, 0, 14, 24, self.mFlipNeeded, false ) )
end


-- ==========================================Collision stuff

function Fireball:Collide( iObject )
    self:Destroy()
    currentFireball = nil
end

return Fireball