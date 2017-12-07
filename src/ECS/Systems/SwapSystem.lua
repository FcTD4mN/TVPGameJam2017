local SystemBase = require( "src/ECS/Systems/SystemBase" )

local  SwapSystem = {}
setmetatable( SwapSystem, SystemBase )
SystemBase.__index = SystemBase


function  SwapSystem:Initialize()

    self.mEntityGroup = {}
    self.mUserInputs ={}
    self.mSwapables ={}

end


function  SwapSystem:EntityAdded( iEntity )

    local userinput = iEntity:GetComponentByName( "userinput" )

    if userinput then
        table.insert( self.mUserInputs, iEntity )
    end
    if iEntity:GetTagByName( "swapable" ) == "1" then
        table.insert( self.mSwapables, iEntity )
    end

end

function  SwapSystem:EntityLost( iEntity )

    local index = GetObjectIndexInTable( self.mUserInputs, iEntity )
    local index2 = GetObjectIndexInTable( self.mSwapables, iEntity )

    if( index > -1 ) then
        table.remove( self.mUserInputs, index )
    end
    if (index2 > -1 ) then
        table.remove( self.mSwapables, index )
    end

end


function SwapSystem:Requirements()

    local requirements = {}
    table.insert( requirements, "userinput" )

    return  unpack( requirements )

end


function SwapSystem:WatchOver()

    local watching = {}
    table.insert( watching, "swapable" )

    return  unpack( watching )

end


function SwapSystem:Update( iDT )

    for i = 1, #self.mUserInputs do

        local userinput = self.mUserInputs[ i ]:GetComponentByName( "userinput" )
        if GetObjectIndexInTable( userinput.mActions, "swapCanKill" ) > -1 then

            for j = 1, #self.mSwapables do

                local swapable = self.mSwapables[ j ]
                if swapable:GetTagByName( "canKill" ) == "1" then
                    swapable:RemoveTag( "canKill" )
                else
                    swapable:AddTag( "canKill" )
                end

            end

            break
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
