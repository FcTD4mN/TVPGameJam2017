ColorRGBA = require("src/Image/ColorRGBA");

local Widget = {};

function Widget:New( iParent, iX, iY, iW, iH, iBGColor)
    newWidget = {}
    setmetatable( newWidget, self );
    self.__index = self;
    self:Initialize();

    shader_boxBlurH = love.graphics.newShader("resources/Shaders/BoxBlurHorizontal.fs")
    shader_boxBlurV = love.graphics.newShader("resources/Shaders/BoxBlurVertical.fs")

    newWidget.parent    = Base:ValidParameter( iParent, "Widget", nil );
    newWidget.x         = Base:ValidParameter( iX, "number", 0 );
    newWidget.y         = Base:ValidParameter( iY, "number", 0 );
    newWidget.w         = Base:ValidParameter( iW, "number", 0 );
    newWidget.h         = Base:ValidParameter( iH, "number", 0 );
    newWidget.iBGColor  = Base:ValidParameter( iBGColor, "ColorRGBA", ColorRGBA:New( 255, 255, 255 ) );

    newWidget.z_index   = 0;

    newWidget.dropShadowSize    = 90;
    newWidget.dropShadowQuality = 2;
    newWidget.dropShadowShiftX  = newWidget.dropShadowSize / 2 + 1;
    newWidget.dropShadowShiftY  = newWidget.dropShadowSize / 3 + 1;
    newWidget.dropShadowOpacity = 0.9;
    newWidget.borderRadius      = 2;
    newWidget.opacity           = 1;
    
    newWidget.dropShadowImageData = love.image.newImageData(    newWidget.w + ( newWidget.dropShadowSize * 2 ), 
                                                                newWidget.h + ( newWidget.dropShadowSize * 2 ) );
    newWidget.dropShadowImageData = Image2:Fill( newWidget.dropShadowImageData, ColorRGBA:New( 0, 0, 0, 0 ) );
    newWidget.dropShadowImageData = Image2:DrawFilledRoundedRectangleAA(   newWidget.dropShadowImageData, 
                                                                    newWidget.dropShadowSize, 
                                                                    newWidget.dropShadowSize, 
                                                                    newWidget.w + ( newWidget.dropShadowSize * 0 ) - 1, 
                                                                    newWidget.h + ( newWidget.dropShadowSize * 0 ) - 1, 
                                                                    newWidget.borderRadius, 
                                                                    W_COLOR_SHADOW );

                                                                    
    shader_boxBlurH:send("radius", newWidget.dropShadowSize);
    shader_boxBlurV:send("radius", newWidget.dropShadowSize);

    --[[newWidget.dropShadowImageData = BoxBlur3(   newWidget.dropShadowImageData, 
                                                newWidget.dropShadowSize / newWidget.dropShadowQuality, 
                                                newWidget.dropShadowQuality);--]]

    newWidget.dropShadowImage = love.graphics.newImage( newWidget.dropShadowImageData )

    newWidget.imageData = love.image.newImageData( newWidget.w, newWidget.h )
    newWidget.imageData = Image2:Fill( newWidget.imageData, ColorRGBA:New( 0, 0, 0, 0 ) );
    newWidget.imageData = Image2:DrawFilledRoundedRectangleAA( newWidget.imageData, 0, 0, newWidget.w - 1, newWidget.h - 1, newWidget.borderRadius, W_COLOR_FILL );
    newWidget.imageData = Image2:DrawOutlineRoundedRectangleAA( newWidget.imageData, 0, 0, newWidget.w - 1, newWidget.h - 1, newWidget.borderRadius, W_COLOR_OUTLINE );

    newWidget.image = love.graphics.newImage( newWidget.imageData )

    return  newWidget;

end

function Widget:Type()
    return "Widget"
end

function Widget:Initialize()
end

function Widget:Update( dt )
end

function Widget:Draw()

    love.graphics.setShader(shader_boxBlurH);
    shader_boxBlurH:send("size", { self.dropShadowImageData:getWidth(), self.dropShadowImageData:getHeight() } );

    local tmpBuffer = love.graphics.newCanvas( self.dropShadowImageData:getWidth(), self.dropShadowImageData:getHeight() );
    love.graphics.setCanvas( tmpBuffer );
        love.graphics.clear();
        love.graphics.setBlendMode("alpha");
        love.graphics.setColor(255, 255, 255, 255 );

    love.graphics.draw( self.dropShadowImage );
    love.graphics.setCanvas();

    love.graphics.setShader(shader_boxBlurV);
    shader_boxBlurV:send("size", { self.w, self.h } );
    love.graphics.setColor(255, 255, 255, 255 * self.dropShadowOpacity * self.opacity );
    love.graphics.draw( tmpBuffer, self.x - self.dropShadowShiftX, self.y - newWidget.dropShadowShiftY );
    
    love.graphics.setShader();
    
    love.graphics.setColor(255,255,255,255 * self.opacity );
    love.graphics.draw( self.image, self.x, self.y );
end

function Widget:KeyPressed( key, scancode, isrepeat )
end

function Widget:KeyReleased( key, scancode )
end

function Widget:mousepressed( iX, iY, iButton, iIsTouch )
end

function Widget:Finalize()
end 

return Widget