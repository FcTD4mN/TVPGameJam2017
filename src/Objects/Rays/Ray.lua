local   Camera      = require( "src/Camera/Camera" )
local   Object      = require( "src/Objects/Object" )
        ObjectPool  = require( "src/Objects/Pools/ObjectPool" )
        RayPool     = require( "src/Objects/Pools/RayPool" )
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

    self.mDirectionVector = iDirectionVector:Normalized()
    local normalVector = self.mDirectionVector:Normal()

    -- Start of the top and bottom part of the ray
    self.mTopXStart      = self.mX + normalVector.x * self.mWidth / 2
    self.mTopYStart      = self.mY + normalVector.y * self.mWidth / 2

    self.mBottomXStart   = self.mX  - normalVector.x * self.mWidth / 2
    self.mBottomYStart   = self.mY  - normalVector.y * self.mWidth / 2

    --                                                                                                      Start          End
    -- Theses are the two points that represent the end contact points of the ray against a surface :   Hero-> O=============/ <-Wall
    self.mTopEndX    = self.mTopXStart + self.mDirectionVector.x * self.mLength
    self.mTopEndY    = self.mTopYStart + self.mDirectionVector.y * self.mLength
    self.mBottomEndX = self.mBottomXStart + self.mDirectionVector.x * self.mLength
    self.mBottomEndY = self.mBottomYStart + self.mDirectionVector.y * self.mLength


    self.mAnimations = {}
    self.mCurrentAnimation = 0

    RayPool.AddRay( self )

end

-- ==========================================Type


function  Ray:Type()
    return "Ray"
end


-- ==========================================Update/Draw


function  Ray:Update( iDT )

    topShortestLength       = 1.0
    bottomShortestLength    = 1.0

    -- These are the virtual position of the end of the ray if there was no collision, so the ray we want to cast
    local topEndX    = self.mTopXStart + self.mDirectionVector.x * self.mLength
    local topEndY    = self.mTopYStart + self.mDirectionVector.y * self.mLength
    local bottomEndX = self.mBottomXStart + self.mDirectionVector.x * self.mLength
    local bottomEndY = self.mBottomYStart + self.mDirectionVector.y * self.mLength


    for i = 1, ObjectPool.Count() do

        local fixtures = ObjectPool.ObjectAtIndex( i ).mBody:getFixtureList()
        for k,v in pairs( fixtures ) do

            -- 5th parameter is the max fraction as a scale of line length, so, we want its length to be 1.0 of the line length
            local topHitVectorX, topHitVectorY, topFraction           = v:rayCast( self.mTopXStart, self.mTopYStart,        topEndX, topEndY,       1.0 )
            local bottomHitVectorX, bottomHitVectorY, bottomFraction  = v:rayCast( self.mBottomXStart, self.mBottomYStart,  bottomEndX, bottomEndY, 1.0 )

            if( topFraction and topFraction < topShortestLength ) then
                topShortestLength = topFraction
            end
            if( bottomFraction and bottomFraction < bottomShortestLength ) then
                bottomShortestLength = bottomFraction
            end

        end

        self.mTopEndX = self.mTopXStart + self.mDirectionVector.x * self.mLength * topShortestLength
        self.mTopEndY = self.mTopYStart + self.mDirectionVector.y * self.mLength * topShortestLength
        self.mBottomEndX = self.mBottomXStart + self.mDirectionVector.x * self.mLength * bottomShortestLength
        self.mBottomEndY = self.mBottomYStart + self.mDirectionVector.y * self.mLength * bottomShortestLength

    end

end


function  Ray:Draw( iCamera )

    love.graphics.setColor( 255, 20, 20 )
    love.graphics.polygon( "fill", iCamera:MapToScreenMultiple( self.mBottomXStart, self.mBottomYStart, self.mTopXStart, self.mTopYStart, self.mTopEndX, self.mTopEndY, self.mBottomEndX, self.mBottomEndY ) )

end


-- ==========================================Ray functions




return  Ray