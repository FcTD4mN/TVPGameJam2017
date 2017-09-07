
local Camera    = require( "src/Camera/Camera" )

local MiniMap = {}


function  MiniMap:New( iX, iY, iW, iH, iScale )

    newMiniMap = {}
    setmetatable( newMiniMap, MiniMap )
    MiniMap.__index = MiniMap

    newMiniMap:BuildMiniMap( iX, iY, iW, iH, iScale )

    return  newMiniMap

end


function  MiniMap:BuildMiniMap( iX, iY, iW, iH, iScale )

    self.mX = iX
    self.mY = iY
    self.mW = iW
    self.mH = iH

    self.mCamera = Camera:New( 0, 0, love.graphics.getWidth(), love.graphics.getHeight(), iScale )

end


function  MiniMap:Draw( iCamera )

    -- Draws the minimap ( the contour only, leave center blank so objects can draw themselves into it )
    love.graphics.setColor( 20, 255, 100 )
    love.graphics.rectangle( "fill", self.mX, self.mY, self.mW, self.mH )

    -- The camera outline
    love.graphics.setColor( 20, 100, 255 )
    cameraX, cameraY = self:MapToScreen( iCamera.mX, iCamera.mY )
    love.graphics.rectangle( "line", cameraX, cameraY, iCamera.mW * self.mCamera.mScale, iCamera.mH * self.mCamera.mScale )

end


function  MiniMap:MapToScreen( iX, iY )

    centerMiniMapX = self.mX + self.mW / 2
    centerMiniMapY = self.mY + self.mH / 2
    centerMMCameraX = self.mCamera.mW / 2
    centerMMCameraY = self.mCamera.mH / 2

    offsetX = centerMMCameraX - centerMiniMapX
    offsetY = centerMMCameraY - centerMiniMapY

    x, y = self.mCamera:MapToScreen( iX, iY )


    return  x - offsetX, y - offsetY
end

return  MiniMap