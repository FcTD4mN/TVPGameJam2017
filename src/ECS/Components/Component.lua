local Component = {}

function Component:New()
    local newComponent = {}
    setmetatable( newComponent, Component )
    Component.__index = Component

    newComponent.mName = ""

    return newComponent
end

-- ==========================================XML IO


function  Component:SaveComponentXML()
    xmlData = "<component name='" .. self.mName .. "' />\n"
    return  xmlData
end


function  Component:LoadComponentXML( iNode )
    assert( iNode.name == "component" )
    self.mName = iNode.attr[1].value
end


return  Component
