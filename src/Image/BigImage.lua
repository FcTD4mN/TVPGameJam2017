local Camera = require "src/Camera/Camera"
local Rectangle = require "src/Math/Rectangle"

local BigImage = {}

function BigImage:New( iFile, iTileWidth )
    local newBigImage = {}
    setmetatable( newBigImage, self )
    self.__index = self


    newBigImage.imageData = love.image.newImageData( iFile )
    newBigImage.w = newBigImage.imageData:getWidth()
    newBigImage.h = newBigImage.imageData:getHeight()
    newBigImage.images = {}
    newBigImage.rectangles = {}

    newBigImage.tileWidth = iTileWidth

    newBigImage:Split( iTileWidth )

    return newBigImage
end

function  BigImage:Image( iQuad )
    x, y, w, h = iQuad:getViewport( )
    imageIndex = math.floor( x / self.tileWidth )
    return self.images[ imageIndex ]
end

function  BigImage:Split( iTileWidth )

    imageWidth = iTileWidth
    imageHeight = self.h
    steps = math.ceil( self.w / iTileWidth -1 )
    for i = 0, steps, 1 do

        if i * iTileWidth > self.w - iTileWidth then
            imageWidth = self.w - i * iTileWidth
        end

        imageData = love.image.newImageData( imageWidth, imageHeight )

        for j = 0, imageWidth - 1, 1 do
            for k = 0, imageHeight - 1, 1 do
                r, g, b, a = self.imageData:getPixel( i * iTileWidth + j, k )
                imageData:setPixel( j, k, r, g, b, a )
            end
        end

        image = love.graphics.newImage( imageData )

        self.images[i] = image
        self.rectangles[i] = Rectangle:New( i*iTileWidth, 0, imageWidth, imageHeight )
    end

end

function  BigImage:Update( iDT )

end

function  BigImage:Draw( dx, dy )

    --x,y = Camera.MapToScreen( 0, 0)

    windowW = love.graphics.getWidth()
    tileW = self.tileWidth

    numberTiles = math.ceil( windowW / tileW )
    firstTile = math.floor( -dx / tileW )
    if firstTile < 0 then
        firstTile = 0
    end

    lastTile = firstTile + numberTiles

    if lastTile > #self.images then
        lastTile = #self.images
    end

    for i = firstTile, lastTile, 1 do

        tx = dx + self.rectangles[i].x
        ty = dy + self.rectangles[i].y

        love.graphics.draw( self.images[i], tx,  ty )
    end

end


return BigImage