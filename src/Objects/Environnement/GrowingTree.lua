
local Camera = require "src/Camera/Camera"
local Object = require "src/Objects/Object"

local GrowingTree = Object:New( 0, 0, 0, 0, 0, 0, 0, 0 )


-- ==========================================Constructor/Destructor


function GrowingTree:New( iWorld, iX, iY )
    local newGrowingTree = {}
    setmetatable( newGrowingTree, self )
    self.__index = self

    newGrowingTree.x = iX
    newGrowingTree.y = iY
    newGrowingTree.w = 64
    newGrowingTree.h = 104

    --inherited values

    newGrowingTree.body     = love.physics.newBody( iWorld, iX + newGrowingTree.w/2, iY + newGrowingTree.h/2, "static" )
    newGrowingTree.body:setFixedRotation( true )
    newGrowingTree.body:setGravityScale( 0.0 )

    newGrowingTree.shape    = love.physics.newRectangleShape( newGrowingTree.w, newGrowingTree.h )
    newGrowingTree.fixture  = love.physics.newFixture( newGrowingTree.body, newGrowingTree.shape )
    newGrowingTree.fixture:setFriction( 1.0 )
    newGrowingTree.fixture:setUserData( newGrowingTree )


    newGrowingTree.animations       = {}
    newGrowingTree.currentAnimation = 0

    newGrowingTree.growed   = false
    newGrowingTree.needGrow = false

    local img = love.graphics.newImage( "resources/Animation/FX/Petite-plante.png" )
    local img1 = love.graphics.newImage( "resources/Animation/FX/Grande-plante.png" )
    newGrowingTree:AddAnimation( img, 8, 8, false, false )

    newGrowingTree.w = 912
    newGrowingTree.h = 468
    newGrowingTree:AddAnimation( img1, 16, 24, false, false )

    newGrowingTree.w = 64
    newGrowingTree.h = 104

    newGrowingTree:PlayAnimation( 1, 0 ) -- play animation n°1 infinitely

    return newGrowingTree
end


-- ==========================================Type


function GrowingTree:Type()
    return  "GrowingTree"
end


-- ==========================================Update/Draw


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


-- ==========================================GrowingTree actions


function GrowingTree:Grow()
    self.w = 912
    self.h = 468

    -- We get the world before killing old body
    world = self.body:getWorld()
    self:Destroy()

    self.body       = love.physics.newBody( world, self.x, self.y - 104, "static" )
    self.body:setFixedRotation( true )
    self.shape      = love.physics.newPolygonShape( 0, 0, self.w / 2, 2 * self.h / 3, self.w, self.h )
    self.fixture    = love.physics.newFixture( self.body, self.shape )
    self.fixture:setFriction( 1.0 )
    self.fixture:setUserData( self )

    self:PlayAnimation( 2, 1 ) -- play animation n°2 once
end

return GrowingTree