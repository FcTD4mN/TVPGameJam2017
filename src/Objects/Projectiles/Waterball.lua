local Animation     = require "src/Image/Animation"
local Object        = require "src/Objects/Object"
local ObjectPool    = require "src/Objects/Pools/ObjectPool"


Waterball = {}
setmetatable( Waterball, Object )
Object.__index = Object

-- ==========================================Constructor/Destructor


function Waterball:New( iWorld, iX, iY, iVelocity, iDirection )

    local newWaterball = {}
    setmetatable( newWaterball, Waterball )
    Waterball.__index = Waterball

    newWaterball:BuildWaterball( iWorld, iX, iY, iVelocity, iDirection )

    return newWaterball
end


function  Waterball:BuildWaterball( iWorld, iX, iY, iVelocity, iDirection )

    self:BuildObject( iWorld, iX, iY, 90, 90, "dynamic", false )
    self.mBody:setLinearVelocity( iVelocity, 0 )
    self.mBody:setGravityScale( 1.0 )

    if( iDirection == "horizontal" ) then
        self.mBody:setLinearVelocity( iVelocity, 0 )
    elseif( iDirection == "vertical" ) then
        self.mBody:setLinearVelocity( 0, iVelocity )
        self.mBody:setAngle( 90 )
    end

    local shape    = love.physics.newRectangleShape( self.mW, self.mH )
    local fixture  = love.physics.newFixture( self.mBody, shape )
    fixture:setFriction( 1.0 )
    fixture:setUserData( self )

    self.mFlipNeeded = iVelocity < 0

end


-- ==========================================Type


function Waterball:Type()
    return "Waterball"
end


-- ==========================================Update/Draw


function Waterball:Update( iDT )
    self:UpdateObject( iDT )
end


function Waterball:Draw( iCamera )
    self:DrawObject( iCamera )
end


-- ==========================================Waterball specific overrides


function Waterball:AddAnimation( iImage )
    table.insert( self.mAnimations, Animation:New( iImage, self.mX, self.mY, self.mW, self.mH, 0, 16, 24, self.mFlipNeeded, false ) )
end


-- ==========================================Collision stuff

function Waterball:Collide( iObject )
    self:Destroy()
end


return Waterball