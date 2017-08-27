local Camera = require "src/Camera/Camera"
local Rectangle = require "src/Math/Rectangle"

local Background = {}

function Background:New( iFile, iX, iY, iW, iH, iDepth )
    local newBackground = {}
    setmetatable( newBackground, self )
    self.__index = self


    newBackground.originX = iX
    newBackground.originY = iY
    newBackground.x = iX
    newBackground.y = iY
    newBackground.w = iW
    newBackground.h = iH

    newBackground.rectangle = Rectangle:New( iX, iY, iW, iH )
    newBackground.image = love.graphics.newImage( iFile )
    newBackground.depth = iDepth

    return newBackground
end


function  Background:Type()
    return "Background"
end

function  Background:Update( iDT )
    self.x = self.originX + self.depth * Camera.x
end

function  Background:Draw()
    love.graphics.setColor( 255, 255, 255, 255 )
    x, y = Camera.MapToScreen( self.x, self.y )
    love.graphics.draw( self.image, x, y )
end


return Background