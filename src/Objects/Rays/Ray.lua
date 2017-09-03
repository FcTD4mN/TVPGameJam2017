local   Camera      = require( "src/Camera/Camera" )
local   Object      = require( "src/Objects/Object" )
        ObjectPool  = require( "src/Objects/ObjectPool" )
local   Vector      = require( "src/Math/Vector" )


local Ray = {}


-- ==========================================Build/Destroy


function Ray:New( iX, iY, iWidth, iLength )

    newRay = {}
    setmetatable( newRay, Ray )
    Ray.__index = Ray

    newRay:BuildRay( iX, iY, iWidth, iLength )

    return  newRay
end


function  Ray:BuildRay( iX, iY, iWidth, iLength )

    self.x = iX
    self.y = iY
    self.width = iWidth     -- This is how wide the ray is
    self.length = iLength   -- This is how long the ray is

    -- Start of the top and bottom part of the ray
    self.topYStart      = self.y - self.width / 2
    self.bottomYStart   = self.y  + self.width / 2

    --                                                                                                      Start          End
    -- Thses are the two points that represent the end contact points of the ray against a surface :   Hero-> O=============/ <-Wall
    self.topEndX    = self.x + self.length
    self.topEndY    = self.topYStart
    self.bottomEndX = self.x + self.length
    self.bottomEndY = self.bottomYStart

    self.animations = {}
    self.currentAnimation = 0

end

-- ==========================================Type


function  Ray:Type()
    return "Ray"
end


-- ==========================================Update/Draw


function  Ray:Update( iDT )

    foundContact = { false, false }
    for i = 1, ObjectPool.Count() do

        local fixtures = ObjectPool.ObjectAtIndex( i ).body:getFixtureList()
        for k,v in pairs( fixtures ) do

            -- 5th parameter is the max fraction as a scale of line length, so, we want its length to be 1.0 of the line length
            local topHitVectorX, topHitVectorY, topFraction           = v:rayCast( self.x, self.topYStart,       self.x + self.length, self.topYStart, 1.0 )
            local bottomHitVectorX, bottomHitVectorY, bottomFraction  = v:rayCast( self.x, self.bottomYStart,    self.x + self.length, self.bottomYStart, 1.0 )

            if( topFraction ) then
                self.topEndX = self.x + self.length * topFraction
                self.topEndY = self.topYStart
                foundContact[ 1 ] = true
            end
            if( bottomFraction ) then
                self.bottomEndX = self.x + self.length * bottomFraction
                self.bottomEndY = self.bottomYStart
                foundContact[ 2 ] = true
            end

        end

        if( foundContact[ 1 ] and foundContact[ 2 ] ) then
            break
        end

        if( foundContact[ 1 ] == false ) then
            self.topEndX = self.x + self.length
            self.topEndY = self.topYStart
        end
        if( foundContact[ 2 ] == false ) then
            self.bottomEndX = self.x + self.length
            self.bottomEndY = self.bottomYStart
        end

    end

end


function  Ray:Draw()

    love.graphics.polygon( "fill", Camera.MapToScreenMultiple( self.x, self.bottomYStart, self.x, self.topYStart, self.topEndX, self.topYStart, self.bottomEndX, self.bottomYStart ) )

end


-- ==========================================Ray functions




return  Ray