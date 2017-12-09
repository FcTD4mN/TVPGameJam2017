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


function  Rectangle:SetX( iX )
    self.x = iX
    self.x2 = iX + self.w
end


function  Rectangle:SetY( iY )
    self.y = iY
    self.y2 = iY + self.h
end


function  Rectangle:SetX2( iX )
    self.x2 = iX

    if self.x2 < self.x then
        self.x2 = self.x
        self.x = iX
    end
    self.w = self.x2 - self.x
end


function  Rectangle:SetY2( iY )
    self.y2 = iY

    if self.y2 < self.y then
        self.y2 = self.y
        self.y = iY
    end
    self.h = self.y2 - self.y
end


function  Rectangle:SetW( iW )
    self.w = iW
    self.x2 = self.x + iW
end


function  Rectangle:SetH( iH )
    self.h = iH
    self.y2 = self.y + iH
end

function  Rectangle:Clear()
    self.x = 0
    self.y = 0
    self.w = 0
    self.h = 0
end


function  Rectangle:ContainsPoint( iX, iY )

    if iX < self.x  then  return  false end
    if iY < self.y  then  return  false end
    if iX > self.x2 then  return  false end
    if iY > self.y2 then  return  false end

    return  true

end


function  Rectangle:ContainsRectangleEntirely( iRectangle )

    if iRectangle.x < self.x  then  return  false end
    if iRectangle.y < self.y  then  return  false end
    if iRectangle.x2 > self.x2 then  return  false end
    if iRectangle.y2 > self.y2 then  return  false end

    return  true

end

return  Rectangle