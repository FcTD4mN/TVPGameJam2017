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
    newTree.shape = love.physics.newRectangleShape( 50, newTree.h )
    newTree.fixture = love.physics.newFixture( newTree.body, newTree.shape )
    newTree.fixture:setFriction( 1.0 )
    newTree.fixture:setUserData( newTree )
    newTree.animations = {}
    newTree.currentAnimation = 0
    newTree.burn = false

    local tree = love.graphics.newImage( "resources/Animation/FX/arbre_brule.png" )
    local treeFix = love.graphics.newImage( "resources/Animation/FX/arbre_brule.png" )
    newTree:AddAnimation( tree, 11, 12, 0, 0, w, h, false, false )
    newTree:AddAnimation( treeFix, 1, 1, 0, 0, w, h, false, false )
    newTree:SetCurrentAnimation( 2 )
    return newTree
end

function  Tree:Destroy()
    self.body       = nil
    self.shape      = nil
    self.fixture    = nil
end

function Tree:Update( dt )
    if( self.burn == true ) then
        self:SetCurrentAnimation( 1 )
    end
    self:UpdateObject( dt )
end

function  Tree:Burn()
    self.burn = true
end

function Tree:Draw()
    self:DrawObject()
end

function Tree:Type()
    return  "Tree"
end

return Tree