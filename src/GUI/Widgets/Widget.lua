ColorRGBA = require("src/Image/ColorRGBA")
require("src/Math/Utilities");

local Widget = {};

function Widget:New( iParent, iX, iY, iW, iH, iBGColor)
    newWidget = {}
    setmetatable( newWidget, self );
    self.__index = self;
    self:Initialize();

    -- Check Values / Default Values
    if( iParent ) then
        if( iParent:Type() == "Widget" ) then
            newWidget.parent = iParent;
        else
            print("Error: given argument iParent in Widget:New is not a Widget !")
            newWidget.parent = nil;
        end
    else
        print("Error: given argument iParent in Widget:New is invalid ( nil ) !")
        newWidget.parent = nil
    end

    if( iX ) then
        if( IsANumber( iX ) ) then
            newWidget.x = iX;
        else
            print("Error: given argument iX in Widget:New is not a Number !")
            newWidget.x = 0;
        end
        print("Error: given argument iX in Widget:New is invalid ( nil )!")
        newWidget.x = 0;
    else

    end
    newWidget.x         = iX or 0;
    newWidget.y         = iY or 0;
    newWidget.w         = iW or 1;
    newWidget.h         = iH or 1;

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