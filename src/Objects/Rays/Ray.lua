local   Object      = require( "src/Objects/Object" )
        ObjectPool  = require "src/Objects/ObjectPool"
local   Probe       = require( "src/Objects/Projectiles/Probe" )
local   Vector      = require( "src/Math/Vector" )



local Ray = {}
setmetatable( Ray, Object )
Ray.__index = Ray


-- ==========================================Build/Destroy


function Ray:New( iWorld, iX, iY, iWidth, iLength )

    newRay = {}
    setmetatable( newRay, Ray )
    Ray.__index = Ray

    newRay:BuildRay( iWorld, iX, iY, iWidth, iLength )

    return  newRay
end


function  Ray:BuildRay( iWorld, iX, iY, iWidth, iLength )

    self.x = iX
    self.y = iY
    self.w = 0  -- This is inherited width, which is width of the object in the world
    self.h = 0  -- This is inherited height, which is height of the object in the world


    self.width = iWidth -- This is how wide the ray is
    self.length = iLength -- This is how long the ray is

    --                                                                                                      Start          End
    -- Thses are the two points that represent the end contact points of the ray against a surface :   Hero-> O=============/ <-Wall

    self.topEndX = 1
    self.topEndY = self.width/2 + 1
    self.bottomEndX = 1
    self.bottomEndY = -self.width/2 + 1


    self.body        = love.physics.newBody( iWorld, iX, iY, "static" )
    self.body:setFixedRotation( true )
    self.body:setLinearVelocity( 0, 0 )
    self.body:setGravityScale( 0.0 )

    shape           = love.physics.newEdgeShape( 0, -iWidth/2, 0, iWidth/2 )
    self.fixture    = love.physics.newFixture( self.body, shape )
    self.fixture:setFriction( 1.0 )
    self.fixture:setCategory( 2 )
    self.fixture:setMask( 10 )
    self.fixture:setUserData( self )

    self.animations = {}
    self.currentAnimation = 0

    ObjectPool.AddObject( self )

end

-- ==========================================Type


function  Ray:Type()
    return "Ray"
end


-- ==========================================Update/Draw


function  Ray:Update( iDT )

    --Send probes
    probesDirection = Vector:New( 300000, 0 )

    local topProbe    = Probe:New( self.body:getWorld(), self.x, self.y - self.width/2, probesDirection, TopProbeCallback, self )
    local bottomProbe = Probe:New( self.body:getWorld(), self.x, self.y + self.width/2, probesDirection, BottomProbeCallback, self )


    self.fixture:destroy()
    self:ProcessShape()

end


function  Ray:Draw()
end


-- ==========================================Ray functions


function  TopProbeCallback( iRay, iX, iY )

    -- Coordinates of polygon are relative to body, so 0, 0 = self.x, self.y we need to adjust end points
    iRay.topEndX = iX - iRay.x
    iRay.topEndY = iY - iRay.y

end


function  BottomProbeCallback( iRay, iX, iY )

    -- Coordinates of polygon are relative to body, so 0, 0 = self.x, self.y we need to adjust end points
    iRay.bottomEndX = iX - iRay.x
    iRay.bottomEndY = iY - iRay.y

end


function  Ray:ProcessShape()

    shape           = love.physics.newPolygonShape( 0, self.width/2, 0, -self.width/2 , self.topEndX, self.topEndY, self.bottomEndX, self.bottomEndY )
    self.fixture    = love.physics.newFixture( self.body, shape )
    self.fixture:setFriction( 1.0 )
    self.fixture:setCategory( 2 )
    self.fixture:setMask( 1, 10 )
    self.fixture:setUserData( self )

end



return  Ray