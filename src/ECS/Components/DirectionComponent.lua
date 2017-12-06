local Component = require "src/ECS/Components/Component"
local ComponentRegistry = require "src/ECS/Components/ComponentRegistry"

local DirectionComponent = {}
setmetatable( DirectionComponent, Component )
Component.__index = Component

ComponentRegistry.Register( "directioncomponent", DirectionComponent )


-- ==========================================Constructor/Destructor


function DirectionComponent:New( iDirectionH, iDirectionV )
    local newDirectionComponent = {}
    setmetatable( newDirectionComponent, DirectionComponent )
    DirectionComponent.__index = DirectionComponent
    
    newDirectionComponent.mName = "direction"

    newDirectionComponent.mDirectionH = iDirectionH
    newDirectionComponent.mDirectionV = iDirectionV

    return  newDirectionComponent

end


function DirectionComponent:NewFromXML( iNode, iWorld, iEntity )
    local newDirectionComponent = {}
    setmetatable( newDirectionComponent, DirectionComponent )
    DirectionComponent.__index = DirectionComponent

    newDirectionComponent.mName = "direction"

    newDirectionComponent:LoadDirectionComponentXML( iNode, iWorld, iEntity )

    return newDirectionComponent
end


function  DirectionComponent:SaveXML()
    return  self:SaveDirectionComponentXML()
end


function  DirectionComponent:SaveDirectionComponentXML()
    
    xmlData = "<directioncomponent>"

    xmlData = xmlData .. self:SaveComponentXML()

    xmlData = xmlData .. "<attributes "
    xmlData = xmlData .. "directionh='" .. iComponent.mDirectionH .. "' "
    xmlData = xmlData .. "directionv='" .. iComponent.mDirectionV .. "' "..
              " />\n"

    xmlData = xmlData .. "<directioncomponent />\n"
    
    return  xmlData

end


function  DirectionComponent:LoadDirectionComponentXML( iNode, iWorld, iEntity )

    assert( iNode.name == "directioncomponent" )

    self:LoadComponentXML( iNode.el[1] )
    self.mDirectionH = iNode.el[2].attr[1].value
    self.mDirectionV = iNode.el[2].attr[2].value
end


return  DirectionComponent