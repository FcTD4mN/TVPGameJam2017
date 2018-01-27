local Component = require "src/ECS/Components/Component"
local ComponentRegistry = require "src/ECS/Components/ComponentRegistry"

local DestinationComponent = {}
setmetatable( DestinationComponent, Component )
Component.__index = Component

ComponentRegistry.Register( "DestinationComponent", DestinationComponent )


-- ==========================================Constructor/Destructor


function DestinationComponent:New( iX, iY )
    local newDestinationComponent = {}
    setmetatable( newDestinationComponent, DestinationComponent )
    DestinationComponent.__index = DestinationComponent

    newDestinationComponent.mName = "destination"

    newDestinationComponent.mX = {}
    newDestinationComponent.mY = {}
    newDestinationComponent.mIndex = {}
    newDestinationComponent.mActive = false

    return  newDestinationComponent

end


return  DestinationComponent