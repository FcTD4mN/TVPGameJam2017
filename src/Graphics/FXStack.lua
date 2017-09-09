--[[=================================================================== 
    File: Graphics.FXStack.lua

    @@@@: An FXStack to automatize rendering with FX.
    Automatized Shader Multiple Pass and offscreen rendering.

===================================================================--]]

-- INCLUDES ===========================================================
-- NONE

-- OBJECT INITIALISATION ==============================================
local FXStack = {};

function FXStack:New()
    newFXStack = {}
    setmetatable( newFXStack, self );
    self.__index = self;

    return  newFXStack;

end

-- OBJECT FUNCTIONS ===================================================
function FXStack:PushFX( iFX )
    
end

function FXStack:PopFX()
end

function FXStack:ClearStack()
end

function FXStack:Render()
end 

-- RETURN CHUNK AS GLOBAL OBJECT ======================================
return FXStack