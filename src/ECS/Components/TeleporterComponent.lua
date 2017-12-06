local Component = require "src/ECS/Components/Component"
local ComponentRegistry = require "src/ECS/Components/ComponentRegistry"

local TeleporterComponent = {}
setmetatable( TeleporterComponent, Component )
Component.__index = Component

ComponentRegistry.Register( "teleportercomponent", TeleporterComponent )


-- ==========================================Constructor/Destructor


function TeleporterComponent:New( iTeleporterX, iTeleporterY )
    local newTeleporterComponent = {}
    setmetatable( newTeleporterComponent, TeleporterComponent )
    TeleporterComponent.__index = TeleporterComponent
    
    newTeleporterComponent.mName = "teleporter"

    newTeleporterComponent.mTeleporterX = iTeleporterX
    newTeleporterComponent.mTeleporterY = iTeleporterY

    return  newTeleporterComponent

end


function TeleporterComponent:NewFromXML( iNode, iWorld, iEntity )
    local newTeleporterComponent = {}
    setmetatable( newTeleporterComponent, TeleporterComponent )
    TeleporterComponent.__index = TeleporterComponent

    newTeleporterComponent.mName = "teleporter"

    newTeleporterComponent:LoadTeleporterComponentXML( iNode, iWorld, iEntity )

    return newTeleporterComponent
end


function  TeleporterComponent:SaveXML()
    return  self:SaveTeleporterComponentXML()
end


function  TeleporterComponent:SaveTeleporterComponentXML()
    
    xmlData = "<teleportercomponent>"

    xmlData = xmlData .. self:SaveComponentXML()

    xmlData = xmlData .. "<attributes "
    xmlData = xmlData .. "teleporterx='" .. iComponent.mTeleporterX .. "' "
    xmlData = xmlData .. "teleportery='" .. iComponent.mTeleporterY .. "' " ..
              " />\n"

    xmlData = xmlData .. "<teleportercomponent />\n"
    
    return  xmlData

end


function  TeleporterComponent:LoadTeleporterComponentXML( iNode, iWorld, iEntity )

    assert( iNode.name == "teleportercomponent" )

    self:LoadComponentXML( iNode.el[1] )
    self.mTeleporterX = iNode.el[2].attr[1].value
    self.mTeleporterY = iNode.el[2].attr[2].value
end


return  TeleporterComponent