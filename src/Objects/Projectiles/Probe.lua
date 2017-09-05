-- Could be interesting to improve probe
-- https://stackoverflow.com/questions/11062252/how-to-detect-collision-but-do-not-collide-in-box2d


local   Object      = require( "src/Objects/Object" )
        ObjectPool  = require "src/Objects/Pools/ObjectPool"


local Probe = {}
setmetatable( Probe, Object )
Probe.__index = Probe


-- ==========================================Build/Destroy


function Probe:New( iWorld, iX, iY, iDirectionVector, iCallback, iCaller )

    newProbe = {}
    setmetatable( newProbe, Probe )
    Probe.__index = Probe

    newProbe:BuildProbe( iWorld, iX, iY, iDirectionVector, iCallback, iCaller )

    return  newProbe
end


function  Probe:BuildProbe( iWorld, iX, iY, iDirectionVector, iCallback, iCaller )

    self.x = iX
    self.y = iY
    self.w = 1
    self.h = 1

    self.needDestroy = false

    self.body   = love.physics.newBody( iWorld, iX, iY, "dynamic" )
    self.body:setFixedRotation( false )
    self.body:setLinearVelocity( iDirectionVector.x, iDirectionVector.y )
    self.body:setGravityScale( 0.0 )


    shape       = love.physics.newRectangleShape( 1, 1 )
    fixture     = love.physics.newFixture( self.body, shape )
    fixture:setCategory( 10 )
    fixture:setMask( 2, 10 )
    fixture:setUserData( self )

    self.callback   = iCallback
    self.caller     = iCaller

    ObjectPool.AddObject( self )

end

-- ==========================================Type


function  Probe:Type()
    return "Probe"
end


-- ==========================================Update/Draw


function  Probe:Update( iDT )

end


function  Probe:Draw()
end


-- ==========================================Callbacks


function Probe:Collide( iObject )
    if( self.needDestroy == true ) then  return  end
    self.callback( self.caller, self.body:getX(),  self.body:getY() )
    self.body:setActive( false )
    self:Destroy()
end



return  Probe