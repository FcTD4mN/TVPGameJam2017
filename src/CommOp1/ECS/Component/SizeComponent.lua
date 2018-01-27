local Component = require "src/ECS/Components/Component"
local ComponentRegistry = require "src/ECS/Components/ComponentRegistry"

local SizeComponent = {}
setmetatable( SizeComponent, Component )
Component.__index = Component

ComponentRegistry.Register( "SizeComponent", SizeComponent )


-- ==========================================Constructor/Destructor


function SizeComponent:New( iW, iH )
    local newSizeComponent = {}
    setmetatable( newSizeComponent, SizeComponent )
    SizeComponent.__index = SizeComponent

    newSizeComponent.mName = "size"
    newSizeComponent.mW = iW
    newSizeComponent.mH = iH

    return  newSizeComponent

end


return  SizeComponent