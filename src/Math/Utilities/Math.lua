--[[=================================================================== 
    File: Math.Math.lua

    @@@@: This is the Math Module.
    A module is a Global Singleton Objects that will act like a
    namespace. See Base.Module.lua for more details.

===================================================================--]]

-- INCLUDES ===========================================================
local Module = require "src/Base/Module"

-- MODULE INITIALISATION ==============================================
local Math = {}
setmetatable( Math, Module )
Module.__index = Module

function Math:Initialize()
    local newMath = {}
    setmetatable( newMath, self )
    self.__index = self
    
    -- Init module members
    newMath.name = "Math";
    newMath.PI = 3.14159265359

    return newMath

end

-- MODULE FUNCTIONS ===================================================
-- Checks if the type of input Value is number
function Math:IsANumber( iValue )
    return type( iValue ) == "number"

end



-- Clamp input Value within given range
function Math:Clamp( iValue, iMin, iMax)
    if( Math:IsANumber( iValue ) and Math:IsANumber( iMin ) and Math:IsANumber( iMax ) ) then
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



-- Compute the distance beetween two points
function Math:Distance( iX1, iY1, iX2, iY2) 
    local dx = iX2 - iX1;
    local dy = iY2 - iY1;
    return math.sqrt( ( dx * dx ) + ( dy * dy ) );

end

-- RETURN CHUNK AS GLOBAL OBJECT ======================================
return Math
