require("src/Math/Utilities");

local ColorRGBA = {};

-- Constructor
function ColorRGBA:New( iR, iG, iB, iA )
    newColorRGBA = {}
    setmetatable( newColorRGBA, self );
    self.__index = self;

    -- Default Values
    newColorRGBA.R         = Clamp( iR, 0, 255 ) or 0;
    newColorRGBA.G         = Clamp( iG, 0, 255 ) or 0;
    newColorRGBA.B         = Clamp( iB, 0, 255 ) or 0;
    newColorRGBA.A         = Clamp( iA, 0, 255 ) or 255;

    return  newColorRGBA;

end

-- Red Getter / Setter 
function ColorRGBA:Red( iValue )
    if( iValue == nil ) then
        return self.R;
    else
        self.R = Clamp( iValue, 0, 255 );
    end

end

-- Green Getter / Setter
function ColorRGBA:Green( iValue )
    if( iValue == nil ) then
        return self.G;
    else
        self.G = Clamp( iValue, 0, 255 );
    end

end

-- Blue Getter / Setter
function ColorRGBA:Blue( iValue )
    if( iValue == nil ) then
        return self.B;
    else
        self.B = Clamp( iValue, 0, 255 );
    end

end

-- Alpha Getter / Setter
function ColorRGBA:Alpha( iValue )
    if( iValue == nil ) then
        return self.A;
    else
        self.A = Clamp( iValue, 0, 255 );
    end

end

-- Type Getter
function ColorRGBA:Type()
    return "ColorRGBA"

end

return ColorRGBA