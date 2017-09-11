
local Object = require "src/Objects/Object"
local ObjectPool        = require "src/Objects/Pools/ObjectPool"


local Object_Box = {}
setmetatable( Object_Box, Object )
Object.__index = Object


-- ==========================================Constructor/Destructor


function Object_Box:New( iWorld, iX, iY, iType )
    local newObject_Box = {}
    setmetatable( newObject_Box, Object_Box )
    Object_Box.__index = Object_Box

    newObject_Box:BuildObject_Box( iWorld, iX, iY, iType )

    return newObject_Box

end


function Object_Box:NewFromXML( iNode, iWorld )
    local newObject_Box = {}
    setmetatable( newObject_Box, Object_Box )
    Object_Box.__index = Object_Box

    newObject_Box:LoadObject_BoxXML( iNode, iWorld )

    return newObject_Box
end


function  Object_Box:BuildObject_Box( iWorld, iX, iY )

    self:BuildObject( iWorld, iX, iY, 109, 95, "dynamic", false )
    self.mBody:setGravityScale( 0.0 )

    local shape    = love.physics.newRectangleShape( self.mW, self.mH )

    local fixture  = love.physics.newFixture( self.mBody, shape )
    fixture:setFriction( 0.7 )
    fixture:setUserData( self )

    local image = love.graphics.newImage( "resources/Images/Objects/Object_Box.png" )
    self:AddAnimation( image, 1, 24, false, false )
    self:PlayAnimation( 1, 0 ) --please replace by image only

end


-- ==========================================Type


function Object_Box:Type()
    return "Object_Box"
end


-- ==========================================Update/Draw


function Object_Box:Update( iDT )
    self:UpdateObject( iDT )
end


function Object_Box:Draw( iCamera )
    self:DrawObject( iCamera )
end


-- ==========================================XML IO


function  Object_Box:SaveObject_BoxXML()

    xmlData = "<objectbox>\n"

    xmlData = xmlData .. self:SaveObjectXML()

    xmlData = xmlData ..  "</objectbox>\n"

    return  xmlData

end


function  Object_Box:LoadObject_BoxXML( iNode, iWorld )

    assert( iNode.name == "objectbox" )
    self:LoadObjectXML( iNode.el[ 1 ], iWorld )

    -- Those are transient values, so no point saving/loading them
    --Animations
    local image = love.graphics.newImage( "resources/Images/Objects/Object_Box.png" )
    self:AddAnimation( image, 1, 24, false, false )
    self:PlayAnimation( 1, 0 ) --please replace by image only

end

return Object_Box