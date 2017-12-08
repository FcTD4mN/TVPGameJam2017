local SystemBase = require( "src/ECS/Systems/SystemBase" )

local  SwapSystem = {}
setmetatable( SwapSystem, SystemBase )
SystemBase.__index = SystemBase


function  SwapSystem:Initialize()

    self.mEntityGroup = {}
    self.mUserInputs = nil
    self.mSwapables = {}

end


function SwapSystem:IncomingEntity( iEntity )

    local userinput = iEntity:GetComponentByName( "userinput" )

    if userinput and self.mUserInputs == nil then
        self.mUserInputs = iEntity
        table.insert( iEntity.mObserverSystems, self )
    end
    if iEntity:GetTagByName( "swapable" ) == "1" then
        table.insert( self.mSwapables, iEntity )
        table.insert( iEntity.mObserverSystems, self )
    end

end


function  SwapSystem:EntityLost( iEntity )

    local index = GetObjectIndexInTable( self.mSwapables, iEntity )

    if self.mUserInputs == iEntity then
        self.mUserInputs = nil
    end
    if( index > -1 ) then
        table.remove( self.mSwapables, index )
    end

end


function SwapSystem:Update( iDT )

    local swapablesCountAtInstant = #self.mSwapables
    if swapablesCountAtInstant == 0 then
        return
    end

    if( self.mUserInputs ) then

        local userinput = self.mUserInputs:GetComponentByName( "userinput" )

        if GetObjectIndexInTable( userinput.mActions, "swapCanKill" ) > -1 then
            for j = 1, swapablesCountAtInstant do

                local swapable = self.mSwapables[ 1 ]
                if swapable:GetTagByName( "canKill" ) == "1" then
                    swapable:RemoveTag( "canKill" )
                else
                    swapable:AddTag( "canKill" )
                end

            end
        end

    end


end


function  SwapSystem:Draw( iCamera )

end


-- ==========================================Type


function SwapSystem:Type()
    return "SwapSystem"
end


return  SwapSystem
