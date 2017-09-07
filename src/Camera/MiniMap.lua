
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

    self.mCamera = Camera:New( 0, 0, iW, iH, iScale )

end

function  MiniMap:Draw()

    margin = 5

    -- Draws the minimap ( the contour only, leave center blank so objects can draw themselves into it )
    love.graphics.setColor( 20, 255, 100 )
    love.graphics.rectangle( "fill", self.mX - margin, self.mY - margin, self.mW + margin*2, self.mH + margin*2 )

end


return  MiniMap