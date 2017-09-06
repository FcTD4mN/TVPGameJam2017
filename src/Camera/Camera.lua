
local Camera = {
    x = 0,
    y = 0,
    scale = 1.0 -- == ZoomAmount, scale is equal on X and Y
}


function  Camera.MapToScreen( iX, iY )
    return  ( iX - Camera.x ) * Camera.scale, ( iY - Camera.y ) * Camera.scale
end


-- To interface Box2d
function  Camera.MapToScreenMultiple( ... )
    count = select("#", ... )

    if( count % 2 ~= 0 ) then
        return  0
    end

    results = {}
    for i = 1, count, 2 do
        x = select( i, ... )
        y = select( i + 1, ... )
        x, y = Camera.MapToScreen( x, y )
        table.insert( results, x )
        table.insert( results, y )
    end

    -- return  results
    return  unpack( results )
end


function  Camera.Scale()
    return  Camera.scale
end


function  Camera.MapToWorld( iX, iY )
    return  iX + Camera.x, iY + Camera.y
end


return  Camera