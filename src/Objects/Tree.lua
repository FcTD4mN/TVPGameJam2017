local Animation = require "src/Objects/Animation"
local Object = require "src/Objects/Object"

local Tree = Object:New( 0, 0, 0, 0, 0, 0, 0, 0 )

function Tree:New( world, x, y )
    local newTree = {}
    setmetatable( newTree, self )
    self.__index = self

    w = 560
    h = 540
    newTree.x = x
    newTree.y = y

    newTree.w = w
    newTree.h = h

    --inherited values
    newTree.body = love.physics.newBody( world, x + 45, y + 45, "static" )
    newTree.body:setFixedRotation( true )
    newTree.body:setGravityScale( 0.0 )
    newTree.shape = love.physics.newRectangleShape( newTree.w, newTree.h )
    newTree.fixture = love.physics.newFixture( newTree.body, newTree.shape )
    newTree.fixture:setFriction( 1.0 )
    newTree.animations = {}
    newTree.currentAnimation = 0

    local tree = love.graphics.newImage( "resources/Animation/FX/arbre_brule.png" )
    newTree:AddAnimation( tree, 11, 24, 0, 0, w, h, false, false )
    return newTree

end

function Tree:Update( dt )
    self:UpdateObject( dt )
end

function Tree:Draw()
    self:DrawObject()
end

return Tree