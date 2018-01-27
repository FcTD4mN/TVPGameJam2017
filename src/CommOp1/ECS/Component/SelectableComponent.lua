local Component = require "src/ECS/Components/Component"
local ComponentRegistry = require "src/ECS/Components/ComponentRegistry"

local SelectableComponent = {}
setmetatable( SelectableComponent, Component )
Component.__index = Component

ComponentRegistry.Register( "SelectableComponent", SelectableComponent )


-- ==========================================Constructor/Destructor


function SelectableComponent:New( iX, iY )
    local newSelectableComponent = {}
    setmetatable( newSelectableComponent, SelectableComponent )
    SelectableComponent.__index = SelectableComponent

    newSelectableComponent.mName = "selectable"

    newSelectableComponent.mSelected = false

    return  newSelectableComponent

end


return  SelectableComponent