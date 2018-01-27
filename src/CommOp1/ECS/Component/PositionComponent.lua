local Component = require "src/ECS/Components/Component"
local ComponentRegistry = require "src/ECS/Components/ComponentRegistry"

local PositionComponent = {}
setmetatable( PositionComponent, Component )
Component.__index = Component

ComponentRegistry.Register( "positioncomponent", PositionComponent )


-- ==========================================Constructor/Destructor


function PositionComponent:New( iX, iY )
    local newPositionComponent = {}
    setmetatable( newPositionComponent, PositionComponent )
    PositionComponent.__index = PositionComponent
    
    newPositionComponent.mName = "position"

    newPositionComponent.mX = iX
    newPositionComponent.mY = iY

    return  newPositionComponent

end


return  PositionComponent