local LevelBaseECS     = require "src/Game/Level/LevelBaseECS"


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

local ECSIncludes       = require 'src/ECS/ECSIncludes'
local Spike             = require 'src/ECS/Factory/Spike'

local Level1 = {}
setmetatable( Level1, LevelBaseECS )
LevelBaseECS.__index = LevelBaseECS


-- ==========================================Build/Destroy


function Level1:NewFromXML( iWorld )
    newLevel1 = {}
    setmetatable( newLevel1, Level1 )
    Level1.__index = Level1

    local xml = io.open('Save/Level1.xml'):read('*all')
    -- local xml = io.open('/home/damien/work2/Love2D/TVPGameJam2017/Save/Level1.xml'):read('*all')
    local doc = SLAXML:dom( xml )
    newLevel1:LoadLevelBaseECSXML( doc.root, iWorld )
    gWorld = iWorld

    -- BACKGROUNDS

    newLevel1:InitializeECS();
    
    bgZozo = love.graphics.newImage( "resources/Images/BGGRID.png" )

    return  newLevel1
end

-- ==========================================Type

function  Level1:InitializeECS()
    self.mHero = Entity:New( "hero" )

    -- Components
    local box2DComponent = BasicComponents:NewBox2DComponent( self.mWorld, 0, -100, 45, 100, "dynamic", true, 1 )
        local stickyShape    = love.physics.newRectangleShape( 45, 100 )
        local fixture  = love.physics.newFixture( box2DComponent.mBody, stickyShape )
        fixture:setFriction( 1.0 )
        fixture:setUserData( self.mHero )

    local animations = {}
    animations[ "idle" ] = Animation:New( 'resources/Animation/Characters/Dummy/idle.png', 24, 16, true, false, false )
    animations[ "move" ] = Animation:New( 'resources/Animation/Characters/Dummy/run.png', 13, 24, true, false, false )
    animations[ "jump" ] = Animation:New( 'resources/Animation/Characters/Dummy/Jump.png', 9, 16, true, false, false )
    animations[ "land" ] = Animation:New( 'resources/Animation/Characters/Dummy/Land.png', 9, 16, true, false, false )
    animations[ "crouch" ] = Animation:New( 'resources/Animation/Characters/Dummy/Crouch.png', 4, 16, true, false, false )
    animations[ "crawl" ] = Animation:New( 'resources/Animation/Characters/Dummy/Crawl.png', 19, 24, true, false, false )
    animations[ "dash" ] = Animation:New( 'resources/Animation/Characters/Dummy/Dash.png', 8, 16, true, false, false )
    animations[ "fall" ] = Animation:New( 'resources/Animation/Characters/Dummy/Fall.png', 9, 16, true, false, false )
    animations[ "death" ] = Animation:New( 'resources/Animation/Characters/Dummy/Death.png', 8, 24, true, false, false )

    self.mHero:AddComponent( BasicComponents:NewUserInput() )
    self.mHero:AddComponent( BasicComponents:NewKillable() )
    self.mHero:AddComponent( BasicComponents:NewDirectionComponent( "right", "up" ) )
    self.mHero:AddComponent( BasicComponents:NewAnimationsComponent( animations, "idle" ) )
    self.mHero:AddComponent( box2DComponent )

    --TODO: hitbox system to know if we re in the air
    self.mHero:AddTag( "isAutoRun" )
    --self.mHero:AddTag( "isDashing" )
    --self.mHero:AddTag( "isMoving" )
    --self.mHero:AddTag( "isInAir" ) -- true => fall, dash     false => jump, idle, move, land, crouch, crawl, dash
    --self.mHero:AddTag( "isCrouch" )
    --self.mHero:AddTag( "isDead" )
    --self.mHero:AddTag( "didDoubleJump" )
    --self.mHero:AddTag( "didTripleJump" )

    ECSWorld:AddEntity( self.mHero )
    ECSWorld:AddEntity( Spike:New( self.mWorld, 200, 150 ) )
end


function  Level1:Type()
    return "Level1"
end

-- ==========================================Update/Draw


-- function  Level1:Update( iDT )
-- end

function Level1:Draw( iCamera )

    local camera = self.mCamera
    if( iCamera ) then
        camera = iCamera
    end

    love.graphics.clear( 40, 40, 40 )
    local width = love.graphics.getWidth();
    local height = love.graphics.getHeight();

    local rwidth = width / camera.mScale;
    local rheight = height / camera.mScale;

    local zozoWidth = bgZozo:getWidth()
    local zozoHeight = bgZozo:getHeight()
    local nfw = math.ceil( rwidth / zozoWidth );
    local nfh = math.ceil( rheight / zozoHeight );
    local zozoDepth = 1
    love.graphics.setColor(255,255,255,127);
    for i=0, nfw, 1 do
        for j=0, nfh, 1 do
            love.graphics.draw( bgZozo, - ( camera.mX % zozoWidth ) * zozoDepth + i * zozoWidth * camera.mScale, - ( camera.mY % zozoHeight ) * zozoDepth + j * zozoHeight * camera.mScale, 0, camera.mScale, camera.mScale )
        end
    end
    love.graphics.setColor(255,255,255,255);

    self:DrawBase( iCamera )
end

-- ==========================================Level1 functions


function  Level1:UpdateCamera()

    if self.mHero ~= nil then

        self.mCamera.mX = self.mHero:GetComponentByName( "box2d" ).mBody:getX() - self.mCamera.mW / 2
        self.mCamera.mY = self.mHero:GetComponentByName( "box2d" ).mBody:getY() - self.mCamera.mH / 2

    end

end


-- ==========================================Collide CB


return  Level1