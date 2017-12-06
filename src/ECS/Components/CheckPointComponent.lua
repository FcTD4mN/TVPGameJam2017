local Component = require "src/ECS/Components/Component"
local ComponentRegistry = require "src/ECS/Components/ComponentRegistry"

local CheckPointComponent = {}
setmetatable( CheckPointComponent, Component )
Component.__index = Component

ComponentRegistry.Register( "checkpointcomponent", CheckPointComponent )


-- ==========================================Constructor/Destructor


function CheckPointComponent:New( iCheckPoint )
    local newCheckPointComponent = {}
    setmetatable( newCheckPointComponent, CheckPointComponent )
    CheckPointComponent.__index = CheckPointComponent
    
    newCheckPointComponent.mName = "checkpoint"

    newCheckPointComponent.mCheckPoint = iCheckPoint

    return  newCheckPointComponent

end


function CheckPointComponent:NewFromXML( iNode, iWorld, iEntity )
    local newCheckPointComponent = {}
    setmetatable( newCheckPointComponent, CheckPointComponent )
    CheckPointComponent.__index = CheckPointComponent

    newCheckPointComponent.mName = "checkpoint"

    newCheckPointComponent:LoadCheckPointComponentXML( iNode, iWorld, iEntity )

    return newCheckPointComponent
end


function  CheckPointComponent:SaveXML()
    return  self:SaveCheckPointComponentXML()
end


function  CheckPointComponent:SaveCheckPointComponentXML()
    
    xmlData = "<checkpointcomponent>"

    xmlData = xmlData .. self:SaveComponentXML()

    xmlData = xmlData .. "<attributes "
    xmlData = xmlData .. "checkpoint='" .. iComponent.mCheckPoint .. "' " ..
              " />\n"

    xmlData = xmlData .. "<checkpointcomponent />\n"
    
    return  xmlData

end


function  CheckPointComponent:LoadCheckPointComponentXML( iNode, iWorld, iEntity )

    assert( iNode.name == "checkpointcomponent" )

    self:LoadComponentXML( iNode.el[1] )
    self.mCheckPoint = iNode.el[2].attr[1].value
end


return  CheckPointComponent