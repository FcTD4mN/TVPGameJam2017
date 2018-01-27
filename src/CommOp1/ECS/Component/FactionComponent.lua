local Component = require "src/ECS/Components/Component"
local ComponentRegistry = require "src/ECS/Components/ComponentRegistry"

local FactionComponent = {}
setmetatable( FactionComponent, Component )
Component.__index = Component

ComponentRegistry.Register( "FactionComponent", FactionComponent )


-- ==========================================Constructor/Destructor


function FactionComponent:New( iFaction )
    local newFactionComponent = {}
    setmetatable( newFactionComponent, FactionComponent )
    FactionComponent.__index = FactionComponent

    newFactionComponent.mName = "faction"
    newFactionComponent.mFaction = iFaction --neutral/communist/capitalist

    return  newFactionComponent

end

function  FactionComponent:SpritePath()

    local path = ""
    if self.mFaction == "neutral" then
        path = "resources/CommOp1/RecherchesGraphiques/landaman.png"
    elseif self.mFaction == "capitalist" then
        path = "resources/CommOp1/RecherchesGraphiques/capitaliste.png"
    elseif self.mFaction == "communist" then
        path = "resources/CommOp1/RecherchesGraphiques/communiste.png"
    end

    return  path
end


return  FactionComponent