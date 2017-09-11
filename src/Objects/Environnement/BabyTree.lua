
local Camera        = require "src/Camera/Camera"
local Object        = require "src/Objects/Object"
local ObjectPool    = require "src/Objects/Pools/ObjectPool"
local GrownTree     = require "src/Objects/Environnement/GrownTree"


local BabyTree = {}
setmetatable( BabyTree, Object )
Object.__index = Object


-- ==========================================Constructor/Destructor


function BabyTree:Finalize()
    local grownTree = GrownTree:New( self.mBody:getWorld(), self.mX, self.mY - 300 )

    self.mBody:destroy()
    self.mBody = nil
end


function BabyTree:New( iWorld, iX, iY )

    newBabyTree = {}
    setmetatable( newBabyTree, BabyTree )
    BabyTree.__index = BabyTree

    newBabyTree:BuildBabyTree( iWorld, iX, iY )

    return newBabyTree

end


function BabyTree:NewFromXML( iNode, iWorld )
    local newBabyTree = {}
    setmetatable( newBabyTree, BabyTree )
    BabyTree.__index = BabyTree

    newBabyTree:LoadBabyTreeXML( iNode, iWorld )

    return newBabyTree
end


function  BabyTree:BuildBabyTree( iWorld, iX, iY )

    self:BuildObject( iWorld, iX, iY, 90, 120, "static", true )
    self.mBody:setGravityScale( 0.0 )

    local shape    = love.physics.newRectangleShape( self.mW, self.mH )
    local fixture  = love.physics.newFixture( self.mBody, shape )
    fixture:setFriction( 1.0 )
    fixture:setUserData( self )

    local img = love.graphics.newImage( "resources/Animation/FX/Petite-plante.png" )
    self:AddAnimation( img, 8, 8, false, false )
    self:PlayAnimation( 1, 0 ) -- play animation n°1 infinitely

end


-- ==========================================Type


function BabyTree:Type()
    return  "BabyTree"
end


-- ==========================================Update/Draw


function BabyTree:Update( iDT )
    self:UpdateObject( iDT )
end


function BabyTree:Draw( iCamera )
    self:DrawObject( iCamera )
end


-- ==========================================Collision stuff


function BabyTree:Collide( iObject )
    if iObject:Type() == "Waterball" then
        self:Destroy()
    end
end


-- ==========================================XML IO


function  BabyTree:SaveBabyTreeXML()

    xmlData = "<babytree>\n"

    xmlData = xmlData .. self:SaveObjectXML()

    xmlData = xmlData .. "</babytree>\n"

    return  xmlData

end


function  BabyTree:LoadBabyTreeXML( iNode, iWorld )

    assert( iNode.name == "babytree" )
    self:LoadObjectXML( iNode.el[ 1 ], iWorld )

    -- Those are transient values, so no point saving/loading them
    --Animations
    local img = love.graphics.newImage( "resources/Animation/FX/Petite-plante.png" )
    self:AddAnimation( img, 8, 8, false, false )
    self:PlayAnimation( 1, 0 ) -- play animation n°1 infinitely

end

return BabyTree