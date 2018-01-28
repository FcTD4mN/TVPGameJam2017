local Vector = {}


function Vector:New( iX, iY )
    newVector = {}
    setmetatable( newVector, self )
    self.__index = self

    newVector.x = iX
    newVector.y = iY

    return  newVector
end


function Vector:Type()
    return  "Vector"
end


function Vector:Normalized()
    normalizedVector = Vector:New( self.x, self.y )
    length = self:Length()
    normalizedVector.x = self.x / length
    normalizedVector.y = self.y / length

    return  normalizedVector
end


-- The 90 degree vector counter clockwise
function Vector:Normal()
    return  Vector:New( -self.y, self.x )
end

-- The 90 degree vector counter clockwise
function Vector:NormalCustom()
    return  Vector:New( self.y, self.x )
end


function Vector:Length()
    return  math.sqrt( self.x * self.x + self.y * self.y )
end


function Vector:LengthSquared()
    return  self.x * self.x + self.y * self.y
end


function  Vector:Add( iVector )
    self.x = self.x + iVector.x
    self.y = self.y + iVector.y
end


function  Vector:Sub( iVector )
    self.x = self.x - iVector.x
    self.y = self.y - iVector.y
end


function  Vector:SubstractionResult( iVector )
    local x = self.x - iVector.x
    local y = self.y - iVector.y
    return  Vector:New( x, y )
end


function Vector:Draw()
    love.graphics.line( 0, 0, self.x, self.y )
end

-- Operator * overload
function  Vector:__mul( iX )
    return  Vector:New( self.x * iX, self.y * iX )
end


return  Vector