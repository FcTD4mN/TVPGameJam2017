
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
    return  false
end


function SystemBase:KeyPressed( iKey, iScancode, iIsRepeat )
    return  false
end


function SystemBase:KeyReleased( iKey, iScancode )
    return  false
end


function SystemBase:MousePressed( iX, iY, iButton, iIsTouch )
    return  false
end


function SystemBase:MouseMoved( iX, iY )
    return  false
end


function SystemBase:MouseReleased( iX, iY, iButton, iIsTouch )
    return  false
end


function SystemBase:WheelMoved( iX, iY )
    return  false
end



return SystemBase

