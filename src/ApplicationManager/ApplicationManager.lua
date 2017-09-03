

local ApplicationManager = {};

function ApplicationManager:New()
    newApplicationManager = {}
    setmetatable( newApplicationManager, self );
    self.__index = self;

    newApplicationManager.screens = {}
    newApplicationManager.currentScreen = 1;
    newApplicationManager.running = true;

    return  newApplicationManager;

end

function ApplicationManager:PushScreen( iScreen )
    if( iScreen:Type() == "Screen" ) then
        table.insert( self.screens, iScreen );
    end
    
end

function ApplicationManager:SetScreen( iNumScreen )
    self.currentScreen = iNumScreen;
    self.screens[ self.currentScreen ]:Initialize();

end

function ApplicationManager:UpdateScreen( dt )
    self.screens[ self.currentScreen ]:Update( dt );
    
end

function ApplicationManager:DrawScreen()
    love.graphics.clear( 200, 200, 200, 255 )
    self.screens[ self.currentScreen ]:Draw();

end

function ApplicationManager:KeyPressed( key, scancode, isrepeat )
    self.screens[ self.currentScreen ]:KeyPressed( key, scancode, isrepeat );

end

function ApplicationManager:KeyReleased( key, scancode )
    self.screens[ self.currentScreen ]:KeyReleased( key, scancode );

end

function ApplicationManager:mousepressed( iX, iY, iButton, iIsTouch )
    self.screens[ self.currentScreen ]:mousepressed( iX, iY, iButton, iIsTouch );

end

function ApplicationManager:Finalize()
    self.screens[ self.currentScreen ]:Finalize()

end 

return ApplicationManager