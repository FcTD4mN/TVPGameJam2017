local SystemBase = require( "src/ECS/Systems/SystemBase" )
local Shortcuts = require( "src/Application/Shortcuts" )

local  InputConverter = {}
setmetatable( InputConverter, SystemBase )
SystemBase.__index = SystemBase


function  InputConverter:Initialize()

    self.mEntityGroup = {}

end


function InputConverter:IncomingEntity( iEntity )

    -- Here we decide if we are interested by iEntity or not
    -- =====================================================

    local userinput = iEntity:GetComponentByName( "userinput" )

    if userinput then
        table.insert( self.mEntityGroup, iEntity )
        table.insert( iEntity.mObserverSystems, self )
    end

end


function InputConverter:Update( iDT )

end


function  InputConverter:Draw( iCamera )

end


-- ==========================================Type


function InputConverter:Type()
    return "InputConverter"
end


-- EVENTS : =================================================================================


function InputConverter:KeyPressed( iKey, iScancode, iIsRepeat )

    for i = 1, #self.mEntityGroup do

        local userInput = self.mEntityGroup[ i ]:GetComponentByName( "userinput" )
        local action = Shortcuts.GetActionForKey( iKey )
        userInput.mActions[ action ] = "pending"

    end

end


function InputConverter:KeyReleased( iKey, iScancode )

    local action = Shortcuts.GetActionForKey( iKey )
    for i = 1, #self.mEntityGroup do

        local userInput = self.mEntityGroup[ i ]:GetComponentByName( "userinput" )
        userInput.mActions[ action ] = nil

    end

end


return  InputConverter
