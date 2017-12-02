local LevelBase     = require "src/Game/Level/LevelBaseECS"


local AttackGenerator       = require "src/Game/AttackGenerator"
local BabyTree              = require "src/Objects/Environnement/BabyTree"
local Animation            = require "src/Image/Animation"
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

local ECSIncludes            = require 'src/ECS/ECSIncludes'

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

    newLevel1:InitializeECS();

    return  newLevel1
end

-- ==========================================Type

function  Level1:InitializeECS()
    self.mHero = Entity:New( "hero" )

    -- Components
    local box2DComponent = BasicComponents:NewBox2DComponent( self.mWorld, 0, -100, 50, 50, "dynamic", true, 1 )
        local stickyShape    = love.physics.newRectangleShape( 50, 50 )
        local fixture  = love.physics.newFixture( box2DComponent.mBody, stickyShape )
        fixture:setFriction( 1.0 )
        fixture:setUserData( self.mHero )

    local animations = {}
    animations[ "idleright" ] = Animation:New( 'resources/Animation/Characters/Dummy/idle.png', 24, 16, true, false, false )
    animations[ "idleleft" ] = Animation:New( 'resources/Animation/Characters/Dummy/idle.png', 24, 16, true, true, false )

    self.mHero:AddComponent( BasicComponents:NewUserInput() )
    self.mHero:AddComponent( BasicComponents:NewStateComponent( "idleright" ) )
    self.mHero:AddComponent( BasicComponents:NewAnimationsComponent( animations ) )
    --self.mHero:AddComponent( BasicComponents:NewSimpleSprite( 'resources/Images/Objects/Water.png' ) )
    self.mHero:AddComponent( box2DComponent )

    self.mHero:AddTag( "canJump" )
    self.mHero:AddTag( "isJumping" )

    --local slipperyShape    = love.physics.newRectangleShape( self.mW - 25, self.mH - 5 )
    --fixture  = love.physics.newFixture( self.mBody, slipperyShape )
    --fixture:setFriction( 0.0 )
    --fixture:setUserData( self.mHero )

    ECSWorld:AddEntity( self.mHero )
    ECSWorld:AddSystem( SpriteRenderer )
    ECSWorld:AddSystem( InputConverter )
    ECSWorld:AddSystem( AnimationRenderer )
    ECSWorld:AddSystem( HeroController )

    self.mWorldECS = ECSWorld
end


function  Level1:Type()
    return "Level1"
end

-- ==========================================Update/Draw


-- function  Level1:Update( iDT )
-- end


-- function  Level1:Draw()
-- end


-- ==========================================Level1 functions


function  Level1:UpdateCamera()

    if self.mHero ~= nil then

        self.mCamera.mX = self.mHero:GetComponentByName( "box2d" ).mBody:getX() - self.mCamera.mW / 2
        self.mCamera.mY = self.mHero:GetComponentByName( "box2d" ).mBody:getY() - self.mCamera.mH / 2

    end

end


-- ==========================================Collide CB


return  Level1