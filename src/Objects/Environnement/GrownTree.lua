
local Camera        = require "src/Camera/Camera"
local Object        = require "src/Objects/Object"
local ObjectPool    = require "src/Objects/Pools/ObjectPool"

local GrownTree = {}
setmetatable( GrownTree, Object )
Object.__index = Object


-- ==========================================Constructor/Destructor


function GrownTree:New( iWorld, iX, iY )

    local newGrownTree = {}
    setmetatable( newGrownTree, GrownTree )
    GrownTree.__index = GrownTree

    newGrownTree:BuildGrownTree( iWorld, iX, iY )

    return newGrownTree
end


function GrownTree:NewFromXML( iNode, iWorld )
    local newGrownTree = {}
    setmetatable( newGrownTree, GrownTree )
    GrownTree.__index = GrownTree

    newGrownTree:LoadGrownTreeXML( iNode, iWorld )

    return newGrownTree
end


function  GrownTree:BuildGrownTree( iWorld, iX, iY )

    self:BuildObject( iWorld, iX, iY, 912, 468, "static", true )
    self.mBody:setGravityScale( 0.0 )

    local shape    = love.physics.newPolygonShape(  -self.mW/2 + 20, self.mH / 2,
                                              -self.mW/2 + 20, self.mH / 2 - 120,
                                              0, -self.mH / 2 + 50,
                                              self.mW/2 - 100, -self.mH / 2 + 50 )

    local fixture  = love.physics.newFixture( self.mBody, shape )
    fixture:setFriction( 1.0 )
    fixture:setUserData( self )

    local img = love.graphics.newImage( "resources/Animation/FX/Grande-plante.png" )
    self:AddAnimation( img, 16, 12, false, false )
    self:PlayAnimation( 1, 1 )

end


-- ==========================================Type


function GrownTree:Type()
    return  "GrownTree"
end


-- ==========================================Update/Draw


function GrownTree:Update( iDT )
    self:UpdateObject( iDT )
end


function GrownTree:Draw( iCamera )
    self:DrawObject( iCamera )
end


-- ==========================================XML IO


function  GrownTree:SaveGrownTreeXML()

    xmlData = "<growntree>\n"

    xmlData = xmlData .. self:SaveObjectXML()

    xmlData = xmlData .. "</growntree>\n"

    return  xmlData

end


function  GrownTree:LoadGrownTreeXML( iNode, iWorld )

    assert( iNode.name == "growntree" )
    self:LoadObjectXML( iNode.el[ 1 ], iWorld )

    -- Those are transient values, so no point saving/loading them
    --Animations
    local img = love.graphics.newImage( "resources/Animation/FX/Grande-plante.png" )
    self:AddAnimation( img, 16, 12, false, false )
    self:PlayAnimation( 1, 1 )

end

return GrownTree