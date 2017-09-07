-- Could be interesting to improve probe
-- https://stackoverflow.com/questions/11062252/how-to-detect-collision-but-do-not-collide-in-box2d


local   Object      = require( "src/Objects/Object" )
        ObjectPool  = require "src/Objects/Pools/ObjectPool"


local Probe = {}
setmetatable( Probe, Object )
Probe.__index = Probe


-- ==========================================Build/Destroy


function Probe:New( iWorld, iX, iY, iDirectionVector, iCallback, iCaller )

    local newProbe = {}
    setmetatable( newProbe, Probe )
    Probe.__index = Probe

    newProbe:BuildProbe( iWorld, iX, iY, iDirectionVector, iCallback, iCaller )

    return  newProbe
end


function  Probe:BuildProbe( iWorld, iX, iY, iDirectionVector, iCallback, iCaller )

    self:BuildObject( iWorld, iX, iY, 1, 1, "dynamic", false )

    self.mBody:setLinearVelocity( iDirectionVector.x, iDirectionVector.y )
    self.mBody:setGravityScale( 0.0 )

    local shape       = love.physics.newRectangleShape( 1, 1 )
    local fixture     = love.physics.newFixture( self.mBody, shape )
    fixture:setCategory( 10 )
    fixture:setMask( 2, 10 )
    fixture:setUserData( self )

    self.mCallback   = iCallback
    self.mCaller     = iCaller

end

-- ==========================================Type


function  Probe:Type()
    return "Probe"
end


-- ==========================================Update/Draw


function  Probe:Update( iDT )

end


function  Probe:Draw( iCamera )
end


-- ==========================================Callbacks


function Probe:Collide( iObject )
    if( self.needDestroy == true ) then  return  end
    self.callback( self.caller, self.body:getX(),  self.body:getY() )
    self.body:setActive( false )
    self:Destroy()
end



return  Probe