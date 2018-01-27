local Component = require "src/ECS/Components/Component"
local ComponentRegistry = require "src/ECS/Components/ComponentRegistry"

local RadiusComponent = {}
setmetatable( RadiusComponent, Component )
Component.__index = Component

ComponentRegistry.Register( "RadiusComponent", RadiusComponent )


-- ==========================================Constructor/Destructor


function RadiusComponent:New( iRadius )
    local newRadiusComponent = {}
    setmetatable( newRadiusComponent, RadiusComponent )
    RadiusComponent.__index = RadiusComponent

    newRadiusComponent.mName = "radius"

    newRadiusComponent.mRadius = iRadius

    return  newRadiusComponent

end


return  RadiusComponent