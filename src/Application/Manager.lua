--[[=================================================================== 
    File: Base.Base.lua

    @@@@: This is the Base Module.
    A module is a Global Singleton Objects that will act like a
    namespace. See Base.Module.lua for more details.

===================================================================--]]

-- INCLUDES ===========================================================
-- NONE

-- OBJECT INITIALISATION ==============================================
local Manager = {};

function Manager:New()
    newManager = {}
    setmetatable( newManager, self );
    self.__index = self;

    newManager.screens = {}
    newManager.currentScreen = 1;
    newManager.running = true;

    return  newManager;

end

-- OBJECT FUNCTIONS ===================================================
function Manager:Type()
    return "Manager"
end

function Manager:PushScreen( iScreen )
    if( iScreen:Type() == "Screen" ) then
        table.insert( self.screens, iScreen );
    end
    
end

function Manager:SetScreen( iNumScreen )
    -- Todo: Release resources before switch
    self.currentScreen = iNumScreen;
    self.screens[ self.currentScreen ]:Initialize();

end

function Manager:UpdateScreen( dt )
    self.screens[ self.currentScreen ]:Update( dt );
    
end

function Manager:DrawScreen()
    love.graphics.setColor(255,255,255,255);
    love.graphics.clear( 200, 200, 200, 255 )
    self.screens[ self.currentScreen ]:Draw();
end

function Manager:KeyPressed( key, scancode, isrepeat )
    self.screens[ self.currentScreen ]:KeyPressed( key, scancode, isrepeat );

end

function Manager:KeyReleased( key, scancode )
    self.screens[ self.currentScreen ]:KeyReleased( key, scancode );

end

function Manager:mousepressed( iX, iY, iButton, iIsTouch )
    self.screens[ self.currentScreen ]:mousepressed( iX, iY, iButton, iIsTouch );

end

function Manager:Finalize()
    self.screens[ self.currentScreen ]:Finalize()

end 

-- RETURN CHUNK AS GLOBAL OBJECT ======================================
return Manager