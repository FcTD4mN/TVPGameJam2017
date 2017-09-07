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
        if( v.mNeedDestroy ) then
            v:Finalize()
            table.remove( ObjectPool.objects, k )
        else
            v:Update( iDT )
        end
    end
end


function ObjectPool.Draw( iCamera )
    for k, v in pairs( ObjectPool.objects ) do
        v:Draw( iCamera )
    end
end


function ObjectPool.DrawToMiniMap( iCamera )
    for k, v in pairs( ObjectPool.objects ) do
        v:DrawToMiniMap( iCamera )
    end
end


-- ==========================================Get/Set


function ObjectPool.Count()
    return #ObjectPool.objects
end


function ObjectPool.ObjectAtIndex( iIndex )
    return  ObjectPool.objects[ iIndex ]
end


-- ==========================================Pool actions


function  ObjectPool.AddObject( iObject )
    table.insert( ObjectPool.objects, iObject )
end


return ObjectPool