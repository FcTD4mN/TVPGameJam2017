--[[=================================================================== 
    File: Graphics.Uniform.lua

    @@@@: Uniform Value to send to shader.
    Just a little struct holder...
    name, value

===================================================================--]]

-- INCLUDES ===========================================================
-- NONE

-- OBJECT INITIALISATION ==============================================
local Uniform = {}

function  Uniform:New( iName, iValue )
    newUniform = {}
    setmetatable( newUniform, self )
    self.__index = self

    newUniform.name   = iName;
    newUniform.value  = iValue;

    return  newUniform
end

-- OBJECT FUNCTIONS ===================================================
function Uniform:Type()
    return "Uniform"
end

-- RETURN CHUNK AS GLOBAL OBJECT ======================================
return  Uniform