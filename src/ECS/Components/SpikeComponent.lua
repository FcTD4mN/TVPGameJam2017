local Component = require "src/ECS/Components/Component"
local ComponentRegistry = require "src/ECS/Components/ComponentRegistry"

local SpikeComponent = {}
setmetatable( SpikeComponent, Component )
Component.__index = Component

ComponentRegistry.Register( "spikecomponent", SpikeComponent )


-- ==========================================Constructor/Destructor


function SpikeComponent:New()
    local newSpikeComponent = {}
    setmetatable( newSpikeComponent, SpikeComponent )
    SpikeComponent.__index = SpikeComponent
    
    newSpikeComponent.mName = "spike"

    return  newSpikeComponent

end


function SpikeComponent:NewFromXML( iNode, iWorld, iEntity )
    local newSpikeComponent = {}
    setmetatable( newSpikeComponent, SpikeComponent )
    SpikeComponent.__index = SpikeComponent

    newSpikeComponent.mName = "spike"

    newSpikeComponent:LoadSpikeComponentXML( iNode, iWorld, iEntity )

    return newSpikeComponent
end


function  SpikeComponent:SaveXML()
    return  self:SaveSpikeComponentXML()
end


function  SpikeComponent:SaveSpikeComponentXML()
    
    xmlData = "<spikecomponent>"

    xmlData = xmlData .. self:SaveComponentXML()

    xmlData = xmlData .. "<attributes/>\n"

    xmlData = xmlData .. "<spikecomponent />\n"
    
    return  xmlData

end


function  SpikeComponent:LoadSpikeComponentXML( iNode, iWorld, iEntity )

    assert( iNode.name == "spikecomponent" )

    self:LoadComponentXML( iNode.el[1] )
end


return  SpikeComponent