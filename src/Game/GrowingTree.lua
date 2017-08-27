
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
    newGrowingTree.needGrow = false

    local img = love.graphics.newImage( "resources/Animation/FX/Petite-plante.png" )
    local img1 = love.graphics.newImage( "resources/Animation/FX/Grande-plante.png" )
    newGrowingTree:AddAnimation( img, 8, 8, 0, 0, 64, 104, false, false )

    
    newGrowingTree.w = 912
    newGrowingTree.h = 468
    newGrowingTree:AddAnimation( img1, 16, 24, 0, 0, 912, 468, false, false )

    newGrowingTree.w = w
    newGrowingTree.h = h

    newGrowingTree:SetCurrentAnimation( 1 )

    return newGrowingTree
end

function GrowingTree:Update( dt )
    if self.needGrow then
        self:Grow()
        self.needGrow = false
    end

    self:UpdateObject( dt )
    if self.currentAnimation == 2 and self.animations[ 2 ].playCount >= 1 then
        self.animations[ 2 ].currentquad = self.animations[ 2 ].imagecount
        self.animations[ 2 ]:TogglePause()
        self.animations[ 2 ].playCount = 0
    end
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
    
    self:SetCurrentAnimation( 2 )
end

return GrowingTree