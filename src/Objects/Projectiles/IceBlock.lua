local Object = require "src/Objects/Object"

local IceBlock = Object:New( 0, 0, 0, 0, 0, 0, 0, 0 )

function IceBlock:New( world, x, y )
    local newIceBlock = {}
    setmetatable( newIceBlock, self )
    self.__index = self

    w = 109
    h = 95

    newIceBlock.w = w
    newIceBlock.h = h

    --inherited values
    newIceBlock.body = love.physics.newBody( world, x, y, "dynamic" )
    newIceBlock.body:setFixedRotation( false )
    newIceBlock.shape = love.physics.newRectangleShape( w, h )
    newIceBlock.fixture = love.physics.newFixture( newIceBlock.body, newIceBlock.shape )
    newIceBlock.fixture:setFriction( 0.7 )
    newIceBlock.animations = {}
    newIceBlock.currentAnimation = 0

    --IceBlock values
    newIceBlock:AddAnimation( "resources/Images/Objects/IceBlock.png", 1, 24, 0, 0, w, h, false, false )
    newIceBlock:SetCurrentAnimation( 1 )

    return newIceBlock
end

function IceBlock:Update( dt )
    self:UpdateObject( dt )
end

function IceBlock:Draw()
    --love.graphics.polygon( "fill", self.body:getWorldPoints( self.shape:getPoints() ) )
    self:DrawObject()
end

return IceBlock