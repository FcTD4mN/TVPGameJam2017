local Component = require "src/ECS/Components/Component"
local ComponentRegistry = require "src/ECS/Components/ComponentRegistry"

local InfluencableRadiusComponent = {}
setmetatable( InfluencableRadiusComponent, Component )
Component.__index = Component

ComponentRegistry.Register( "InfluencableRadiusComponent", InfluencableRadiusComponent )


-- ==========================================Constructor/Destructor


function InfluencableRadiusComponent:New( iRadius )
    local newInfluencableRadiusComponent = {}
    setmetatable( newInfluencableRadiusComponent, InfluencableRadiusComponent )
    InfluencableRadiusComponent.__index = InfluencableRadiusComponent

    newInfluencableRadiusComponent.mName = "influencableradius"

    newInfluencableRadiusComponent.mRadius = iRadius

    return  newInfluencableRadiusComponent

end


return  InfluencableRadiusComponent