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



function DrawFilledRectangle( iImageData, iX, iY, iW, iH, iColor )
    for i=iX, iX + iW, 1 do
        for j=iY, iY + iH, 1 do
            iImageData:setPixel( i, j, iColor:Red(), iColor:Green(), iColor:Blue(), iColor:Alpha() );
        end
    end

    return  iImageData;
end



function DrawFilledCircle( iImageData, iX, iY, iRadius, iColor )
    local xmin = iX - iRadius;
    local xmax = iX + iRadius;
    local ymin = iY - iRadius;
    local ymax = iY + iRadius;

    for i=xmin, xmax, 1 do
        for j=ymin, ymax, 1 do
            if( Distance( i, j, iX, iY ) < iRadius ) then        
                iImageData:setPixel( i, j, iColor:Red(), iColor:Green(), iColor:Blue(), iColor:Alpha() );
            end
        end
    end

    return  iImageData;
end



function DrawFilledCircleAA( iImageData, iX, iY, iRadius, iColor )
    local xmin = iX - iRadius;
    local xmax = iX + iRadius;
    local ymin = iY - iRadius;
    local ymax = iY + iRadius;
    local superSampling = 4;
    local step = 1 / superSampling;

    for i=xmin, xmax, step do

        local xI = math.floor( i );
        local deltaX  = i - xI;
        local deltaX2 = 1 - deltaX;

        for j=ymin, ymax, step do
            if( Distance( i, j, iX, iY ) < iRadius ) then
                
                local yI = math.floor( j );
                local deltaY  = j - yI;
                local deltaY2 = 1 - deltaY;
                
                iImageData:setPixel( xI, yI, iColor:Red(), iColor:Green(), iColor:Blue(), iColor:Alpha() * deltaX2 + iColor:Alpha() * deltaY2 );
                
                iImageData:setPixel( xI+1, yI, iColor:Red(), iColor:Green(), iColor:Blue(), iColor:Alpha() * deltaX +iColor:Alpha() * deltaY2 );
               -- iImageData:setPixel( xI, yI+1, iColor:Red(), iColor:Green(), iColor:Blue(), iColor:Alpha() * deltaX2+ iColor:Alpha() * deltaY );
            
               -- iImageData:setPixel( xI-1, yI, iColor:Red(), iColor:Green(), iColor:Blue(), iColor:Alpha() * deltaX + iColor:Alpha() * deltaY2 );
               -- iImageData:setPixel( xI, yI-1, iColor:Red(), iColor:Green(), iColor:Blue(), iColor:Alpha() * deltaX2 + iColor:Alpha() * deltaY );
            end
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



function AlphaBlend( iColorA, iColorB )
    local alpha_A = iColorA:Alpha() / 255;
    local alpha_B = iColorB:Alpha() / 255;
    local factor_B = alpha_B * ( 1 - alpha_A );
    local factor_A = alpha_A + factor_B;

    local R_out = ( iColorA:Red()   * alpha_A + iColorB:Red()    * factor_B ) / factor_A;
    local G_out = ( iColorA:Green() * alpha_A + iColorB:Green()  * factor_B ) / factor_A;
    local B_out = ( iColorA:Blue()  * alpha_A + iColorB:Blue()   * factor_B ) / factor_A;
    local A_out = factor_A * 255;

    return ColorRGBA:New( R_out, G_out, B_out, A_out );

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
                local ir, ig, ib, ia = iImageData:getPixel( i, yI )
                local ir1, ig1, ib1, ia1 = iImageData:getPixel( i, yI + 1 )

                local computedColor = ColorRGBA:New( iColor:Red(), iColor:Green(), iColor:Blue(), iColor:Alpha() * delta2 );       
                local computedColor1 = ColorRGBA:New( iColor:Red(), iColor:Green(), iColor:Blue(), iColor:Alpha() * delta );
                local blended = AlphaBlend( computedColor, ColorRGBA:New( ir, ig, ib, ia ) );
                local blended1 = AlphaBlend( computedColor1, ColorRGBA:New( ir1, ig1, ib1, ia1 ) );

                iImageData:setPixel( i, yI, blended:Red(), blended:Green(), blended:Blue(), blended:Alpha() );
                iImageData:setPixel( i, yI+1, blended1:Red(), blended1:Green(), blended1:Blue(), blended1:Alpha() );
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

                local ir, ig, ib, ia = iImageData:getPixel( xI, i )
                local ir1, ig1, ib1, ia1 = iImageData:getPixel( xI + 1, i )
                
                local computedColor = ColorRGBA:New( iColor:Red(), iColor:Green(), iColor:Blue(), iColor:Alpha() * delta2 );       
                local computedColor1 = ColorRGBA:New( iColor:Red(), iColor:Green(), iColor:Blue(), iColor:Alpha() * delta );
                local blended = AlphaBlend( computedColor, ColorRGBA:New( ir, ig, ib, ia ) );
                local blended1 = AlphaBlend( computedColor1, ColorRGBA:New( ir1, ig1, ib1, ia1 ) );
                
                iImageData:setPixel( xI, i, blended:Red(), blended:Green(), blended:Blue(), blended:Alpha() );
                iImageData:setPixel( xI+1, i, blended1:Red(), blended1:Green(), blended1:Blue(), blended1:Alpha() );
            end
        end
    end
    return iImageData;
end