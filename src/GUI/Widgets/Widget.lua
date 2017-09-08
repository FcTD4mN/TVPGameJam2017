ColorRGBA = require("src/Image/ColorRGBA");
require("src/Math/Utilities");
require("src/Base/Utilities");
require("src/Image/Utilities");

local Widget = {};

function Widget:New( iParent, iX, iY, iW, iH, iBGColor)
    newWidget = {}
    setmetatable( newWidget, self );
    self.__index = self;
    self:Initialize();

    shader = love.graphics.newShader("resources/Shaders/shader.fs")

    --shader:send("size", {200, 200})
    --shader:send("hstep", 1); 
    --shader:send("vstep", 1); 

    newWidget.parent    = ValidParameter( iParent, "Widget", nil );
    newWidget.x         = ValidParameter( iX, "number", 0 );
    newWidget.y         = ValidParameter( iY, "number", 0 );
    newWidget.w         = ValidParameter( iW, "number", 0 );
    newWidget.h         = ValidParameter( iH, "number", 0 );
    newWidget.iBGColor  = ValidParameter( iBGColor, "ColorRGBA", ColorRGBA:New( 255, 255, 255 ) );

    newWidget.z_index   = 0;

    newWidget.dropShadowSize    = 12;
    newWidget.dropShadowQuality = 2;
    newWidget.dropShadowShiftX  = newWidget.dropShadowSize / 2 + 1;
    newWidget.dropShadowShiftY  = newWidget.dropShadowSize / 3 + 1;
    newWidget.dropShadowOpacity = 0.9;
    newWidget.borderRadius      = 2;
    newWidget.opacity           = 1;
    
    newWidget.dropShadowImageData = love.image.newImageData(    newWidget.w + ( newWidget.dropShadowSize * 2 ), 
                                                                newWidget.h + ( newWidget.dropShadowSize * 2 ) );
    newWidget.dropShadowImageData = Fill( newWidget.dropShadowImageData, ColorRGBA:New( 0, 0, 0, 0 ) );
    newWidget.dropShadowImageData = DrawFilledRoundedRectangleAA(   newWidget.dropShadowImageData, 
                                                                    newWidget.dropShadowSize, 
                                                                    newWidget.dropShadowSize, 
                                                                    newWidget.w + ( newWidget.dropShadowSize * 0 ) - 1, 
                                                                    newWidget.h + ( newWidget.dropShadowSize * 0 ) - 1, 
                                                                    newWidget.borderRadius, 
                                                                    W_COLOR_SHADOW );
    newWidget.dropShadowImageData = BoxBlur3(   newWidget.dropShadowImageData, 
                                                newWidget.dropShadowSize / newWidget.dropShadowQuality, 
                                                newWidget.dropShadowQuality);

    newWidget.dropShadowImage = love.graphics.newImage( newWidget.dropShadowImageData )

    newWidget.imageData = love.image.newImageData( newWidget.w, newWidget.h )
    newWidget.imageData = Fill( newWidget.imageData, ColorRGBA:New( 0, 0, 0, 0 ) );
    newWidget.imageData = DrawFilledRoundedRectangleAA( newWidget.imageData, 0, 0, newWidget.w - 1, newWidget.h - 1, newWidget.borderRadius, W_COLOR_FILL );
    newWidget.imageData = DrawOutlineRoundedRectangleAA( newWidget.imageData, 0, 0, newWidget.w - 1, newWidget.h - 1, newWidget.borderRadius, W_COLOR_OUTLINE );

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

    love.graphics.setShader(shader)

    love.graphics.setColor(255,255,255,255 * self.opacity * self.dropShadowOpacity);
    love.graphics.draw( self.dropShadowImage, self.x - self.dropShadowShiftX, self.y - newWidget.dropShadowShiftY )



    love.graphics.setColor(255,255,255,255 * self.opacity );
    love.graphics.draw( self.image, self.x, self.y )

    
    love.graphics.setShader()
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