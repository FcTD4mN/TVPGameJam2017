
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


function SystemBase:TextInput( iT )
    --Nothing
end


function SystemBase:KeyPressed( iKey, iScancode, iIsRepeat )
    --Nothing
end


function SystemBase:KeyReleased( iKey, iScancode )
    --Nothing
end


function SystemBase:MousePressed( iX, iY, iButton, iIsTouch )
    --Nothing
end


function SystemBase:MouseMoved( iX, iY )
    --Nothing
end


function SystemBase:MouseReleased( iX, iY, iButton, iIsTouch )
    --Nothing
end


function SystemBase:WheelMoved( iX, iY )
    --Nothing
end



return SystemBase

