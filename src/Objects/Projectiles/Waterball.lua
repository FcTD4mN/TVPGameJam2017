local Animation = require "src/Objects/Animation"
local Object = require "src/Objects/Object"

local Waterball = Object:New( 0, 0, 0, 0, 0, 0, 0, 0 )

function Waterball:New( world, x, y, iVelocity )
    local newWaterball = {}
    setmetatable( newWaterball, self )
    self.__index = self

    newWaterball.x = x
    newWaterball.y = y

    newWaterball.w = 90
    newWaterball.h = 90

    newWaterball.flipNeeded = iVelocity < 0

    --inherited values
    newWaterball.body = love.physics.newBody( world, x + 45, y + 45, "dynamic" )
    newWaterball.body:setFixedRotation( true )
    newWaterball.body:setLinearVelocity( iVelocity, 0 )
    newWaterball.body:setGravityScale( 0.0 )
    newWaterball.shape = love.physics.newRectangleShape( newWaterball.w, newWaterball.h )
    newWaterball.fixture = love.physics.newFixture( newWaterball.body, newWaterball.shape )
    newWaterball.fixture:setFriction( 1.0 )
    newWaterball.fixture:setUserData( newWaterball )
    newWaterball.animations = {}
    newWaterball.currentAnimation = 0

    return newWaterball
end

function Waterball:AddAnimation( iImage )
    table.insert( self.animations, Animation:New( iImage, self.x, self.y, 90, 90, 0, 16, 24, self.flipNeeded, false ) )
end

function Waterball:Update( dt )
    self:UpdateObject( dt )
end

function Waterball:Draw()
    -- love.graphics.polygon( "fill", self.body:getWorldPoints( self.shape:getPoints() ) )

    self:DrawObject()
end

function Waterball:Type()
    return "Waterball"
end

return Waterball