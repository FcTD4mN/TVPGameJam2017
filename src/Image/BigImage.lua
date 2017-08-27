local Camera = require "src/Camera/Camera"
local Rectangle = require "src/Math/Rectangle"

local BigImage = {}

function BigImage:New( iFile )
    local newBigImage = {}
    setmetatable( newBigImage, self )
    self.__index = self

    
    self.image = love.image.newImageData( iFile )
    self.w = newBigImage.image:getWidth()
    self.h = newBigImage.image:getHeight()
    self.images = {}
    self.rectangles = {}

    self:Split( 20, 720 )
    

    return newBigImage
end


function  BigImage:Split( iWidth, iHeight )
     
    imageWidth = iWidth
    steps = math.ceil( self.w / iWidth -1 )
    for i = 0, steps, 1 do

        if i * iWidth > self.w - iWidth then
            imageWidth = self.w - i * iWidth
        end

        imageData = love.image.newImageData( imageWidth, iHeight )

        for j = 0, imageWidth - 1, 1 do
            for k = 0, iHeight - 1, 1 do
                r, g, b, a = self.image:getPixel( i * iWidth + j, k )
                imageData:setPixel( j, k, r, g, b, a )
            end
        end
        
        image = love.graphics.newImage( imageData )

        self.images[i] = image
        self.rectangles[i] = Rectangle:New( i*iWidth, 0, imageWidth, iHeight )
        -- table.insert( self.images, image )
        --table.insert( self.rectangles, Rectangle:New( i, 0, iWidth, iHeight ) )
    end

end

function  BigImage:Update( iDT )
   
end

function  BigImage:Draw()

    x,y = Camera.MapToScreen( 0, 0)
    print( x )
    windowW = love.graphics.getWidth()
    tileW = self.rectangles[0].w

    numberTiles = math.floor( windowW / tileW )
    firstTile = math.floor( -x / tileW )
    if firstTile < 0 then
        firstTile = 0
    end
    
    lastTile = firstTile + numberTiles
    for i = firstTile, lastTile, 1 do

        tx = x + self.rectangles[i].x
        ty = y + self.rectangles[i].y
    
        love.graphics.draw( self.images[i], tx, ty )
    end

end


return BigImage