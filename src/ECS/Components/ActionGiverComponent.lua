local Component = require "src/ECS/Components/Component"
local ComponentRegistry = require "src/ECS/Components/ComponentRegistry"

local ActionGiverComponent = {}
setmetatable( ActionGiverComponent, Component )
Component.__index = Component

ComponentRegistry.Register( "actiongivercomponent", ActionGiverComponent )


-- ==========================================Constructor/Destructor


function ActionGiverComponent:New( iAction )
    local newActionGiverComponent = {}
    setmetatable( newActionGiverComponent, ActionGiverComponent )
    ActionGiverComponent.__index = ActionGiverComponent
    
    newActionGiverComponent.mName = "actiongiver"

    newActionGiverComponent.mAction = iAction

    return  newActionGiverComponent

end


function ActionGiverComponent:NewFromXML( iNode, iWorld, iEntity )
    local newActionGiverComponent = {}
    setmetatable( newActionGiverComponent, ActionGiverComponent )
    ActionGiverComponent.__index = ActionGiverComponent

    newActionGiverComponent.mName = "actiongiver"

    newActionGiverComponent:LoadActionGiverComponentXML( iNode, iWorld, iEntity )

    return newActionGiverComponent
end


function  ActionGiverComponent:SaveXML()
    return  self:SaveActionGiverComponentXML()
end


function  ActionGiverComponent:SaveActionGiverComponentXML()
    
    xmlData = "<actiongivercomponent>\n"

    xmlData = xmlData .. self:SaveComponentXML()

    xmlData = xmlData .. "<attributes "
    xmlData = xmlData .. "action='" .. self.mAction .. "' " ..
              " />\n"

    xmlData = xmlData .. "</actiongivercomponent>\n"
    
    return  xmlData

end


function  ActionGiverComponent:LoadActionGiverComponentXML( iNode, iWorld, iEntity )

    assert( iNode.name == "actiongivercomponent" )

    self:LoadComponentXML( iNode.el[1] )
    self.mAction = iNode.el[2].attr[1].value
end


return  ActionGiverComponent