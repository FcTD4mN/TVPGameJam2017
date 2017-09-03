local Screen = {};

function Screen:New()
    newScreen = {}
    setmetatable( newScreen, self );
    self.__index = self;
    self:Initialize();

    return  newScreen;

end

function Screen:Type()
    return "Screen"
end

function Screen:Initialize()
end

function Screen:Update( dt )    
end

function Screen:Draw()
    love.graphics.clear( 200, 200, 200, 255 )

end

function Screen:KeyPressed( key, scancode, isrepeat )
end

function Screen:KeyReleased( key, scancode )
end

function Screen:mousepressed( iX, iY, iButton, iIsTouch )
end

function Screen:Finalize()
end 

return Screen