local LevelBase     = require "src/Game/Level/LevelBase"


local AttackGenerator       = require "src/Game/AttackGenerator"
local BabyTree              = require "src/Objects/Environnement/BabyTree"
local Background            = require "src/Image/Background"
local BigImage              = require "src/Image/BigImage"
local GrownTree             = require "src/Objects/Environnement/GrownTree"
local ImageShapeComputer    = require "src/Image/ImageShapeComputer"
local Lapin                 = require "src/Objects/Heros/Lapin"
local Singe                 = require "src/Objects/Heros/Singe"
local Terrain               = require "src/Objects/Terrain"
local Tree                  = require "src/Objects/Environnement/Tree"
local WaterPipe             = require "src/Objects/Environnement/WaterPipe"


--TESTS
local Ray             = require "src/Objects/Rays/Ray"
local CollidePool     = require "src/Objects/CollidePool"
local ObjectPool      = require "src/Objects/ObjectPool"


local Level1 = {}
setmetatable( Level1, LevelBase )
LevelBase.__index = LevelBase


-- ==========================================Build/Destroy


function Level1:New( iWorld )

    newLevel1 = {}
    setmetatable( newLevel1, Level1 )
    Level1.__index = Level1

    Level1:BuildLevel1( iWorld )

    return  newLevel1

end


function  Level1:BuildLevel1( iWorld )

    self:BuildLevelBase( iWorld )
    self:Initialize()

end

function Level1:Initialize()

    music = love.audio.newSource( "resources/Audio/Music/Enjeuloop.mp3", "stream" )
    music:setLooping( true )

    -- OBJECTS
    self.mHeros[1]      =  Singe:New( self.mWorld, 1000, 500 )
    self.mHeros[2]      =  Lapin:New( self.mWorld, 800, 50 )
    table.insert( self.mEnvironnementObjects, Tree:New( self.mWorld, 2400, 0 ) )
    table.insert( self.mEnvironnementObjects, BabyTree:New( self.mWorld, 3700, 600 ) )
    table.insert( self.mEnvironnementObjects, WaterPipe:New( self.mWorld, 3600, 130 ) )

    -- TERRAIN
    Level1:BuildTerrain()

    -- BACKGROUNDS
    self.mFixedBackground          = BigImage:New( "resources/Images/Backgrounds/Final/GRADIENT.png", 500 )
    table.insert( self.mBackgrounds, Background:New( "resources/Images/Backgrounds/Background3000x720.png", 0, 0, 0 ) )
    table.insert( self.mBackgrounds, Background:New( "resources/Images/Backgrounds/Final/TERRAIN.png", 0, 0, 0 ) )
    table.insert( self.mForegrounds, Background:New( "resources/Images/Backgrounds/Foreground3000x720.png", 0, 0 , -1 ) )


    --TESTS
    ray = Ray:New( world, 500, 150, 10, 20000 )

    -- love.audio.play( music )
end


function  Level1:BuildTerrain()
    Terrain.Initialize( self.mWorld )

    -- Upper ground
    Terrain.AddEdge( 0, 325, 600, 325 )
    Terrain.AppendEdgeToPrevious( 1000, 300 )
    Terrain.AppendEdgeToPrevious( 1250, 300 )
    Terrain.AppendEdgeToPrevious( 1640, 375 )
    Terrain.AppendEdgeToPrevious( 1790, 320 )
    Terrain.AppendEdgeToPrevious( 1980, 320 )
    Terrain.AppendEdgeToPrevious( 2180, 365 )
    Terrain.AppendEdgeToPrevious( 2900, 365 )
    Terrain.AppendEdgeToPrevious( 3370, 330 )
    Terrain.AppendEdgeToPrevious( 3900, 330 )
    Terrain.AddEdge( 4400, 360, 4715, 310 )
    Terrain.AppendEdgeToPrevious( 5110, 360 )
    Terrain.AppendEdgeToPrevious( 6115, 360 )
    Terrain.AppendEdgeToPrevious( 6800, 330 )
    Terrain.AppendEdgeToPrevious( 7690, 310 )
    Terrain.AppendEdgeToPrevious( 8110, 390 )
    Terrain.AppendEdgeToPrevious( 9600, 345 )
    Terrain.AppendEdgeToPrevious( 9600, 0 )

    -- Lower ground
    Terrain.AddEdge( 0, 675, 500, 675 )
    Terrain.AppendEdgeToPrevious( 730, 650 )
    Terrain.AppendEdgeToPrevious( 1460, 700 )
    Terrain.AppendEdgeToPrevious( 2030, 700 )
    Terrain.AppendEdgeToPrevious( 5100, 700 )
    Terrain.AppendEdgeToPrevious( 5300, 715 )
    Terrain.AppendEdgeToPrevious( 5600, 660 )
    Terrain.AppendEdgeToPrevious( 5600, 700 )
    Terrain.AppendEdgeToPrevious( 7650, 680 )
    Terrain.AppendEdgeToPrevious( 7880, 700 )
    Terrain.AppendEdgeToPrevious( 9550, 680 )
    Terrain.AppendEdgeToPrevious( 9600, 350 )

    self.mTerrain = Terrain
end

-- ==========================================Type


function  Level1.Type()
    return "Level1"
end


-- ==========================================Update/Draw


function  Level1:Update( iDT )

    for k,v in pairs( self.mBackgrounds ) do
        v:Update( iDT )
    end

    self.mWorld:update( iDT )
    CollidePool.Update( iDT )
    ObjectPool.Update( iDT )

    for k,v in pairs( self.mForegrounds ) do
        v:Update( iDT )
    end

    ray:Update( iDT )

    self:UpdateCamera()

end


function  Level1:Draw()

    self.mFixedBackground:Draw( 0, 0 )

    for k,v in pairs( self.mBackgrounds ) do
        v:Draw()
    end

    ObjectPool.Draw()

    for k,v in pairs( self.mForegrounds ) do
        v:Draw()
    end

    ray:Draw()
end


-- ==========================================Level1 functions


-- ==========================================Collide CB


return  Level1