ObjectRegistry = {
    references = {}
}


function ObjectRegistry.RegisterXMLCreation( iObjectString, iObject )

    if ObjectRegistry.references[ iObjectString ] == nil then
        ObjectRegistry.references[ iObjectString ] = iObject
    end

end


function  ObjectRegistry.CreateFromRegistry( iObjectString, iNode, iWorld )

    print( iObjectString )

    for k,v in pairs( ObjectRegistry.references ) do
        if k == iObjectString then
            return  v:NewFromXML( iNode, iWorld )
        end
    end

    return  nil

end


return  ObjectRegistry