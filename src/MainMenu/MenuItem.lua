Rectangle   = require( "src/Math/Rectangle" )


local MenuItem = {}

function  MenuItem:New( iText, iX, iY )
    newMenuItem = {}
    setmetatable( newMenuItem, self )
    self.__index = self

    -- Attributes
    newMenuItem.text = iText
    newMenuItem.isCurrent = false
    newMenuItem.rectangle = Rectangle:New( iX, iY, 50, 10 )

    return  newMenuItem
end

function MenuItem:Draw()
    if( self.isCurrent ) then
        love.graphics.setColor( 255, 0, 0 )
    else
        love.graphics.setColor( 0, 255, 0 )
    end
    print( self.rectangle.x )
    love.graphics.print( self.text, self.rectangle.x, self.rectangle.y )
end


return  MenuItem