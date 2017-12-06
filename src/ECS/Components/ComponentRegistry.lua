ComponentRegistry = {
    references = {}
}


function ComponentRegistry.Register( iComponentString, iComponent )

    if ComponentRegistry.references[ iComponentString ] == nil then
        ComponentRegistry.references[ iComponentString ] = iComponent
    end

end


function  ComponentRegistry.CreateFromRegistry( iComponentString, iNode, iWorld, iEntity )

    print( iComponentString )
    for k,v in pairs( ComponentRegistry.references ) do
        if k == iComponentString then
            return  v:NewFromXML( iNode, iWorld, iEntity )
        end
    end

    return  nil

end


return  ComponentRegistry