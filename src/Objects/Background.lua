local Camera = require "src/Camera/Camera"
local Rectangle = require "src/Math/Rectangle"

local Background = {}

function Background:New( iFile, iX, iY, iW, iH )
    local newBackground = {}
    setmetatable( newBackground, self )
    self.__index = self

    newBackground.rectangle = Rectangle:New( iX, iY, iW, iH )
    newBackground.image = love.image.newImageData( iFile, iW, iH )
    newBackground.depth = 0 -- Doesn't move

    return newBackground
end


function  Background:Type()
    return "Background"
end

function  Background:Update( iDT )
    self.x = self.x + self.depth * Camera.x
end

function  Background:Draw()
    love.graphics.setColor( 255, 255, 255, 255 )
    x, y = Camera.MapToScreen( self.x, self.y )
    love.graphics.draw( self.image, x, y )
end


return Background