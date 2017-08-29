
local Object = require "src/Objects/Object"
local Object_Box = Object:New( 0, 0, 0, 0, 0, 0, 0, 0 )

function Object_Box:New( world, x, y, type )
    local newObject_Box = {}
    setmetatable( newObject_Box, self )
    self.__index = self

    w = 109
    h = 95

    newObject_Box.w = w
    newObject_Box.h = h

    --inherited values
    newObject_Box.body = love.physics.newBody( world, x, y, "dynamic" )
    newObject_Box.body:setFixedRotation( false )
    newObject_Box.shape = love.physics.newRectangleShape( w, h )
    newObject_Box.fixture = love.physics.newFixture( newObject_Box.body, newObject_Box.shape )
    newObject_Box.fixture:setFriction( 0.7 )
    newObject_Box.fixture:setUserData( nil )
    newObject_Box.animations = {}
    newObject_Box.currentAnimation = 0

    --Object_Box values
    local image = love.graphics.newImage( "resources/Images/Objects/Object_Box.png" )
    newObject_Box:AddAnimation( image, 1, 24, false, false )
    newObject_Box:PlayAnimation( 1, 0 ) --please replace by image only

    return newObject_Box
end

function Object_Box:Update( dt )
    self:UpdateObject( dt )
end

function Object_Box:Draw()
    --love.graphics.polygon( "fill", self.body:getWorldPoints( self.shape:getPoints() ) )
    self:DrawObject()
end

return Object_Box