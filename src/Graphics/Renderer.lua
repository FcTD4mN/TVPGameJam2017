--[[=================================================================== 
    File: Graphics.Renderer.lua

    @@@@: Global Singleton Renderer.
    Centralized Rendering, wrapper around love draw functions,
    You can set / get these from outside:
        Renderer
        Camera
    ( These shouldn't be used in other contexts )

    All draw calls are directed to an offscreen buffer ( canvas )
    untile Render() is called.

    Renderer Should be a global object.
    Renderer:Clear() and Renderer:Render() should only be called in 
    Screen*:DrawToScreen() functions.

===================================================================--]]

-- INCLUDES ===========================================================
-- NONE

-- OBJECT INITIALISATION ==============================================
local Renderer = {};

function Renderer:New()
    newRenderer = {}
    setmetatable( newRenderer, self );
    self.__index = self;

    newRenderer.FXStack = nil;
    newRenderer.Camera  = nil;

    return  newRenderer;

end

-- OBJECT FUNCTIONS ===================================================
function Renderer:Type()
    return "Renderer"
end

-- Getter / Setter For Current FX
function Renderer:FXStack( iFXStack )
    if( iFXStack == nil ) then
        return self.FXStack;
    else
        self.FXStack = iFXStack;
    end
end

-- Getter / Setter For Current Camera
function Renderer:Camera( iCamera )
    if( iCamera == nil ) then
        return self.Camera;
    else
        self.Camera = iCamera;
    end
end

-- Clear offscreen buffer
function Renderer:Clear()
end

-- Render To Screen
function Renderer:Render()
end 

-- Render To Another OffScreenBuffer
function Renderer:RenderToTarget( iBuffer )
end 

-- RETURN CHUNK AS GLOBAL OBJECT ======================================
return Renderer
