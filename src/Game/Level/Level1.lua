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
-- Shortcuts                   = require "src/Application/Shortcuts"
KOPainShortcutsEngine       = require "src/Application/KOPainShortcutsEngine"
-- ShortcutsDisplay            = require( "src/Application/ShortcutsDisplay" )



--TESTS
local Ray               = require "src/Objects/Rays/Ray"
local Water             = require "src/Objects/Particles/Water"
local Vector            = require "src/Math/Vector"
local SLAXML            = require 'src/ExtLibs/XML/SLAXML/slaxdom'

local ECSIncludes       = require 'src/ECS/ECSIncludes'
local Spike             = require 'src/ECS/Factory/Spike'
local MovingPlatform    = require 'src/ECS/Factory/MovingPlatform'

local SpikeBall         = require 'src/ECS/Factory/SpikeBall'

local Level1 = {}
setmetatable( Level1, LevelBaseECS )
LevelBaseECS.__index = LevelBaseECS


-- ==========================================Build/Destroy


function Level1:NewFromXML( iWorld )
    newLevel1 = {}
    setmetatable( newLevel1, Level1 )
    Level1.__index = Level1

    local xml = io.open('Save/LevelTEST.xml'):read('*all')
    -- local xml = io.open('Save/Level111.xml'):read('*all')
    local doc = SLAXML:dom( xml )
    newLevel1:LoadLevelBaseECSXML( doc.root, iWorld )
    gWorld = iWorld

    -- BACKGROUNDS

    newLevel1:InitializeECS();

    bgZozo = love.graphics.newImage( "resources/Images/BGGRID.png" )

    targetx = 0
    targety = 0

    cameraSmooth = 10

    return  newLevel1
end

-- ==========================================CB

function DashEnd( arg )
    arg:RemoveTag( "isDashing" )
    arg:AddTag( "didDash" )
    arg:AddTag( "isInAir" )

    local animationComponent = arg:GetComponentByName( "animations" )
    animationComponent.mAnimations[ animationComponent.mCurrentAnimationIndex ].mTime = 0
    animationComponent.mAnimations[ animationComponent.mCurrentAnimationIndex ].mIsPaused = false


    --check if we have contect with ground
    local box2d = arg:GetComponentByName( "box2d" )
    if box2d then
        for k,v in pairs( box2d.mBody:getContactList() ) do
            fix1, fix2 = v:getFixtures()
            if( fix1:getCategory() == 1 and fix2:getCategory() == 2 or
                fix2:getCategory() == 1 and fix1:getCategory() == 2
                ) then
                local x1, y1, x2, y2  = v:getPositions()
                if x1 and y1 then
                    x1, y1 = box2d.mBody:getLocalPoint( x1, y1 )
                    if y1 > box2d.mBodyH / 2 then
                        arg:RemoveTag( "didDash" )
                        arg:RemoveTag( "isInAir" )
                    end
                end

                if x2 and y2 then
                    x2, y2 = box2d.mBody:getLocalPoint( x2, y2 )
                    if y2 > box2d.mBodyH / 2 then
                        arg:RemoveTag( "didDash" )
                        arg:RemoveTag( "isInAir" )
                    end
                end
            end
        end
    end
end

-- ==========================================Type

function  Level1:InitializeECS()

    self.mHero = Entity:New( "hero" )
    self.mHero.mCheckPoints = {}
    self.mHero.mCheckPoint = -1

    -- Components
    -- local box2DComponent = Box2DComponent:NewBox2DComponent( self.mWorld, -361, -3039, 45, 100, "dynamic", true, 1, 19, 0 )
    local box2DComponent = Box2DComponent:New( self.mWorld, 0, 200, 45, 100, "dynamic", true, 1, 19, 0 )
        local stickyShape    = love.physics.newRectangleShape( 0, 0, 45, 100 )
        local fixture  = love.physics.newFixture( box2DComponent.mBody, stickyShape )
        fixture:setFriction( 1.0 )
        fixture:setRestitution( 0 )
        fixture:setCategory( 2 ) --shape detecting collision with decor
        fixture:setUserData( self.mHero )

    local animations = {}
    animations[ "idle" ] = Animation:New( 'resources/Animation/Characters/Dummy/idle.png', 24, 16, true, false, false )
    animations[ "move" ] = Animation:New( 'resources/Animation/Characters/Dummy/run.png', 13, 24, true, false, false )
    animations[ "jump" ] = Animation:New( 'resources/Animation/Characters/Dummy/Jump.png', 9, 16, false, false, false )
    animations[ "land" ] = Animation:New( 'resources/Animation/Characters/Dummy/Land.png', 9, 16, false, false, false )
    animations[ "crouch" ] = Animation:New( 'resources/Animation/Characters/Dummy/Crouch.png', 4, 16, false, false, false )
    animations[ "crawl" ] = Animation:New( 'resources/Animation/Characters/Dummy/Crawl.png', 19, 24, true, false, false )
    animations[ "dash" ] = Animation:New( 'resources/Animation/Characters/Dummy/Dash.png', 8, 16, false, false, false, 0.3 )
    animations[ "fall" ] = Animation:New( 'resources/Animation/Characters/Dummy/Fall.png', 9, 16, true, false, false )
    animations[ "death" ] = Animation:New( 'resources/Animation/Characters/Dummy/Death.png', 8, 24, false, false, false )

    animations[ "dash" ].mPlayEndCB = DashEnd
    animations[ "dash" ].mPlayEndCBArguments = self.mHero

    self.mHero:AddComponent( UserInputComponent:New() )
    self.mHero:AddComponent( KillableComponent:New() )
    self.mHero:AddComponent( DirectionComponent:New( "right", "up" ) )
    self.mHero:AddComponent( AnimationsComponent:New( animations, "idle" ) )
    self.mHero:AddComponent( box2DComponent )

    --TODO: hitbox system to know if we re in the air
    -- self.mHero:AddTag( "isAutoRun" )

    --self.mHero:AddTag( "isDashing" )
    --self.mHero:AddTag( "isMoving" )
    --self.mHero:AddTag( "isInAir" ) -- true => fall, dash     false => jump, idle, move, land, crouch, crawl, dash
    --self.mHero:AddTag( "isCrouch" )
    --self.mHero:AddTag( "isDead" )
    --self.mHero:AddTag( "didDoubleJump" )
    --self.mHero:AddTag( "didTripleJump" )
    --self.mHero:AddTag( "didDash" )
    self.mHero:AddTag( "teleportable" )

    ECSWorld:AddEntity( self.mHero )



    --TEST
    local movingPlatform = MovingPlatform:New( self.mWorld, 200, 500, 150, 20 )

    local spikeBall = SpikeBall:New( self.mWorld, 600, 100 )
    spikeBall:AddTag( "swapable" )
    local spikeBall2 = SpikeBall:New( self.mWorld, 600, 0 )
    spikeBall2:AddTag( "swapable" )
    -- local ent = TeleporterActionGiverRibbon:New( self.mWorld, 600, 200, "resources/Images/Decor/ruban_04.png", 5000, 200, "actiondewinnance" )
    --TEST

    KOPainShortcutsEngine.Initialize()

    -- KOPainShortcutsEngine.RegisterActionWithRandomKey( "jump" )
    -- KOPainShortcutsEngine.RegisterActionWithRandomKey( "swapCanKill" )
    -- KOPainShortcutsEngine.RegisterActionWithRandomKey( "moveright" )
    -- KOPainShortcutsEngine.RegisterActionWithRandomKey( "moveleft" )
    Shortcuts.RegisterAllActions()

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

    ShortcutsDisplay.Draw()
end

-- ==========================================Level1 functions


function  Level1:UpdateCamera()

    -- fix
    self.mCamera.mW = love.graphics.getWidth()
    self.mCamera.mH = love.graphics.getHeight()
    if self.mHero ~= nil then

        self.mCamera.mX = self.mCamera.mX  + ( targetx - self.mCamera.mX ) / cameraSmooth
        self.mCamera.mY = self.mCamera.mY  + ( targety - self.mCamera.mY ) / cameraSmooth

        targetx = self.mHero:GetComponentByName( "box2d" ).mBody:getX() - self.mCamera.mW / 2
        targety = ( self.mHero:GetComponentByName( "box2d" ).mBody:getY() - self.mCamera.mH * 2/3 )
    end

end


-- ==========================================Collide CB


return  Level1