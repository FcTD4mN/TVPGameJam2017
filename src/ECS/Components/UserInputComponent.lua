local Component = require "src/ECS/Components/Component"
local ComponentRegistry = require "src/ECS/Components/ComponentRegistry"

local UserInputComponent = {}
setmetatable( UserInputComponent, Component )
Component.__index = Component

ComponentRegistry.Register( "userinputcomponent", UserInputComponent )


-- ==========================================Constructor/Destructor


function UserInputComponent:New()
    local newUserInputComponent = {}
    setmetatable( newUserInputComponent, UserInputComponent )
    UserInputComponent.__index = UserInputComponent
    
    newUserInputComponent.mName = "userinput"

    newUserInputComponent.mActions = {}

    return  newUserInputComponent

end


function UserInputComponent:NewFromXML( iNode, iWorld, iEntity )
    local newUserInputComponent = {}
    setmetatable( newUserInputComponent, UserInputComponent )
    UserInputComponent.__index = UserInputComponent

    newUserInputComponent.mName = "userinput"

    newUserInput.mActions = {}
    newUserInputComponent:LoadUserInputComponentXML( iNode, iWorld, iEntity )

    return newUserInputComponent
end


function  UserInputComponent:SaveXML()
    return  self:SaveUserInputComponentXML()
end


function  UserInputComponent:SaveUserInputComponentXML()
    
    xmlData = "<userinputcomponent>\n"

    xmlData = xmlData .. self:SaveComponentXML()

    xmlData = xmlData .. "<attributes> </attributes>\n"

    xmlData = xmlData .. "</userinputcomponent>\n"
    
    return  xmlData

end


function  UserInputComponent:LoadUserInputComponentXML( iNode, iWorld, iEntity )

    assert( iNode.name == "userinputcomponent" )

    self:LoadComponentXML( iNode.el[1] )
end


return  UserInputComponent