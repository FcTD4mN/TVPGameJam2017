local Component = require "src/ECS/Components/Component"
local ComponentRegistry = require "src/ECS/Components/ComponentRegistry"

local FactionComponent = {}
setmetatable( FactionComponent, Component )
Component.__index = Component

ComponentRegistry.Register( "FactionComponent", FactionComponent )


-- ==========================================Constructor/Destructor


function FactionComponent:New( iFaction, iInfluence, iResistance )
    local newFactionComponent = {}
    setmetatable( newFactionComponent, FactionComponent )
    FactionComponent.__index = FactionComponent

    newFactionComponent.mName = "faction"
    newFactionComponent.mFaction = iFaction --neutral/communist/capitalist
    newFactionComponent.mFactionScore = nil --neutral/communist/capitalist
    

    if newFactionComponent.mFaction == "neutral" then
        newFactionComponent.mFactionScore = 50
    elseif newFactionComponent.mFaction == "capitalist" then
        newFactionComponent.mFactionScore = 100
    elseif newFactionComponent.mFaction == "communist" then
        newFactionComponent.mFactionScore = 0
    end

    newFactionComponent.mInfluence = iInfluence --neutral/communist/capitalist
    newFactionComponent.mResistance = iResistance --neutral/communist/capitalist
    newFactionComponent.mInfluenceSign = newFactionComponent:InfluenceSign() --neutral/communist/capitalist

    return  newFactionComponent

end

function  FactionComponent:IdlePath()

    local path = ""
    if self.mFaction == "neutral" then
        path = 'resources/CommOp1/RecherchesGraphiques/landaman.png'
    elseif self.mFaction == "capitalist" then
        path = "resources/CommOp1/RecherchesGraphiques/capitaliste.png"
    elseif self.mFaction == "communist" then
        path = "resources/CommOp1/RecherchesGraphiques/communiste.png"
    end

    return  path

end



function  FactionComponent:MovePath()

    local path = ""
    if self.mFaction == "neutral" then
        path = 'resources/CommOp1/RecherchesGraphiques/landaman_spritesheet.png'
    elseif self.mFaction == "capitalist" then
        path = "resources/CommOp1/RecherchesGraphiques/capitaliste_spritesheet.png"
    elseif self.mFaction == "communist" then
        path = "resources/CommOp1/RecherchesGraphiques/communiste_spritesheet.png"
    end

    return  path
end

function  FactionComponent:InfluenceSign()

    if self.mFaction == "neutral" then
        print( " InfluenceSign0 : "..self.mFaction )
        return  0
    elseif self.mFaction == "capitalist" then
        print( " InfluenceSign1 : "..self.mFaction )
        return  1
    elseif self.mFaction == "communist" then
        print( " InfluenceSign-1 : "..self.mFaction )
        return  -1
    end

    return  0
end


return  FactionComponent