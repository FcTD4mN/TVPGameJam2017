local Point             = require( "src/Math/Point" )

local Polygon = {}


-- OBJECT INITIALISATION ==============================================
function  Polygon:New()
    newPolygon = {}
    setmetatable( newPolygon, self )
    self.__index = self

    newPolygon.mVertexes = {}

    return  newPolygon
end


-- DRAW/UPDATE ==============================================
function Polygon:Draw( iCamera )

    love.graphics.polygon( "line", self:GetAsVertexesList() )

end


-- POLYGON MANAGEMENT ==============================================
function  Polygon:AddPoint( iPt )

    table.insert( self.mVertexes, iPt )

end


function  Polygon:GetPoints()

    return  self.mVertexes

end


function  Polygon:GetAsVertexesList()

    local verticesSplit = {}
    for k,v in pairs( self.mVertexes ) do
        table.insert( verticesSplit, v.mX )
        table.insert( verticesSplit, v.mY )
    end

    return  verticesSplit

end


function Polygon:RotateClockwise( iPtCenter, iAngle )

    local sinAngle = math.sin( iAngle )
    local cosAngle = math.cos( iAngle )

    for k,v in pairs( self.mVertexes ) do

        local xOrigin, yOrigin = v.mX - iPtCenter.mX, v.mY - iPtCenter.mY
        v.mX = ( xOrigin * cosAngle - yOrigin * sinAngle ) + iPtCenter.mX
        v.mY = ( xOrigin * sinAngle + yOrigin * cosAngle ) + iPtCenter.mY

    end

end


function  Polygon:IsConvex()

    -- Useless as love already provides one .....
    -- Maybe love's one is too slow and we'll then need to actually do this ourselves.
    -- To be checked..
    local point1, point2, point3, angle

    for i = 1, #self.mVertexes do

        point1 = self.mVertexes[ (i % #self.mVertexes) + 1 ]
        point2 = self.mVertexes[ i ]
        point3 = Point:New( point2.mX + 10, point2.mY )
        angle  = Math.GetAngle( point1, point2, point3 )

        if point1.mY > point2.mY then
            angle =  math.pi*2 - angle
        end

        self:RotateClockwise( point2, angle )

        for k,v in pairs( self.mVertexes ) do
            if v.mY - point2.mY > 1/10000 then
                return  false
            end
        end

    end

    return  true

end


return  Polygon