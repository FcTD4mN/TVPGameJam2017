local SystemBase = require( "src/ECS/Systems/SystemBase" )
local Shortcuts = require( "src/Application/Shortcuts" )

local  InputConverter = {}
setmetatable( InputConverter, SystemBase )
SystemBase.__index = SystemBase


function  InputConverter:Initialize()

    self.mEntityGroup = {}

end


function InputConverter:Requirements()

    local requirements = {}
    table.insert( requirements, "userinput" )

    return  unpack( requirements )

end


function InputConverter:Update( iDT )

end


function  InputConverter:Draw( iCamera )

    local userInput = self.mEntityGroup[ i ]:GetComponentByName( "userinput" )
    print( userInput.mActions )

end


-- ==========================================Type


function InputConverter:Type()
    return "InputConverter"
end


-- EVENTS : =================================================================================


function InputConverter:KeyPressed( iKey, iScancode, iIsRepeat )

    for i = 1, #self.mEntityGroup do

        local userInput = self.mEntityGroup[ i ]:GetComponentByName( "userinput" )
        table.insert( userInput.mActions , Shortcuts:GetActionForKey( iKey ) )

    end

end


function InputConverter:KeyReleased( iKey, iScancode )

    local action = Shortcuts:GetActionForKey( iKey )
    for i = 1, #self.mEntityGroup do

        local userInput = self.mEntityGroup[ i ]:GetComponentByName( "userinput" )
        for i = 1, #userInput.mActions do

            if( userInput.mActions[ i ] == action )
                table.remove( userInput.mActions, i )

        end

    end

end


return  InputConverter
