local Component = require "src/ECS/Components/Component"
local ComponentRegistry = require "src/ECS/Components/ComponentRegistry"

local SpeedComponent = {}
setmetatable( SpeedComponent, Component )
Component.__index = Component

ComponentRegistry.Register( "SpeedComponent", SpeedComponent )


-- ==========================================Constructor/Destructor


function SpeedComponent:New( iSpeed )
    local newSpeedComponent = {}
    setmetatable( newSpeedComponent, SpeedComponent )
    SpeedComponent.__index = SpeedComponent

    newSpeedComponent.mName = "speed"
    newSpeedComponent.mSpeed = iSpeed

    return  newSpeedComponent

end


return  SpeedComponent