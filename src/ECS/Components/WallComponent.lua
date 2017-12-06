local Component = require "src/ECS/Components/Component"
local ComponentRegistry = require "src/ECS/Components/ComponentRegistry"

local WallComponent = {}
setmetatable( WallComponent, Component )
Component.__index = Component

ComponentRegistry.Register( "wallcomponent", WallComponent )


-- ==========================================Constructor/Destructor


function WallComponent:New()
    local newWallComponent = {}
    setmetatable( newWallComponent, WallComponent )
    WallComponent.__index = WallComponent
    
    newWallComponent.mName = "wall"

    return  newWallComponent

end


function WallComponent:NewFromXML( iNode, iWorld, iEntity )
    local newWallComponent = {}
    setmetatable( newWallComponent, WallComponent )
    WallComponent.__index = WallComponent

    newWallComponent.mName = "wall"

    newWallComponent:LoadWallComponentXML( iNode, iWorld, iEntity )

    return newWallComponent
end


function  WallComponent:SaveXML()
    return  self:SaveWallComponentXML()
end


function  WallComponent:SaveWallComponentXML()
    
    xmlData = "<wallcomponent>\n"

    xmlData = xmlData .. self:SaveComponentXML()

    xmlData = xmlData .. "<attributes> </attributes>\n"

    xmlData = xmlData .. "</wallcomponent>\n"
    
    return  xmlData

end


function  WallComponent:LoadWallComponentXML( iNode, iWorld, iEntity )

    assert( iNode.name == "wallcomponent" )

    self:LoadComponentXML( iNode.el[1] )
end


return  WallComponent