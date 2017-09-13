local Camera = require "src/Camera/Camera"

local FixedImage = {}

function FixedImage:New( iFile, iX, iY, iW, iH, iAngle, iLockedOnScreen )
    local newFixedImage = {}
    setmetatable( newFixedImage, self )
    self.__index = self


    newFixedImage.filename = iFile
    newFixedImage.image = love.graphics.newImage( iFile )
    newFixedImage.x = iX
    newFixedImage.y = iY
    newFixedImage.w = iW
    newFixedImage.h = iH
    newFixedImage.angle = iAngle
    newFixedImage.lockedOnScreen = iLockedOnScreen

    return newFixedImage
end


function FixedImage:NewFromXML( iNode )

    newFixedImage = {}
    setmetatable( newFixedImage, FixedImage )
    FixedImage.__index = FixedImage

    newFixedImage:LoadFixedImageXML( iNode )

    return  newFixedImage

end


function  FixedImage:Draw( iCamera )

    scaleX = self.w / self.image:getWidth()
    scaleY = self.h / self.image:getHeight()
    x = self.x
    y = self.y

    if( self.lockedOnScreen == false ) then
        x, y = iCamera:MapToScreen( x, y )
        scaleX = scaleX * iCamera.mScale
        scaleY = scaleY * iCamera.mScale
    end

    love.graphics.setColor( 255, 255, 255, 255 )
    love.graphics.draw( self.image, x, y, self.angle, scaleX, scaleY )

end


-- ==========================================XML IO


function  FixedImage:SaveXML()
    return  self:SaveFixedImageXML()
end


function  FixedImage:SaveFixedImageXML()

    xmlData = "<fixedimage " ..
                                "x='" .. self.x .. "' " ..
                                "y='" .. self.y .. "' " ..
                                "w='" .. self.w .. "' " ..
                                "h='" .. self.h .. "' " ..
                                "angle='" .. self.angle .. "' " ..
                                "lockedonscreen='" .. tostring( self.lockedOnScreen ) .. "' " ..
                                "filename='" .. self.filename .. "' " ..
                                " />\n"

    return  xmlData

end


function  FixedImage:LoadFixedImageXML( iNode )

    assert( iNode.name == "fixedimage" )

    self.x = iNode.attr[ 1 ].value
    self.y = iNode.attr[ 2 ].value
    self.w = iNode.attr[ 3 ].value
    self.h = iNode.attr[ 4 ].value
    self.angle = iNode.attr[ 5 ].value
    self.lockedOnScreen = iNode.attr[ 6 ].value
    self.filename   = iNode.attr[ 7 ].value

    self.image = love.graphics.newImage( self.filename )

end


return FixedImage