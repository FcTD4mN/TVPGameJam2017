local Component = require "src/ECS/Components/Component"
local ComponentRegistry = require "src/ECS/Components/ComponentRegistry"

local StateComponent = {}
setmetatable( StateComponent, Component )
Component.__index = Component

ComponentRegistry.Register( "statecomponent", StateComponent )


-- ==========================================Constructor/Destructor


function StateComponent:New( iState, iStateTransitions )
    local newStateComponent = {}
    setmetatable( newStateComponent, StateComponent )
    StateComponent.__index = StateComponent
    
    newStateComponent.mName = "state"

    newStateComponent.mState = iState
    newStateComponent.mAllowedTransitions = iStateTransitions

    return  newStateComponent

end


function StateComponent:NewFromXML( iNode, iWorld, iEntity )
    local newStateComponent = {}
    setmetatable( newStateComponent, StateComponent )
    StateComponent.__index = StateComponent

    newStateComponent.mName = "state"

    newStateComponent:LoadStateComponentXML( iNode, iWorld, iEntity )

    return newStateComponent
end


function  StateComponent:SaveXML()
    return  self:SaveStateComponentXML()
end


function  StateComponent:SaveStateComponentXML()
    
    xmlData = "<statecomponent>"

    xmlData = xmlData .. self:SaveComponentXML()

    xmlData = xmlData .. "<attributes "
    xmlData = xmlData .. "state='" .. iComponent.mState .. "' " ..
              " >\n"
    for k1,v1 in pairs(iComponent.mAllowedTransitions) do
        xmlData =   xmlData .. "<allowedtransitions '"
        xmlData =   xmlData .. "state='" .. k1 .. "' "
        for k2,v2 in pairs(iComponent.mAllowedTransitions[k1]) do
            xmlData =   xmlData .. "state" .. k2 .."='" .. v2 .. "' "
        end
        xmlData =   xmlData .. " />\n"
    end
    xmlData = xmlData .. "</attributes>\n" ..

    xmlData = xmlData .. "<statecomponent />\n"
    
    return  xmlData

end


function  StateComponent:LoadStateComponentXML( iNode, iWorld, iEntity )

    assert( iNode.name == "statecomponent" )

    self:LoadComponentXML( iNode.el[1] )

    self.mState = iNode.el[2].attr[1].value
    self.mAllowedTransitions = {}
    for i = 1, #iNode.el[2].el do
        self.mAllowedTransitions[ iNode.el[1].el[i].attr[1] ] = {}
        for j = 2, #iNode.el[1].el[i].attr do
            self.mAllowedTransitions[ iNode.el[1].el[i].attr[1] ][j] = iNode.el[1].el[i].attr[j].value
        end
    end
end


return  StateComponent