local Component = require "src/ECS/Components/Component"
local ComponentRegistry = require "src/ECS/Components/ComponentRegistry"

local ClickBoxComponent = {}
setmetatable( ClickBoxComponent, Component )
Component.__index = Component

ComponentRegistry.Register( "ClickBoxComponent", ClickBoxComponent )


-- ==========================================Constructor/Destructor


function ClickBoxComponent:New( iX, iY, iW, iH )
    local newClickBoxComponent = {}
    setmetatable( newClickBoxComponent, ClickBoxComponent )
    ClickBoxComponent.__index = ClickBoxComponent

    newClickBoxComponent.mName = "clickbox"
    newClickBoxComponent.mX = iX
    newClickBoxComponent.mY = iY
    newClickBoxComponent.mW = iW
    newClickBoxComponent.mH = iH

    return  newClickBoxComponent

end


return  ClickBoxComponent