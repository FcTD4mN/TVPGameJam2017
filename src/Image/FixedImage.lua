local Camera = require "src/Camera/Camera"

local FixedImage = {}

function FixedImage:New( iFile, iX, iY, iW, iH, iAngle, iLockedOnScreen )
    local newFixedImage = {}
    setmetatable( newFixedImage, self )
    self.__index = self


    newFixedImage.image = love.graphics.newImage( iFile )
    newFixedImage.x = iX
    newFixedImage.y = iY
    newFixedImage.w = iW
    newFixedImage.h = iH
    newFixedImage.angle = iAngle
    newFixedImage.lockedOnScreen = iLockedOnScreen

    return newFixedImage
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


return FixedImage