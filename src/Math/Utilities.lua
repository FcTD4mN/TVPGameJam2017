function IsANumber( iValue )
    return type( iValue ) == "number"
end

function Clamp( iValue, iMin, iMax)
    if( IsANumber( iValue ) and IsANumber( iMin ) and IsANumber( iMax ) ) then
        if( iMin < iMax ) then
            if( iValue < iMin ) then iValue = iMin end
            if( iValue > iMax ) then iValue = iMax end
            return iValue;
        else
            return nil;
        end
    end

    return nil;
end

function Distance( iX1, iY1, iX2, iY2) 
    local dx = iX2 - iX1;
    local dy = iY2 - iY1;
    return math.sqrt( ( dx * dx ) + ( dy * dy ) );
end