ColorRGBA = require("src/Image/ColorRGBA")
require("src/Math/Utilities");
require("src/Base/Utilities")

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
    newWidget.iBGColor  = ValidParameter( iBGColor, "ColorRGBA", ColorRGBA:New() );
    print ( newWidget.iBGColor:Type() );
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
    love.graphics.clear( 200, 200, 200, 255 )

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