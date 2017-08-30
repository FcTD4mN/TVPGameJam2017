local Camera    = require "src/Camera/Camera"

local ObjectPool = {
    objects = {}
}


-- ==========================================Type


function ObjectPool.Type()
    return "ObjectPool"
end


-- ==========================================Update/Draw


function ObjectPool.Update( iDT )
    for k, v in pairs( ObjectPool.objects ) do
        if( v.needDestroy ) then
            v:Finalize()
            table.remove( ObjectPool.objects, k )
        else
            v:Update( iDT )
        end
    end
end


function ObjectPool.Draw()
    for k, v in pairs( ObjectPool.objects ) do
        v:Draw( iDT )
    end
end


-- ==========================================Pool actions

function  ObjectPool.AddObject( iObject )
    table.insert( ObjectPool.objects, iObject )
end


return ObjectPool