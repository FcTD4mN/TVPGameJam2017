
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

    newGrowingTree.x = x
    newGrowingTree.y = y
    newGrowingTree.body = love.physics.newBody( world, x + w / 2, y + h / 2, "static" )
    newGrowingTree.body:setFixedRotation( true )
    newGrowingTree.shape = love.physics.newRectangleShape( w, h )
    newGrowingTree.fixture = love.physics.newFixture( newGrowingTree.body, newGrowingTree.shape )
    newGrowingTree.fixture:setFriction( 1.0 )
    newGrowingTree.fixture:setUserData( newGrowingTree )
    newGrowingTree.animations = {}
    newGrowingTree.currentAnimation = 0
    newGrowingTree.growed = false
    newGrowingTree.needGrow = false

    local img = love.graphics.newImage( "resources/Animation/FX/Petite-plante.png" )
    local img1 = love.graphics.newImage( "resources/Animation/FX/Grande-plante.png" )
    newGrowingTree:AddAnimation( img, 8, 8, false, false )

    
    newGrowingTree.w = 912
    newGrowingTree.h = 468
    newGrowingTree:AddAnimation( img1, 16, 24, false, false )

    newGrowingTree.w = w
    newGrowingTree.h = h

    newGrowingTree:PlayAnimation( 1, 0 ) -- play animation n°1 infinitely

    return newGrowingTree
end

function GrowingTree:Update( dt )
    if self.needGrow and not self.growed then
        self:Grow()
        self.needGrow = false
        self.growed = true
    end

    self:UpdateObject( dt )
end

function GrowingTree:Draw()
    self:DrawObject()
end

function GrowingTree:Type()
    return  "GrowingTree"
end

function GrowingTree:Grow()
    self.w = 912
    self.h = 468
    
    self.body = love.physics.newBody( world, self.x, self.y - 104, "static" )
    self.body:setFixedRotation( true )
    self.shape = love.physics.newPolygonShape( 0, 0, self.w / 2, 2 * self.h / 3, self.w, self.h )
    self.fixture = love.physics.newFixture( self.body, self.shape )
    self.fixture:setFriction( 1.0 )
    self.fixture:setUserData( nil )
    
    self:PlayAnimation( 2, 1 ) -- play animation n°2 once
end

return GrowingTree