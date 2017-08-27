local Rectangle = {}


function  Rectangle:New( iX, iY, iW, iH )
    newRect = {}
    setmetatable( newRect, self )
    self.__index = self

    newRect.x = iX
    newRect.y = iY
    newRect.w = iW
    newRect.h = iH

    newRect.x2 = iX + iW -- So we don't need to compute it 1000 times
    newRect.y2 = iY + iH -- So we don't need to compute it 1000 times

    return  newRect
end


function  Rectangle:ContainsPoint( iX, iY )
    if iX < self.x  then  return  false end
    if iY < self.y  then  return  false end
    if iX > self.x2 then  return  false end
    if iY > self.y2 then  return  false end

    return  true
end

return  Rectangle