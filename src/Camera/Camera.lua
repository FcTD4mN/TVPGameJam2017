

local Camera = {}


function  Camera:New( iX, iY, iW, iH, iScale )

    newCamera = {}
    setmetatable( newCamera, Camera )
    Camera.__index = Camera

    newCamera:BuildCamera( iX, iY, iW, iH, iScale )

    return  newCamera

end


function Camera:NewFromXML( iNode )
    local newCamera = {}
    setmetatable( newCamera, Camera )
    Camera.__index = Camera

    newCamera:LoadCameraXML( iNode )

    return newCamera
end


function  Camera:BuildCamera( iX, iY, iW, iH, iScale )

    self.mX = iX
    self.mY = iY
    self.mW = iW
    self.mH = iH

    self.mScale = iScale

end


function  Camera:MapToScreen( iX, iY )

    deltaW = ( self.mW - self.mW * self.mScale ) / 2
    deltaH = ( self.mH - self.mH * self.mScale ) / 2

    return  ( iX * self.mScale ) - ( self.mX * self.mScale ) + deltaW,
            ( iY * self.mScale ) - ( self.mY * self.mScale ) + deltaH

end


-- To interface Box2d
function  Camera:MapToScreenMultiple( ... )
    count = select("#", ... )

    if( count % 2 ~= 0 ) then
        return  0
    end

    results = {}
    for i = 1, count, 2 do
        x = select( i, ... )
        y = select( i + 1, ... )
        x, y = self:MapToScreen( x, y )
        table.insert( results, x )
        table.insert( results, y )
    end

    -- return  results
    return  unpack( results )

end


function  Camera:Scale()

    return  self.mScale

end


function  Camera:MapToWorld( iX, iY )

    deltaW = ( self.mW - self.mW * self.mScale ) / 2
    deltaH = ( self.mH - self.mH * self.mScale ) / 2

    return  ( iX + ( ( self.mX * self.mScale ) - deltaW ) ) / self.mScale,
            ( iY + ( ( self.mY * self.mScale ) - deltaH ) ) / self.mScale

end


function  Camera:SetScale( iScale )

    scale = iScale
    if( scale < 0.05 ) then
        scale = 0.05
    end

    self.mScale = scale

end


-- ==========================================XML IO


function  Camera:SaveCameraXML()

    xmlData = "<camera " .. "x='" .. self.mX .. "' " ..
                            "y='" .. self.mY .. "' " ..
                            "w='" .. self.mW .. "' " ..
                            "h='" .. self.mH .. "' " ..
                            "scale='" .. self.mScale .. "' " ..
                            " />\n"

    return  xmlData

end


function  Camera:LoadCameraXML( iNode )

    assert( iNode.name == "camera" )

    self.mX  = iNode.attr[ 1 ].value
    self.mY  = iNode.attr[ 2 ].value
    self.mW  = iNode.attr[ 3 ].value
    self.mH  = iNode.attr[ 4 ].value
    self.mScale  = iNode.attr[ 5 ].value

end


return  Camera