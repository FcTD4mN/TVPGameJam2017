
local SystemBase = {
    mEntityGroup = {}
}


function SystemBase:RemoveEntity( iEntity )

    local index = GetObjectIndexInTable( self.mEntityGroup, iEntity )
    if index > 0 then
        table.remove( self.mEntityGroup, index )
    end

end


function  SystemBase:EntityAdded( iEntity )

end


function  SystemBase:EntityLost( iEntity )

end


function SystemBase:WatchOver()

    local watching = {}
    return  unpack( watching )

end


-- ==========================================Type


function SystemBase:Type()
    return "SystemBase"
end


-- EVENTS : =================================================================================


function SystemBase:KeyPressed( iKey, iScancode, iIsRepeat )
    --Nothing
end


function SystemBase:KeyReleased( iKey, iScancode )
    --Nothing
end



return SystemBase

