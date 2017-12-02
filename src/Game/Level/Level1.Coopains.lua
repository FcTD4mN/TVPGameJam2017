local LevelBase     = require "src/Game/Level/LevelBase"


local AttackGenerator       = require "src/Game/AttackGenerator"
local BabyTree              = require "src/Objects/Environnement/BabyTree"
local Background            = require "src/Image/Background"
local BigImage              = require "src/Image/BigImage"
local Camera                = require "src/Camera/Camera"
local GrownTree             = require "src/Objects/Environnement/GrownTree"
local ImageShapeComputer    = require "src/Image/ImageShapeComputer"
local Lapin                 = require "src/Objects/Heros/Lapin"
local MiniMap               = require "src/Camera/MiniMap"
      ObjectRegistry        = require "src/Base/ObjectRegistry"
local Singe                 = require "src/Objects/Heros/Singe"
local Terrain               = require "src/Objects/Terrain"
local Tree                  = require "src/Objects/Environnement/Tree"
local WaterPipe             = require "src/Objects/Environnement/WaterPipe"


--TESTS
local Ray               = require "src/Objects/Rays/Ray"
local Water             = require "src/Objects/Particles/Water"
local Vector            = require "src/Math/Vector"
local SLAXML            = require 'src/ExtLibs/XML/SLAXML/slaxdom'


local Level1 = {}
setmetatable( Level1, LevelBase )
LevelBase.__index = LevelBase


-- ==========================================Build/Destroy


function Level1:NewFromXML( iWorld )

    newLevel1 = {}
    setmetatable( newLevel1, Level1 )
    Level1.__index = Level1

    local xml = io.open('Save/Level1.xml'):read('*all')
    -- local xml = io.open('/home/damien/work2/Love2D/TVPGameJam2017/Save/Level1.xml'):read('*all')
    local doc = SLAXML:dom( xml )
    newLevel1:LoadLevelBaseXML( doc.root, iWorld )

    -- BACKGROUNDS
    newLevel1.mFixedBackground          = BigImage:New( "resources/Images/Backgrounds/Final/GRADIENT.png", 500 )
    for i = 1, 100 do
        water = Water:New( iWorld, 600, 50 )
    end
    -- BabyTree:New( iWorld, 600, 50 )

    return  newLevel1

end

-- ==========================================Type


function  Level1.Type()
    return "Level1"
end


-- ==========================================Update/Draw


-- function  Level1:Update( iDT )
-- end


-- function  Level1:Draw()
-- end


-- ==========================================Level1 functions


function  Level1:UpdateCamera()
    if #self.mHeros <= 0 then    
        return
    end
    xAverage = 0

    for k,v in pairs( self.mHeros ) do
        x = v:GetX()
        xAverage = ( xAverage + x )
    end
    xAverage = xAverage / #self.mHeros

    self.mCamera.mX = xAverage - love.graphics.getWidth() / 2
    self.mCamera.mY = - ( love.graphics.getHeight() - 720 ) / 2
end


-- ==========================================Collide CB


return  Level1