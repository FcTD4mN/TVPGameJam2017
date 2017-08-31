local Animation         = require "src/Image/Animation"
local Object            = require "src/Objects/Object"
local ObjectPool        = require "src/Objects/ObjectPool"
local AttackGenerator   = require "src/Game/AttackGenerator"

local WaterPipe = Object:New( 0, 0, 0, 0, 0, 0, 0, 0 )


-- ==========================================Constructor/Destructor


function WaterPipe:New( iWorld, iX, iY )
    local newWaterPipe = {}
    setmetatable( newWaterPipe, self )
    self.__index = self

    newWaterPipe.x = x
    newWaterPipe.y = y

    newWaterPipe.w = 230
    newWaterPipe.h = 350

    --inherited values
    newWaterPipe.body        = love.physics.newBody( iWorld, iX + newWaterPipe.w/2, iY + newWaterPipe.h/2, "static" )
    newWaterPipe.body:setFixedRotation( true )
    newWaterPipe.body:setGravityScale( 0.0 )

    newWaterPipe.shape       = love.physics.newRectangleShape( 200, newWaterPipe.h - 100 )
    newWaterPipe.fixture     = love.physics.newFixture( newWaterPipe.body, newWaterPipe.shape )
    newWaterPipe.fixture:setFriction( 1.0 )
    newWaterPipe.fixture:setUserData( newWaterPipe )


    newWaterPipe.animations = {}
    newWaterPipe.currentAnimation = 0
    newWaterPipe.shouldFire = false

    local WaterPipe      = love.graphics.newImage( "resources/Images/Backgrounds/pipeline.png" )
    newWaterPipe:AddAnimation( WaterPipe, 1, 1, false, false )
    newWaterPipe:PlayAnimation( 1, 0 )

    ObjectPool.AddObject( newWaterPipe )

    return newWaterPipe
end


-- ==========================================Type


function WaterPipe:Type()
    return  "WaterPipe"
end


-- ==========================================Update/Draw


function WaterPipe:Update( dt )
    if( self.shouldFire ) then
        x = self:GetX() + self.w / 2
        y = self:GetY() + self.h + 5
        AttackGenerator:GenerateAttack( x, y, "waterball", 100, "vertical" )
        self.shouldFire = false
    end

    self:UpdateObject( dt )
end


function WaterPipe:Draw()
    self:DrawObject()
    -- self:DEBUGDrawHitBox()
end


-- ==========================================Tree actions


function  WaterPipe:ShootOut()
    self.shouldFire = true
end

return WaterPipe