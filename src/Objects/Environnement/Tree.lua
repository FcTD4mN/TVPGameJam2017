local Animation = require "src/Objects/Animation"
local Object    = require "src/Objects/Object"

local Tree = Object:New( 0, 0, 0, 0, 0, 0, 0, 0 )


-- ==========================================Constructor/Destructor


function Tree:New( iWorld, iX, iY )
    local newTree = {}
    setmetatable( newTree, self )
    self.__index = self

    newTree.x = x
    newTree.y = y

    newTree.w = 560
    newTree.h = 540

    --inherited values
    newTree.body        = love.physics.newBody( iWorld, iX + newTree.w/2, iY + newTree.h/2, "static" )
    newTree.body:setFixedRotation( true )
    newTree.body:setGravityScale( 0.0 )

    newTree.shape       = love.physics.newRectangleShape( 50, newTree.h )
    newTree.fixture     = love.physics.newFixture( newTree.body, newTree.shape )
    newTree.fixture:setFriction( 1.0 )
    newTree.fixture:setUserData( newTree )


    newTree.animations = {}
    newTree.currentAnimation = 0
    newTree.burn = false

<<<<<<< HEAD:src/Objects/Environnement/Tree.lua
    local tree      = love.graphics.newImage( "resources/Animation/FX/arbre_brule.png" )
    local treeFix   = love.graphics.newImage( "resources/Animation/FX/arbre_fixe.png" )
=======
    local tree = love.graphics.newImage( "resources/Animation/FX/arbre_brule.png" )
    local treeFix = love.graphics.newImage( "resources/Animation/FX/arbre_fixe.png" )
>>>>>>> fix weird commit:src/Objects/Tree.lua
    newTree:AddAnimation( tree, 11, 12, false, false )
    newTree:AddAnimation( treeFix, 1, 1, false, false )
    newTree:PlayAnimation( 2, 0 )
    return newTree
end


-- ==========================================Type


function Tree:Type()
    return  "Tree"
end


-- ==========================================Update/Draw


function Tree:Update( dt )
    if( self.burn == true ) then
        self:PlayAnimation( 1, 0 )
    end
    self:UpdateObject( dt )
end


function Tree:Draw()
    self:DrawObject()
    self:DEBUGDrawHitBox()
end


-- ==========================================Tree actions


function  Tree:Burn()
    self.burn = true
end

return Tree