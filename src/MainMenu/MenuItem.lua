Rectangle   = require( "src/Math/Rectangle" )


local MenuItem = {}

local sgHeight = 10

function  MenuItem:New( iText, iX, iY )
    newMenuItem = {}
    setmetatable( newMenuItem, self )
    self.__index = self

    -- Attributes
    newMenuItem.text = iText
    newMenuItem.isCurrent = false
    newMenuItem.rectangle = Rectangle:New( iX, iY, 50, sgHeight )
    newMenuItem.actionCB = 0

    return  newMenuItem
end

function MenuItem:Draw()
    if( self.isCurrent ) then
        love.graphics.setColor( 255, 0, 0 )
    else
        love.graphics.setColor( 0, 255, 0 )
    end

    love.graphics.print( self.text, self.rectangle.x, self.rectangle.y - sgHeight / 2 )
end

function  MenuItem:Click()
    self.actionCB()
end

function MenuItem:SetCallback( iFunction )
    self.actionCB = iFunction
end


return  MenuItem