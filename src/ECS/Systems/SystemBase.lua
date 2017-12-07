
local SystemBase = {
    mEntityGroup = {}
}


function  SystemBase:EntityLost( iEntity )

    local index = GetObjectIndexInTable( self.mEntityGroup, iEntity )

    if index > 0 then
        table.remove( self.mEntityGroup, index )
    end

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

