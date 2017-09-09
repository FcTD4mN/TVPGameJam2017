--[[=================================================================== 
    File: Graphics.FX.FX.lua

    @@@@: Base for FX Ojects.
    An FX is a wrapper around a shader which can hold information about
    his shader. It takes care about sending values to GPU when needed
    and each FX can have a Rendering subtleties.

===================================================================--]]

-- INCLUDES ===========================================================
-- NONE

-- OBJECT INITIALISATION ==============================================
local FX = {};

function FX:New()
    newFX = {}
    setmetatable( newFX, self );
    self.__index = self;

    newFX.name = "Default";

    return  newFX;

end

-- OBJECT FUNCTIONS ===================================================
function FX:Type()
    return "FX"
end

-- RETURN CHUNK AS GLOBAL OBJECT ======================================
return FX
