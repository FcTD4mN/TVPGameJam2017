
local SystemBase = {
    mEntityGroup = {}
}


function SystemBase:RemoveEntity( iEntity )

    local index = GetObjectIndexInTable( self.mEntityGroup, iEntity )
    if index > 0 then
        table.remove( self.mEntityGroup, index )
    end

end


-- ==========================================Type


function SystemBase:Type()
    return "SystemBase"
end



return SystemBase

