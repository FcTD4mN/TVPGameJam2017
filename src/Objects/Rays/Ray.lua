local   Camera      = require( "src/Camera/Camera" )
local   Object      = require( "src/Objects/Object" )
        ObjectPool  = require( "src/Objects/ObjectPool" )
local   Vector      = require( "src/Math/Vector" )


local Ray = {}


-- ==========================================Build/Destroy


function Ray:New( iX, iY, iDirectionVector, iWidth, iLength )

    newRay = {}
    setmetatable( newRay, Ray )
    Ray.__index = Ray

    newRay:BuildRay( iX, iY, iDirectionVector, iWidth, iLength )

    return  newRay
end


function  Ray:BuildRay( iX, iY, iDirectionVector, iWidth, iLength )

    self.mX = iX
    self.mY = iY
    self.mWidth = iWidth     -- This is how wide the ray is
    self.mLength = iLength   -- This is how long the ray is

    -- Start of the top and bottom part of the ray
    self.mTopYStart      = self.mY - self.mWidth / 2
    self.mBottomYStart   = self.mY  + self.mWidth / 2

    --                                                                                                      Start          End
    -- Thses are the two points that represent the end contact points of the ray against a surface :   Hero-> O=============/ <-Wall
    self.mTopEndX    = self.mX + self.mLength
    self.mTopEndY    = self.mTopYStart
    self.mBottomEndX = self.mX + self.mLength
    self.mBottomEndY = self.mBottomYStart

    self.mDirectionVector = iDirectionVector

    self.mAnimations = {}
    self.mCurrentAnimation = 0

end

-- ==========================================Type


function  Ray:Type()
    return "Ray"
end


-- ==========================================Update/Draw


function  Ray:Update( iDT )

    topShortestLength       = 1.0
    bottomShortestLength    = 1.0

    for i = 1, ObjectPool.Count() do

        local fixtures = ObjectPool.ObjectAtIndex( i ).body:getFixtureList()
        for k,v in pairs( fixtures ) do

            -- 5th parameter is the max fraction as a scale of line length, so, we want its length to be 1.0 of the line length
            local topHitVectorX, topHitVectorY, topFraction           = v:rayCast( self.mX, self.mTopYStart,       self.mX + self.mLength, self.mTopYStart, 1.0 )
            local bottomHitVectorX, bottomHitVectorY, bottomFraction  = v:rayCast( self.mX, self.mBottomYStart,    self.mX + self.mLength, self.mBottomYStart, 1.0 )

            if( topFraction and topFraction < topShortestLength ) then
                topShortestLength = topFraction
            end
            if( bottomFraction and bottomFraction < bottomShortestLength ) then
                bottomShortestLength = bottomFraction
            end

        end

        self.mTopEndX = self.mX + self.mLength * topShortestLength
        self.mTopEndY = self.mTopYStart
        self.mBottomEndX = self.mX + self.mLength * bottomShortestLength
        self.mBottomEndY = self.mBottomYStart

    end

end


function  Ray:Draw()

    love.graphics.polygon( "fill", Camera.MapToScreenMultiple( self.mX, self.mBottomYStart, self.mX, self.mTopYStart, self.mTopEndX, self.mTopYStart, self.mBottomEndX, self.mBottomYStart ) )

end


-- ==========================================Ray functions




return  Ray