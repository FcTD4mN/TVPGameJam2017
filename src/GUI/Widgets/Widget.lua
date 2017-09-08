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

    newWidget.parent    = ValidParameter( iParent, "Widget", nil );
    newWidget.x         = ValidParameter( iX, "number", 0 );
    newWidget.y         = ValidParameter( iY, "number", 0 );
    newWidget.w         = ValidParameter( iW, "number", 0 );
    newWidget.h         = ValidParameter( iH, "number", 0 );
    newWidget.iBGColor  = ValidParameter( iBGColor, "ColorRGBA", ColorRGBA:New( 255, 255, 255 ) );

    local red = ColorRGBA:New( 255, 0, 0 );
    local grey = ColorRGBA:New( 35, 35, 35 );
    local dark = ColorRGBA:New( 10, 10, 10 );
    newWidget.imageData = love.image.newImageData( newWidget.w, newWidget.h )
    newWidget.imageData = Fill( newWidget.imageData, ColorRGBA:New( 0, 0, 0, 0 ) );

    newWidget.imageData = DrawFilledRoundedRectangleAA( newWidget.imageData, 20, 20, newWidget.w -41, newWidget.h -41, 5, grey );
    newWidget.imageData = DrawOutlineRoundedRectangleAA( newWidget.imageData, 20, 20, newWidget.w -41, newWidget.h -41, 5, red );
    
    newWidget.imageData = DrawFilledCircleAA( newWidget.imageData, newWidget.w / 2, newWidget.h / 2, 20, red);

    newWidget.imageData = BoxBlur3( newWidget.imageData, 3, 3);


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
    love.graphics.setColor(255,255,255,255);
    love.graphics.draw( self.image, self.x, self.y )
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