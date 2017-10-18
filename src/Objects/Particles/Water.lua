
local Camera            = require "src/Camera/Camera"
local Object            = require "src/Objects/Object"
      ObjectRegistry    = require "src/Base/ObjectRegistry"


local Water = {}
setmetatable( Water, Object )
Object.__index = Object

ObjectRegistry.RegisterXMLCreation( "Water", Water )


-- ==========================================Constructor/Destructor


function Water:New( iWorld, iX, iY )

    newWater = {}
    setmetatable( newWater, Water )
    Water.__index = Water

    newWater:BuildWater( iWorld, iX, iY )

    return newWater

end


function Water:NewFromXML( iNode, iWorld )
    local newWater = {}
    setmetatable( newWater, Water )
    Water.__index = Water

    newWater:LoadWaterXML( iNode, iWorld )

    return newWater
end


function  Water:BuildWater( iWorld, iX, iY )

    self:BuildObject( iWorld, iX, iY, 20, 20, "dynamic", true )
    self.mBody:setGravityScale( 1.0 )

    local shape    = love.physics.newRectangleShape( 5, 5 )
    local fixture  = love.physics.newFixture( self.mBody, shape )
    fixture:setFriction( 0.1 )
    fixture:setUserData( self )

    local img = love.graphics.newImage( "resources/Images/Objects/Water.png" )
    self:AddAnimation( img, 1, 1, false, false )
    self:PlayAnimation( 1, 0 ) -- play animation n°1 infinitely

end


-- ==========================================Type


function Water:Type()
    return  "Water"
end


-- ==========================================Update/Draw


function Water:Update( iDT )
    self:UpdateObject( iDT )
end


function Water:Draw( iCamera )
    self:DrawObject( iCamera )
end


-- ==========================================Collision stuff


function Water:Collide( iObject )
    if iObject:Type() == "Waterball" then
        self:Destroy()
    end
end


-- ==========================================XML IO


function  Water:SaveXML()
    return  self:SaveWaterXML()
end


function  Water:SaveWaterXML()

    xmlData = "<Water>\n"

    xmlData = xmlData .. self:SaveObjectXML()

    xmlData = xmlData .. "</Water>\n"

    return  xmlData

end


function  Water:LoadWaterXML( iNode, iWorld )

    assert( iNode.name == "Water" )
    self:LoadObjectXML( iNode.el[ 1 ], iWorld )

    -- Those are transient values, so no point saving/loading them
    --Animations
    local img = love.graphics.newImage( "resources/Images/Objects/Water.png" )
    self:AddAnimation( img, 1, 1, false, false )
    self:PlayAnimation( 1, 0 ) -- play animation n°1 infinitely

end

return Water