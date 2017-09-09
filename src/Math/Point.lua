--[[=================================================================== 
    File: Math.Point.lua

    @@@@: Basic Point.
    point 2D, decimal values x & y

===================================================================--]]

-- INCLUDES ===========================================================
-- NONE

-- OBJECT INITIALISATION ==============================================
local Point = {}

function  Point:New( iX, iY )
    newPoint = {}
    setmetatable( newPoint, self )
    self.__index = self

    newPoint.x = iX
    newPoint.y = iY

    return  newPoint
end

-- OBJECT FUNCTIONS ===================================================
function Point:Type()
    return "Point"
end

-- RETURN CHUNK AS GLOBAL OBJECT ======================================
return  Point