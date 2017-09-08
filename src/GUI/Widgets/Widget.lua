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
    local grey = ColorRGBA:New( 60, 60, 60 );
    newWidget.imageData = love.image.newImageData( newWidget.w, newWidget.h )
    newWidget.imageData = Fill( newWidget.imageData, ColorRGBA:New( 0, 0, 0, 0 ) );

    newWidget.imageData = DrawFilledRoundedRectangleAA( newWidget.imageData, 0, 0, newWidget.w -1, newWidget.h -1, 15, grey );
    
    newWidget.imageData = DrawFilledCircleAA( newWidget.imageData, newWidget.w / 2, newWidget.h / 2, 20, red);

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