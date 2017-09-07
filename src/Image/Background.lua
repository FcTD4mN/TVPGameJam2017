local Camera        = require "src/Camera/Camera"
local Rectangle     = require "src/Math/Rectangle"
local BigImage      = require "src/Image/BigImage"

local sgTileWidth = 200

local Background = {}

function Background:New( iFile, iX, iY, iDepth )
    local newBackground = {}
    setmetatable( newBackground, self )
    self.__index = self

    newBackground.bigImage = BigImage:New( iFile, 200 )

    newBackground.originX = iX
    newBackground.originY = iY
    newBackground.x = iX
    newBackground.y = iY
    newBackground.w = newBackground.bigImage.w
    newBackground.h = newBackground.bigImage.h

    newBackground.rectangle = Rectangle:New( iX, iY, newBackground.w , newBackground.h )

    newBackground.depth = iDepth

    return newBackground
end


function  Background:Type()
    return "Background"
end

function  Background:Update( iDT, iCamera )
    self.x = self.originX + self.depth * iCamera.mX
end

function  Background:Draw( iCamera )
    love.graphics.setColor( 255, 255, 255, 255 )
    x, y = iCamera:MapToScreen( self.x, self.y )

    self.bigImage:Draw( x, y )
end


return Background