--[[=================================================================== 
    File: Graphics.FX.FX_BoxBlurHorizontal.lua

    @@@@: A Simple Single Pass Horizontal Box Blur Shader.
    Low quality, fast computation.

===================================================================--]]

-- INCLUDES ===========================================================
local FX        = require( "src/Graphics/FX/FX" );

-- OBJECT INITIALISATION ==============================================
local FX_BoxBlurHorizontal = {}
setmetatable( FX_BoxBlurHorizontal, FX )
FX.__index = FX

-- Constructor
function FX_BoxBlurHorizontal:New( iRadius )
    newFX_BoxBlurHorizontal = {}
    setmetatable( newFX_BoxBlurHorizontal, self );
    self.__index = self;

    newFX_BoxBlurHorizontal.name = "FX_BoxBlurHorizontal";
    newFX_BoxBlurHorizontal.shader = love.graphics.newShader("resources/Shaders/BoxBlurHorizontal.fs");
                  
    newFX_BoxBlurHorizontal:SetUniformValue( "size", { 30, 30 } );
    newFX_BoxBlurHorizontal:SetUniformValue( "radius", Base:ValidParameter( iRadius, "number", 15 ) );

    return  newFX_BoxBlurHorizontal;

end

-- OBJECT FUNCTIONS ===================================================
function FX_BoxBlurHorizontal:Render( iImage )
    love.graphics.setShader( self.shader );
    self:SetUniformValue( "size", { iImage:getWidth(), iImage:getHeight() } );
    
    local tmpBuffer = love.graphics.newCanvas( iImage:getWidth(), iImage:getHeight() );
    love.graphics.setCanvas( tmpBuffer );
    love.graphics.clear();
    love.graphics.setBlendMode("alpha");
    love.graphics.setColor(255, 255, 255, 255 );

    love.graphics.draw( iImage );
    love.graphics.setCanvas();

    return tmpBuffer;

end

-- RETURN CHUNK AS GLOBAL OBJECT ======================================
return FX_BoxBlurHorizontal;
