
local Camera = require "src/Camera/Camera"
local Object = require "src/Objects/Object"

local GrowingTree = Object:New( 0, 0, 0, 0, 0, 0, 0, 0 )

function GrowingTree:New( world, x, y )
    local newGrowingTree = {}
    setmetatable( newGrowingTree, self )
    self.__index = self

    w = 64
    h = 104

    newGrowingTree.w = w
    newGrowingTree.h = h

    --inherited values
    newGrowingTree.body = love.physics.newBody( world, x + w / 2, y + h / 2, "static" )
    newGrowingTree.body:setFixedRotation( true )
    newGrowingTree.shape = love.physics.newRectangleShape( w, h )
    newGrowingTree.fixture = love.physics.newFixture( newGrowingTree.body, newGrowingTree.shape )
    newGrowingTree.fixture:setFriction( 1.0 )
    newGrowingTree.fixture:setUserData( newGrowingTree )
    newGrowingTree.animations = {}
    newGrowingTree.currentAnimation = 0

    local img = love.graphics.newImage( "resources/Animation/FX/Petite-plante.png" )
    local img1 = love.graphics.newImage( "resources/Animation/FX/Grande-plante.png" )
    newGrowingTree:AddAnimation( img, 8, 8, 0, 0, 64, 104, false, false )
    newGrowingTree:AddAnimation( img, 16, 24, 0, 0, 912, 468, false, false )

    newGrowingTree:SetCurrentAnimation( 1 )

    return newGrowingTree
end

function GrowingTree:Update( dt )
    self:UpdateObject( dt )
end

function GrowingTree:Draw()
    self:DrawObject()
end

function GrowingTree:Type()
    return  "GrowingTree"
end

return GrowingTree