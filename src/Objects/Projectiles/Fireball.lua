local Animation = require "src/Objects/Animation"
local Object = require "src/Objects/Object"

local Fireball = Object:New( 0, 0, 0, 0, 0, 0, 0, 0 )

function Fireball:New( world, x, y, iVelocity )
    local newFireball = {}
    setmetatable( newFireball, self )
    self.__index = self

    newFireball.x = x
    newFireball.y = y

    newFireball.w = 90
    newFireball.h = 90

    newFireball.flipNeeded = iVelocity < 0

    --inherited values
    newFireball.body = love.physics.newBody( world, x + 45, y + 45, "dynamic" )
    newFireball.body:setFixedRotation( true )
    newFireball.body:setLinearVelocity( iVelocity, 0 )
    newFireball.body:setGravityScale( 0.0 )
    newFireball.shape = love.physics.newRectangleShape( newFireball.w, newFireball.h )
    newFireball.fixture = love.physics.newFixture( newFireball.body, newFireball.shape )
    newFireball.fixture:setFriction( 1.0 )
    newFireball.animations = {}
    newFireball.currentAnimation = 0

    return newFireball
end

function Fireball:AddAnimation( iImage )
    table.insert( self.animations, Animation:New( iImage, 5, 24, self.x, self.y, 90, 90, 0, 0, 185, 120, self.flipNeeded, false ) )
end

function Fireball:Update( dt )
    self:UpdateObject( dt )
end

function Fireball:Draw()
    -- love.graphics.polygon( "fill", self.body:getWorldPoints( self.shape:getPoints() ) )

    self:DrawObject()
end

return Fireball