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