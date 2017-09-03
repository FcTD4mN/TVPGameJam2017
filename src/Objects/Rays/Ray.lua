local   Camera      = require( "src/Camera/Camera" )
local   Object      = require( "src/Objects/Object" )
        ObjectPool  = require( "src/Objects/ObjectPool" )
local   Vector      = require( "src/Math/Vector" )


local Ray = {}


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

    -- Start of the top and bottom part of the ray
    self.topYStart      = self.y - self.width / 2
    self.bottomYStart   = self.y  + self.width / 2

    --                                                                                                      Start          End
    -- Thses are the two points that represent the end contact points of the ray against a surface :   Hero-> O=============/ <-Wall
    self.topEndX    = self.x + 1
    self.topEndY    = self.topYStart
    self.bottomEndX = self.x + 1
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

    doBreak = { false, false }
    for i = 1, ObjectPool.Count() do

        local fixtures = ObjectPool.ObjectAtIndex( i ).body:getFixtureList()
        for k,v in pairs( fixtures ) do

            -- 5th parameter is the max fraction as a scale of line length, so, we want its length to be 1.0 of the line length
            local topHitVectorX, topHitVectorY, topFraction           = v:rayCast( self.x, self.topYStart,       self.x + self.length, self.topYStart, 1.0 )
            local bottomHitVectorX, bottomHitVectorY, bottomFraction  = v:rayCast( self.x, self.bottomYStart,    self.x + self.length, self.bottomYStart, 1.0 )

            if( topFraction ) then
                self.topEndX = self.x + self.length * topFraction
                self.topEndY = self.topYStart
                doBreak[ 1 ] = true
            end
            if( bottomFraction ) then
                self.bottomEndX = self.x + self.length * bottomFraction
                self.bottomEndY = self.bottomYStart
                doBreak[ 2 ] = true
            end

        end

        if( doBreak[ 1 ] and doBreak[ 2 ] ) then
            break
        end

        -- Here, we didn't hit anything, so the ray gets its max size
        self.topEndX = self.x + self.length
        self.topEndY = self.topYStart
        self.bottomEndX = self.x + self.length
        self.bottomEndY = self.bottomYStart

    end

end


function  Ray:Draw()

    love.graphics.polygon( "fill", Camera.MapToScreenMultiple( self.x, self.bottomYStart, self.x, self.topYStart, self.topEndX, self.topYStart, self.bottomEndX, self.bottomYStart ) )

end


-- ==========================================Ray functions




return  Ray