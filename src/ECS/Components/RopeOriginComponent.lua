local Component = require "src/ECS/Components/Component"
local ComponentRegistry = require "src/ECS/Components/ComponentRegistry"

local RopeOriginComponent = {}
setmetatable( RopeOriginComponent, Component )
Component.__index = Component

ComponentRegistry.Register( "ropeorigincomponent", RopeOriginComponent )


-- ==========================================Constructor/Destructor


function RopeOriginComponent:New( iWorld, iRopeOriginX, iRopeOriginY )
    local newRopeOriginComponent = {}
    setmetatable( newRopeOriginComponent, RopeOriginComponent )
    RopeOriginComponent.__index = RopeOriginComponent
    
    newRopeOriginComponent.mName = "ropeorigin"

    newRopeOriginComponent.mBody = love.physics.newBody( iWorld, iRopeOriginX, iRopeOriginY, "static" )
    newRopeOriginComponent.mBody:setFixedRotation( true )
    newRopeOriginComponent.mBody:setGravityScale( 0 )

    return  newRopeOriginComponent

end


function RopeOriginComponent:NewFromXML( iNode, iWorld, iEntity )
    local newRopeOriginComponent = {}
    setmetatable( newRopeOriginComponent, RopeOriginComponent )
    RopeOriginComponent.__index = RopeOriginComponent

    newRopeOriginComponent.mName = "ropeorigin"

    newRopeOriginComponent:LoadRopeOriginComponentXML( iNode, iWorld, iEntity )

    return newRopeOriginComponent
end


function  RopeOriginComponent:SaveXML()
    return  self:SaveRopeOriginComponentXML()
end


function  RopeOriginComponent:SaveRopeOriginComponentXML()
    
    xmlData = "<ropeorigincomponent>\n"

    xmlData = xmlData .. self:SaveComponentXML()

    xmlData = xmlData .. "<attributes "
    xmlData = xmlData .. "ropeoriginx='" .. self.mBody.getX() .. "' "
    xmlData = xmlData .. "ropeoriginy='" .. self.mBody.getY() .. "' " ..
              " />\n"

    xmlData = xmlData .. "</ropeorigincomponent>\n"
    
    return  xmlData

end


function  RopeOriginComponent:LoadRopeOriginComponentXML( iNode, iWorld, iEntity )

    assert( iNode.name == "ropeorigincomponent" )

    self:LoadComponentXML( iNode.el[1] )

    self.mBody = love.physics.newBody( iWorld, iNode.el[2].attr[1].value, iNode.el[2].attr[2].value, "static" )
    self.mBody:setFixedRotation( true )
    self.mBody:setGravityScale( 0 )
end


return  RopeOriginComponent