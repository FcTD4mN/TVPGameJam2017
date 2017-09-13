local Camera        = require "src/Camera/Camera"
local Rectangle     = require "src/Math/Rectangle"
local BigImage      = require "src/Image/BigImage"


local sgTileWidth = 200


local Background = {}


function Background:New( iFile, iX, iY, iDepth )
    local newBackground = {}
    setmetatable( newBackground, Background )
    Background.__index = Background

    newBackground.filename = iFile
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


function Background:NewFromXML( iNode )

    newBackground = {}
    setmetatable( newBackground, Background )
    Background.__index = Background

    newBackground:LoadBackgroundXML( iNode )

    return  newBackground

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


-- ==========================================XML IO


function  Background:SaveXML()
    return  self:SaveBackgroundXML()
end


function  Background:SaveBackgroundXML()

    xmlData = "<background " ..
                                "x='" .. self.x .. "' " ..
                                "y='" .. self.y .. "' " ..
                                "w='" .. self.w .. "' " ..
                                "h='" .. self.h .. "' " ..
                                "depth='" .. self.depth .. "' " ..
                                "file='" .. self.filename .. "' " ..
                                " />\n"

    return  xmlData

end


function  Background:LoadBackgroundXML( iNode )

    assert( iNode.name == "background" )

    self.originX = iNode.attr[ 1 ].value
    self.originY = iNode.attr[ 2 ].value
    self.x = self.originX
    self.y = self.originY
    self.w = iNode.attr[ 3 ].value
    self.h = iNode.attr[ 4 ].value
    self.depth = iNode.attr[ 5 ].value

    self.filename   = iNode.attr[ 6 ].value
    self.bigImage   = BigImage:New( self.filename, 200 )
    self.rectangle  = Rectangle:New( self.originX, self.originY, self.w , self.h )

end


return Background