local Component             = require "src/ECS/Components/Component"
local ComponentRegistry     = require "src/ECS/Components/ComponentRegistry"

local SimpleTransformationComponent = {}
setmetatable( SimpleTransformationComponent, Component )
Component.__index = Component

ComponentRegistry.Register( "SimpleTransformationComponent", SimpleTransformationComponent )


-- ==========================================Constructor/Destructor


function SimpleTransformationComponent:New()
    local newSimpleTransformationComponent = {}
    setmetatable( newSimpleTransformationComponent, SimpleTransformationComponent )
    SimpleTransformationComponent.__index = SimpleTransformationComponent

    newSimpleTransformationComponent.mName      = "simpletransformation"
    newSimpleTransformationComponent.mRotation  = 0
    newSimpleTransformationComponent.mScale     = 0

    return  newSimpleTransformationComponent

end


function SimpleTransformationComponent:NewFromXML( iNode )
    local newSimpleTransformationComponent = {}
    setmetatable( newSimpleTransformationComponent, SimpleTransformationComponent )
    SimpleTransformationComponent.__index = SimpleTransformationComponent

    newSimpleTransformationComponent.mName      = "simpletransformation"
    newSimpleTransformationComponent.mRotation  = 0
    newSimpleTransformationComponent.mScale     = 0

    newSimpleTransformationComponent:LoadSimpleTransformationComponentXML( iNode )

    return newSimpleTransformationComponent
end


function  SimpleTransformationComponent:SaveXML()
    return  self:SaveSimpleTransformationComponentXML()
end


function  SimpleTransformationComponent:SaveSimpleTransformationComponentXML()

    xmlData = "<SimpleTransformationComponent>\n"

    xmlData = xmlData .. self:SaveComponentXML()

    xmlData = xmlData .. "<attributes " ..
                            xmlData = xmlData .. "rotation='"   .. self.mRotation   .. "' " ..
                            xmlData = xmlData .. "scale='"      .. self.mScale      .. "' " ..
                                    " />\n"

    xmlData = xmlData .. "</SimpleTransformationComponent>\n"

    return  xmlData

end


function  SimpleTransformationComponent:LoadSimpleTransformationComponentXML( iNode )

    assert( iNode.name == "SimpleTransformationComponent" )

    self:LoadComponentXML( iNode.el[1] )
    self.mRotation  = iNode.el[2].attr[1].value
    self.mScale     = iNode.el[2].attr[2].value

end


return  SimpleTransformationComponent