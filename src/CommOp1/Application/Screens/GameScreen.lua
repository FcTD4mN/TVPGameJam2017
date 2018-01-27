--[[===================================================================
    File: Application.Screens.GameScreen.lua

    @@@@: The Game Screen.
    Dedicated for the actual game, playing etc...

===================================================================--]]

-- INCLUDES ===========================================================
local Screen        = require "src/Application/Screens/Screen"

local MapTileEntity = require "src/CommOp1/ECS/Factory/MapTileEntity"
local Level1 = require "src/CommOp1/Game/Level/Level1"


-- OBJECT INITIALISATION ==============================================
local GameScreen = {}
setmetatable( GameScreen, Screen )
Screen.__index = Screen


-- Constructor
function GameScreen:New()
    local newGameScreen = {}
    setmetatable( newGameScreen, self )
    self.__index = self

    return newGameScreen
end



-- LOCAL MEMBERS =====================================================
    -- That way they are local to file
    -- NONE YET

-- Called by Global Manager only on SetScreen.
function GameScreen:Initialize()
    MapTileEntity:Init()

    self.mLevel = Level1:New()
end


-- OBJECT FUNCTIONS ===================================================
function GameScreen:Update( dt )
    self.mLevel:Update( dt )
end


function GameScreen:Draw()
    self.mLevel:Draw()
end


--USER INPUT============================================================================


function GameScreen:TextInput( iT )
    return  self.mLevel:TextInput( iT )
end


function GameScreen:KeyPressed( iKey, iScancode, iIsRepeat )
    return  self.mLevel:KeyPressed( iKey, iScancode, iIsRepeat )
end


function GameScreen:KeyReleased( iKey, iScancode )
    return  self.mLevel:KeyReleased( iKey, iScancode )
end


function GameScreen:MousePressed( iX, iY, iButton, iIsTouch )
    return  self.mLevel:MousePressed( iX, iY, iButton, iIsTouch )
end


function GameScreen:MouseMoved( iX, iY )
    return  self.mLevel:MouseMoved( iX, iY )
end


function GameScreen:MouseReleased( iX, iY, iButton, iIsTouch )
    return  self.mLevel:MouseReleased( iX, iY, iButton, iIsTouch )
end


function GameScreen:WheelMoved( iX, iY )
    return  self.mLevel:WheelMoved( iX, iY )
end


-- Release resources before Screen Switch or App Close ======================================
function GameScreen:Finalize()
end


-- RETURN CHUNK AS GLOBAL OBJECT ======================================
return GameScreen
