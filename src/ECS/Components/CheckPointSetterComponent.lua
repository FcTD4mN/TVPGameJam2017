local Component = require "src/ECS/Components/Component"
local ComponentRegistry = require "src/ECS/Components/ComponentRegistry"

local CheckPointSetterComponent = {}
setmetatable( CheckPointSetterComponent, Component )
Component.__index = Component

ComponentRegistry.Register( "checkpointsettercomponent", CheckPointSetterComponent )


-- ==========================================Constructor/Destructor


function CheckPointSetterComponent:New( iCheckPoint )
    local newCheckPointSetterComponent = {}
    setmetatable( newCheckPointSetterComponent, CheckPointSetterComponent )
    CheckPointSetterComponent.__index = CheckPointSetterComponent
    
    newCheckPointSetterComponent.mName = "checkpointsetter"

    newCheckPointSetterComponent.mCheckPoint = iCheckPoint

    return  newCheckPointSetterComponent

end


function CheckPointSetterComponent:NewFromXML( iNode, iWorld, iEntity )
    local newCheckPointSetterComponent = {}
    setmetatable( newCheckPointSetterComponent, CheckPointSetterComponent )
    CheckPointSetterComponent.__index = CheckPointSetterComponent

    newCheckPointSetterComponent.mName = "checkpointsetter"

    newCheckPointSetterComponent:LoadCheckPointSetterComponentXML( iNode, iWorld, iEntity )

    return newCheckPointSetterComponent
end


function  CheckPointSetterComponent:SaveXML()
    return  self:SaveCheckPointSetterComponentXML()
end


function  CheckPointSetterComponent:SaveCheckPointSetterComponentXML()
    
    xmlData = "<checkpointsettercomponent>"

    xmlData = xmlData .. self:SaveComponentXML()

    xmlData = xmlData .. "<attributes "
    xmlData = xmlData .. "checkpoint='" .. iComponent.mCheckPoint .. "' " ..
              " />\n"

    xmlData = xmlData .. "<checkpointsettercomponent />\n"
    
    return  xmlData

end


function  CheckPointSetterComponent:LoadCheckPointSetterComponentXML( iNode, iWorld, iEntity )

    assert( iNode.name == "checkpointsettercomponent" )

    self:LoadComponentXML( iNode.el[1] )
    self.mCheckPoint = iNode.el[2].attr[1].value
end


return  CheckPointSetterComponent