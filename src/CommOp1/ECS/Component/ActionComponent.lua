local Component = require "src/ECS/Components/Component"
local ComponentRegistry = require "src/ECS/Components/ComponentRegistry"

local ActionComponent = {}
setmetatable( ActionComponent, Component )
Component.__index = Component

ComponentRegistry.Register( "ActionComponent", ActionComponent )


-- ==========================================Constructor/Destructor


function ActionComponent:New( iAction )
    local newActionComponent = {}
    setmetatable( newActionComponent, ActionComponent )
    ActionComponent.__index = ActionComponent

    newActionComponent.mName = "action"
    newActionComponent.mAction = iAction

    return  newActionComponent

end


return  ActionComponent