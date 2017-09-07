local Animation = require "src/Image/Animation"
local Object    = require "src/Objects/Object"
local ObjectPool        = require "src/Objects/Pools/ObjectPool"


local Tree = {}
setmetatable( Tree, Object )
Object.__index = Object


-- ==========================================Constructor/Destructor


function Tree:New( iWorld, iX, iY )

    local newTree = {}
    setmetatable( newTree, Tree )
    Tree.__index = Tree

    newTree:BuildTree( iWorld, iX, iY )

    return newTree

end


function  Tree:BuildTree( iWorld, iX, iY )

    self:BuildObject( iWorld, iX, iY, 560, 540, "static", true )
    self.mBody:setGravityScale( 0.0 )

    local hitboxWidth = 80
    local shape       = love.physics.newRectangleShape( 0, 0 , hitboxWidth, 600 )
    local fixture     = love.physics.newFixture( self.mBody, shape )
    fixture:setFriction( 1.0 )
    fixture:setUserData( self )

    local tree      = love.graphics.newImage( "resources/Animation/FX/arbre_brule.png" )
    local treeFix   = love.graphics.newImage( "resources/Animation/FX/arbre_fixe.png" )
    self:AddAnimation( tree, 11, 12, false, false )
    self:AddAnimation( treeFix, 1, 1, false, false )
    self:PlayAnimation( 2, 0 )

end


-- ==========================================Type


function Tree:Type()
    return  "Tree"
end


-- ==========================================Update/Draw


function Tree:Update( iDT )
    self:UpdateObject( iDT )
end


function Tree:Draw( iCamera )
    self:DrawObject( iCamera )
end


-- ==========================================Tree actions


function  HasBurnedCB( iTree )
    iTree:Destroy()
end

function  Tree:Burn() --Arguments are
    self:PlayAnimation( 1, 1, HasBurnedCB, self )
end

-- ==========================================Collision stuff


function Tree:Collide( iObject )
    if iObject:Type() == "Fireball" then
        self:Burn()
    end
end

return Tree