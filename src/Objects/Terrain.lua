Ce truc ne marchera jamais LOL


local Camera = require "src/Camera/Camera"
local Rectangle = require "src/Math/Rectangle"

local Terrain = {}

function Terrain:New( world )
    local newTerrain = {}
    setmetatable( newTerrain, self )
    self.__index = self

    newTerrain.body = love.physics.newBody( world, 0, 0, "Static" )
    newObject.body:setFixedRotation( true )
    newObject.shape = love.physics.newRectangleShape( w, h )
    newObject.fixture = 0--love.physics.newFixture( newObject.body, newObject.shape )
    newObject.fixture:setFriction( 1 )
    newObject.fixture:setUserData( nil )
    newObject.EdgeShapesCeiling1 = {} -- top
    newObject.EdgeShapesFloor1 = {} -- middle part floor
    newObject.EdgeShapesCeiling2 = {} -- middle part ceiling
    newObject.EdgeShapesFloor2 = {} -- bottom

    return Terrain
end

function Object:UpdateObject( dt )
    if self.currentAnimation > 0 then
        x = self.body:getX() - self.w / 2
        y = self.body:getY() - self.h / 2
        self.animations[self.currentAnimation]:Update( dt, x, y )
    end
end

function Object:DrawObject()
    --love.graphics.polygon( "fill", self.body:getWorldPoints( self.shape:getPoints() ) )
    if self.currentAnimation > 0 then
        self.animations[self.currentAnimation]:Draw()
    end
end

return Object