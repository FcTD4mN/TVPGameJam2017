
local Camera        = require "src/Camera/Camera"
local Object        = require "src/Objects/Object"
local ObjectPool    = require "src/Objects/Pools/ObjectPool"
local GrownTree     = require "src/Objects/Environnement/GrownTree"

local BabyTree = Object:New( 0, 0, 0, 0, 0, 0, 0, 0 )


-- ==========================================Constructor/Destructor


function BabyTree:Finalize()
    local grownTree = GrownTree:New( self.body:getWorld(), self.x, self.y - 300 )

    self.body:destroy()
    self.body = nil
    self.shape = nil
    self.fixture = nil
end


function BabyTree:New( iWorld, iX, iY )
    local newBabyTree = {}
    setmetatable( newBabyTree, self )
    self.__index = self

    newBabyTree.x = iX
    newBabyTree.y = iY
    newBabyTree.w = 64
    newBabyTree.h = 104

    --inherited values

    newBabyTree.body     = love.physics.newBody( iWorld, iX + newBabyTree.w/2, iY + newBabyTree.h/2, "static" )
    newBabyTree.body:setFixedRotation( true )
    newBabyTree.body:setGravityScale( 0.0 )

    shape    = love.physics.newRectangleShape( newBabyTree.w, newBabyTree.h )
    fixture  = love.physics.newFixture( newBabyTree.body, shape )
    fixture:setFriction( 1.0 )
    fixture:setUserData( newBabyTree )

    newBabyTree.animations       = {}
    newBabyTree.currentAnimation = 0

    local img = love.graphics.newImage( "resources/Animation/FX/Petite-plante.png" )
    newBabyTree:AddAnimation( img, 8, 8, false, false )

    newBabyTree:PlayAnimation( 1, 0 ) -- play animation n°1 infinitely

    ObjectPool.AddObject( newBabyTree )

    return newBabyTree
end


-- ==========================================Type


function BabyTree:Type()
    return  "BabyTree"
end


-- ==========================================Update/Draw


function BabyTree:Update( dt )
    self:UpdateObject( dt )
end


function BabyTree:Draw()
    self:DrawObject()
end


-- ==========================================Collision stuff


function BabyTree:Collide( iObject )
    if iObject:Type() == "Waterball" then
        self:Destroy()
    end
end

return BabyTree