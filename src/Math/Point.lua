local Point = {}


function  Point:New( iX, iY )
    newPoint = {}
    setmetatable( newPoint, self )
    self.__index = self

    newPoint.x = iX
    newPoint.y = iY

    return  newPoint
end

return  Point