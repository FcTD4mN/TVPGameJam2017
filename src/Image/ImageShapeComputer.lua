local Rectangle = require "src/Math/Rectangle"
local Point = require "src/Math/Point"

local ImageShapeComputer = {}

function ImageShapeComputer:New( iFile, iThresold )
    local newImageShapeComputer = {}
    setmetatable( newImageShapeComputer, self )
    self.__index = self

    newImageShapeComputer.imageData = love.image.newImageData( iFile )
    newImageShapeComputer.w = newImageShapeComputer.imageData:getWidth()
    newImageShapeComputer.h = newImageShapeComputer.imageData:getHeight()
    newImageShapeComputer.images = {}
    newImageShapeComputer.rectangles = {}

    newImageShapeComputer.tileHeight = 720/3

    newImageShapeComputer:Split()
    
    newImageShapeComputer.pointsCeiling = {}
    newImageShapeComputer.pointsMiddleTop = {}
    newImageShapeComputer.pointsMiddleBot = {}
    newImageShapeComputer.pointsFloor = {}

    newImageShapeComputer.pointCount = 0

    newImageShapeComputer:ProcessShapes( iThresold )

    return newImageShapeComputer
end


function  ImageShapeComputer:Split()

    imageWidth = self.w
    imageHeight = self.tileHeight
    tileHeight = self.tileHeight

    steps = math.floor( self.h / (tileHeight -1) -1 )
    for i = 0, steps, 1 do

        if i * tileHeight > self.h - tileHeight then
            imageHeight = self.h - i * tileHeight
        end

        imageData = love.image.newImageData( imageWidth, tileHeight )

        for j = 0, imageWidth - 1, 1 do
            for k = 0, imageHeight - 1, 1 do
                
                r, g, b, a = self.imageData:getPixel( j, i * tileHeight + k )
                imageData:setPixel( j, k, r, g, b, a )
            end
        end

        image = love.graphics.newImage( imageData )

        self.images[i] = imageData
        self.rectangles[i] = Rectangle:New( 0, i * tileHeight , imageWidth, imageHeight )
    end
end


function  ImageShapeComputer:ProcessShapes( pas )

    imageWidth = self.w
    imageHeight = self.h
    tileHeight = self.tileHeight

    steps = math.floor( imageWidth / pas - 1 )
    self.pointCount = steps

    for i = 0, steps , 1 do 
        for j = 0, tileHeight-1, 1 do
            tpx = i*pas
            
            tpy = tileHeight - 1 - j
            r1, g1, b1, a1 = self.images[0]:getPixel( tpx, tpy )
            if a1 > 127 then
                self.pointsCeiling[i] = Point:New( tpx, tpy )
                break
            end

        end
    end

    for i = 0, steps , 1 do 
        for j = 0, tileHeight-1, 1 do
            tpx = i*pas
            
            tpy = j
            r1, g1, b1, a1 = self.images[1]:getPixel( tpx, tpy )
            if a1 > 127 then
                self.pointsMiddleTop[i] = Point:New( tpx, tpy + tileHeight )
                break
            end

        end
    end

    for i = 0, steps , 1 do 
        for j = 0, tileHeight-1, 1 do
            tpx = i*pas
            
            tpy = tileHeight - 1 - j
            r1, g1, b1, a1 = self.images[1]:getPixel( tpx, tpy )
            if a1 > 127 then
                self.pointsMiddleBot[i] = Point:New( tpx, tpy + tileHeight )
                break
            end

        end
    end

    for i = 0, steps , 1 do 
        for j = 0, tileHeight-1, 1 do
            tpx = i*pas
            
            tpy = j
            r1, g1, b1, a1 = self.images[2]:getPixel( tpx, tpy )
            if a1 > 127 then
                self.pointsFloor[i] = Point:New( tpx, tpy + tileHeight * 2 )
                break
            end

        end
    end

end

return ImageShapeComputer