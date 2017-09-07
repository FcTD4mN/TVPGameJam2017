
-- This class just registers rays, it will call updates + draws


local RayPool = {
    rays = {}
}


-- ==========================================Type


function RayPool.Type()
    return "RayPool"
end


-- ==========================================Update/Draw


function RayPool.Update( iDT )

    for k, v in pairs( RayPool.rays ) do
        v:Update( iDT )
    end

end


function RayPool.Draw( iCamera )
    for k, v in pairs( RayPool.rays ) do
        v:Draw( iCamera )
    end
end


-- ==========================================Get/Set


function RayPool.Count()
    return #RayPool.rays
end


function RayPool.RayAtIndex( iIndex )
    return  RayPool.rays[ iIndex ]
end


-- ==========================================Pool actions


function  RayPool.AddRay( iRay )
    table.insert( RayPool.rays, iRay )
end


return RayPool