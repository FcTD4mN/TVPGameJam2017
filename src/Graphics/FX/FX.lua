--[[=================================================================== 
    File: Graphics.FX.FX.lua

    @@@@: Base for FX Ojects.
    Do not use this file.
    An FX is a wrapper around a shader which can hold information about
    his shader. It takes care about sending values to GPU when needed
    and each FX can have its own Rendering subtleties.

===================================================================--]]

-- INCLUDES ===========================================================
local Uniform = require( "src/Graphics/Uniform" );

-- OBJECT INITIALISATION ==============================================
local FX = {};

function FX:New()
    newFX = {}
    setmetatable( newFX, self );
    self.__index = self;

    newFX.name = "Default";
    newFX.shader = nil;
    newFX.uniforms = {};

    return  newFX;

end

-- OBJECT FUNCTIONS ===================================================
function FX:Type()
    return "FX"
end

function FX:SetUniformValue( iName, iValue )
    if self.uniforms == nil then
        self.uniforms = {}
    end

    for i=1, #self.uniforms, 1 do
        if self.uniforms[i].name ==iName then
            self.uniforms[i].value = iValue;
            self.shader:send( self.uniforms[i].name, 
                              self.uniforms[i].value );
            return;
        end
    end

    self.uniforms[0] = Uniform:New( iName, iValue );
end

function FX:GetUniformValue( iName )
    for i=1, #self.uniforms, 1 do
        if self.uniforms[i].name == iName then
            return self.uniforms[i].value;
        end
    end
end

-- RETURN CHUNK AS GLOBAL OBJECT ======================================
return FX
