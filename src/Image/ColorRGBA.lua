--[[=================================================================== 
    File: Image.ColorRGBA.lua

    @@@@: A Small Class Representing RGBA Colors.

===================================================================--]]

-- INCLUDES ===========================================================
-- NONE

-- OBJECT INITIALISATION ==============================================
local ColorRGBA = {};

-- Constructor
function ColorRGBA:New( iR, iG, iB, iA )
    newColorRGBA = {}
    setmetatable( newColorRGBA, self );
    self.__index = self;

    -- Default Values
    newColorRGBA.R         = Math:Clamp( Base:ValidParameter( iR, "number", 0 ), 0, 255 );
    newColorRGBA.G         = Math:Clamp( Base:ValidParameter( iG, "number", 0 ), 0, 255 );
    newColorRGBA.B         = Math:Clamp( Base:ValidParameter( iB, "number", 0 ), 0, 255 );
    newColorRGBA.A         = Math:Clamp( Base:ValidParameter( iA, "number", 255 ), 0, 255 );

    return  newColorRGBA;

end


-- OBJECT FUNCTIONS ===================================================
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

-- RETURN CHUNK AS GLOBAL OBJECT ======================================
return ColorRGBA