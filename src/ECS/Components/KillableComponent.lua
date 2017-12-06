local Component = require "src/ECS/Components/Component"
local ComponentRegistry = require "src/ECS/Components/ComponentRegistry"

local KillableComponent = {}
setmetatable( KillableComponent, Component )
Component.__index = Component

ComponentRegistry.Register( "Killablecomponent", KillableComponent )


-- ==========================================Constructor/Destructor


function KillableComponent:New()
    local newKillableComponent = {}
    setmetatable( newKillableComponent, KillableComponent )
    KillableComponent.__index = KillableComponent
    
    newKillableComponent.mName = "killable"

    newKillableComponent.mDeathCount = 0

    return  newKillableComponent

end


function KillableComponent:NewFromXML( iNode, iWorld, iEntity )
    local newKillableComponent = {}
    setmetatable( newKillableComponent, KillableComponent )
    KillableComponent.__index = KillableComponent

    newKillableComponent.mName = "killable"

    newKillableComponent:LoadKillableComponentXML( iNode, iWorld, iEntity )

    return newKillableComponent
end


function  KillableComponent:SaveXML()
    return  self:SaveKillableComponentXML()
end


function  KillableComponent:SaveKillableComponentXML()
    
    xmlData = "<killablecomponent>"

    xmlData = xmlData .. self:SaveComponentXML()

    xmlData = xmlData .. "<attributes/>\n"

    xmlData = xmlData .. "<killablecomponent />\n"
    
    return  xmlData

end


function  KillableComponent:LoadKillableComponentXML( iNode, iWorld, iEntity )

    assert( iNode.name == "killablecomponent" )

    self:LoadComponentXML( iNode.el[1] )
end


return  KillableComponent