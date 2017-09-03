--[[=================================================================== 
    File: Image.Utilities.lua
    @@@@: Basic handy methods for images
===================================================================--]]

-- INCLUDES ===========================================================
ColorRGBA = require("src/Image/ColorRGBA");
require("src/Math/Utilities");
require("src/Base/Utilities");

-- FUNCTIONS ==========================================================

function Fill( iImageData, iColor )
    for i=0, iImageData:getWidth()-1, 1 do
        for j=0, iImageData:getHeight()-1, 1 do
            iImageData:setPixel( i, j, iColor:Red(), iColor:Green(), iColor:Blue(), iColor:Alpha() );
        end
    end

    return  iImageData;
end



function Clear( iImageData )
    return  Fill( iImageData, ColorRGBA:New(0, 0, 0, 0) );
end



function DrawRectangle( iImageData, iX, iY, iW, iH, iColor )
    for i=iX, iX + iW, 1 do
        for j=iY, iY + iH, 1 do
            iImageData:setPixel( i, j, iColor:Red(), iColor:Green(), iColor:Blue(), iColor:Alpha() );
        end
    end

    return  iImageData;
end



function DrawHorizontalLine( iImageData, iY, iColor )
    for i=0, iImageData:getWidth()-1, 1 do
        iImageData:setPixel( i, iY, iColor:Red(), iColor:Green(), iColor:Blue(), iColor:Alpha() );
    end

    return  iImageData;
end



function DrawVerticalLine( iImageData, iX, iColor )
    for i=0, iImageData:getHeight()-1, 1 do
        iImageData:setPixel( iX, i, iColor:Red(), iColor:Green(), iColor:Blue(), iColor:Alpha() );
    end

    return  iImageData;
end



function DrawLine( iImageData, iX1, iY1, iX2, iY2, iColor )

    local dx = iX2 - iX1;
    local dy = iY2 - iY1;
    local epsilon = 0.001;

    if( math.abs( dx ) < epsilon ) then    return  DrawVerticalLine( iImageData, iY1, iColor );  end
    if( math.abs( dy ) < epsilon ) then    return  DrawHorizontalLine( iImageData, iX1, iColor );    end

    s = dy / dx;
    c = iY2 - ( s * iX2 );

    if( math.abs( s ) <= 1 ) then
        for i = math.min( iX1, iX2 ), math.max( iX1, iX2 ) do
            local yR = ( s * i ) + c;
            iImageData:setPixel( i, yR, iColor:Red(), iColor:Green(), iColor:Blue(), iColor:Alpha() );
        end
    else
        for i = math.min( iY1, iY2 ), math.max( iY1, iY2 ) do
            local xR = ( i - c ) / s;
            iImageData:setPixel( xR, i, iColor:Red(), iColor:Green(), iColor:Blue(), iColor:Alpha() );
        end
    end
    return iImageData;
end


function DrawLineAA( iImageData, iX1, iY1, iX2, iY2, iColor )

    local dx = iX2 - iX1;
    local dy = iY2 - iY1;
    local epsilon = 0.001;

    if( math.abs( dx ) < epsilon ) then    return  DrawVerticalLine( iImageData, iY1, iColor );  end
    if( math.abs( dy ) < epsilon ) then    return  DrawHorizontalLine( iImageData, iX1, iColor );    end

    s = dy / dx;
    c = iY2 - ( s * iX2 );

    if( math.abs( s ) <= 1 ) then
        for i = math.min( iX1, iX2 ), math.max( iX1, iX2 ) do
            local yR = ( s * i ) + c;
            local yI = math.floor( yR );
            local delta = yR - yI;
            local delta2 = 1 - delta;
            
            if( delta == 0 ) then
                iImageData:setPixel( i, yR, iColor:Red(), iColor:Green(), iColor:Blue(), iColor:Alpha() );
            else

                r, g, b, a = iImageData:getPixel( i, yI )
                r1, g1, b1, a1 = iImageData:getPixel( i, yI + 1 )

                iImageData:setPixel( i, yI+1, iColor:Red(), iColor:Green(), iColor:Blue(), iColor:Alpha() * delta );
                iImageData:setPixel( i, yI, iColor:Red(), iColor:Green(), iColor:Blue(), iColor:Alpha() * delta2 );
            end
        end
    else
        for i = math.min( iY1, iY2 ), math.max( iY1, iY2 ) do
            local xR = ( i - c ) / s;
            local xI = math.floor( xR );
            local delta = xR - xI;
            local delta2 = 1 - delta;

            if( delta == 0 ) then
                iImageData:setPixel( xR, i, iColor:Red(), iColor:Green(), iColor:Blue(), iColor:Alpha() );
            else

                r, g, b, a = iImageData:getPixel( xI, i )
                r1, g1, b1, a1 = iImageData:getPixel( xI + 1, i )

                iImageData:setPixel( xI+1, i, iColor:Red(), iColor:Green(), iColor:Blue(), iColor:Alpha() * delta );
                iImageData:setPixel( xI, i, iColor:Red(), iColor:Green(), iColor:Blue(), iColor:Alpha() * delta2 );
            end
        end
    end
    return iImageData;
end