local Component = require "src/ECS/Components/Component"
local ComponentRegistry = require "src/ECS/Components/ComponentRegistry"

local Box2DComponent = {}
setmetatable( Box2DComponent, Component )
Component.__index = Component

ComponentRegistry.Register( "box2dcomponent", Box2DComponent )


-- ==========================================Constructor/Destructor


function Box2DComponent:New( iWorld, iBodyX, iBodyY, iBodyW, iBodyH, iPhysicType, iFixedRotation, iGravity, iOffsetY )
    local newBox2DComponent = {}
    setmetatable( newBox2DComponent, Box2DComponent )
    Box2DComponent.__index = Box2DComponent
    
    newBox2DComponent.mName = "box2d"

    newBox2DComponent.mBodyW = iBodyW
    newBox2DComponent.mBodyH = iBodyH
    newBox2DComponent.mOffsetY = iOffsetY -- ZAP: is for animation offseting, add a position in animation

    newBox2DComponent.mBody = love.physics.newBody( iWorld, iBodyX + iBodyW / 2, iBodyY + iBodyH / 2, iPhysicType )
    newBox2DComponent.mBody:setFixedRotation( iFixedRotation )
    newBox2DComponent.mBody:setGravityScale( iGravity )

    return  newBox2DComponent

end


function Box2DComponent:NewFromXML( iNode, iWorld, iEntity )
    local newBox2DComponent = {}
    setmetatable( newBox2DComponent, Box2DComponent )
    Box2DComponent.__index = Box2DComponent

    newBox2DComponent.mName = "box2d"

    newBox2DComponent:LoadBox2DComponentXML( iNode, iWorld, iEntity )

    return newBox2DComponent
end


function  Box2DComponent:SaveXML()
    return  self:SaveBox2DComponentXML()
end


function  Box2DComponent:SaveBox2DComponentXML()
    
    xmlData = "<box2dcomponent>\n"
    xmlData = xmlData .. self:SaveComponentXML()
    xmlData = xmlData .. "<attributes "
    xmlData = xmlData .. "bodyx='" .. self.mBody:getX() .. "' " ..
                         "bodyy='" .. self.mBody:getY() .. "' " ..
                         "bodyw='" .. self.mBodyW .. "' " ..
                         "bodyh='" .. self.mBodyH .. "' " ..
                         "physictype='" .. self.mBody:getType() .. "' " ..
                         "fixedrotation='" .. tostring(self.mBody:isFixedRotation()) .. "' " ..
                         "gravity='" .. self.mBody:getGravityScale() .. "' " ..
                         "offsety='" .. self.mOffsetY .. "' " ..
                         " >\n"

    xmlData = xmlData .. "<fixtures>\n"
    fixtures = self.mBody:getFixtureList()
    for k,v in pairs( fixtures ) do
        xmlData = xmlData .. SaveFixtureXML( v )
    end
    xmlData = xmlData .. "</fixtures>\n"
    xmlData = xmlData .. "</attributes>\n"
    
    xmlData = xmlData .. "</box2dcomponent>\n"
    
    return  xmlData

end


function  Box2DComponent:LoadBox2DComponentXML( iNode, iWorld, iEntity )

    print( iNode.name )
    assert( iNode.name == "box2dcomponent" )

    self:LoadComponentXML( iNode.el[1] )

    self.mBodyW = iNode.el[2].attr[3].value
    self.mBodyH = iNode.el[2].attr[4].value
    self.mBody = love.physics.newBody( iWorld, iNode.el[2].attr[1].value, iNode.el[2].attr[2].value, iNode.el[2].attr[5].value )
    self.mBody:setFixedRotation( ToBoolean( iNode.el[2].attr[6].value ) )
    self.mBody:setGravityScale( iNode.el[2].attr[7].value )
    self.mOffsetY = iNode.el[2].attr[8].value

    for i = 1, #iNode.el[2].el[1].el do --<attributes><fixtures><...>
        LoadFixtureXML( iNode.el[2].el[1].el[i], self.mBody, iEntity )
    end
end


return  Box2DComponent
