local Animation         = require "src/Image/Animation"
local Object            = require "src/Objects/Object"
local ObjectPool        = require "src/Objects/Pools/ObjectPool"
local AttackGenerator   = require "src/Game/AttackGenerator"

local WaterPipe = {}
setmetatable( WaterPipe, Object )
Object.__index = Object


-- ==========================================Constructor/Destructor


function WaterPipe:New( iWorld, iX, iY )

    local newWaterPipe = {}
    setmetatable( newWaterPipe, WaterPipe )
    WaterPipe.__index = WaterPipe

    newWaterPipe:BuildWaterPipe( iWorld, iX, iY )

    return newWaterPipe
end


function  WaterPipe:BuildWaterPipe( iWorld, iX, iY )

    self:BuildObject( iWorld, iX, iY, 230, 350, "static", true )
    self.mBody:setGravityScale( 0.0 )

    local shape       = love.physics.newRectangleShape( 200, self.mH - 150 )
    local fixture     = love.physics.newFixture( self.mBody, shape )
    fixture:setFriction( 1.0 )
    fixture:setUserData( self )

    local WaterPipe      = love.graphics.newImage( "resources/Images/Backgrounds/pipeline.png" )
    self:AddAnimation( WaterPipe, 1, 1, false, false )
    self:PlayAnimation( 1, 0 )

end


-- ==========================================Type


function WaterPipe:Type()
    return  "WaterPipe"
end


-- ==========================================Update/Draw


function WaterPipe:Update( iDT )
    self:UpdateObject( iDT )
end


function WaterPipe:Draw( iCamera )
    self:DrawObject( iCamera )
end


-- ==========================================Tree actions


function  WaterPipe:ShootOut()
    x = self:GetX() + self.mW / 2
    y = self:GetY() + self.mH + 5
    AttackGenerator:GenerateAttack( x, y, "Waterball", 100, "vertical" )
end


function  WaterPipe:Collide( iObject )
    if( iObject:Type() == "Fireball" ) then
        self:Destroy()
    end
    if( iObject:Type() == "Waterball" ) then
        self:ShootOut()
    end
end


return WaterPipe