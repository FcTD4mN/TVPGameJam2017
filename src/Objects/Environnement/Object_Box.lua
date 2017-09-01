
local Object = require "src/Objects/Object"
local Object_Box = Object:New( 0, 0, 0, 0, 0, 0, 0, 0 )

function Object_Box:New( iWorld, iX, iY, iType )
    local newObject_Box = {}
    setmetatable( newObject_Box, self )
    self.__index = self


    newObject_Box.x = iX
    newObject_Box.y = iY
    newObject_Box.w = 109
    newObject_Box.h = 95

    --inherited values
    newObject_Box.body  = love.physics.newBody( iWorld, newObject_Box.x, newObject_Box.y, "dynamic" )
    newObject_Box.body:setFixedRotation( false )

    shape               = love.physics.newRectangleShape( newObject_Box.w, newObject_Box.h )
    fixture             = love.physics.newFixture( newObject_Box.body, shape )
    fixture:setFriction( 0.7 )
    fixture:setUserData( newObject_Box )


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