Rectangle   = require( "src/Math/Rectangle" )


local MenuItem = {}

local sgHeight = 20


function  MenuItem:New( iText, iX, iY )
    newMenuItem = {}
    setmetatable( newMenuItem, self )
    self.__index = self

    -- Attributes
    newMenuItem.text = iText
    newMenuItem.font = love.graphics.newFont("resources/Fonts/Oswald/Oswald-Bold.ttf", 30 )
    newMenuItem.isCurrent = false
    newMenuItem.rectangle = Rectangle:New( iX, iY, newMenuItem.font:getWidth( iText ), newMenuItem.font:getHeight() )
    newMenuItem.actionCB = nil
    newMenuItem.sound = 0

    return  newMenuItem
end


function MenuItem:Draw()
    love.graphics.setFont( self.font )
    if( self.isCurrent ) then
        love.graphics.setColor( 55, 55, 55 )
    else
        love.graphics.setColor( 0, 0, 0 )
    end

    love.graphics.print( self.text, self.rectangle.x, self.rectangle.y )
end


function  MenuItem:Click()
    if self.actionCB then
        self.actionCB()
        if( self.sound ~= 0 ) then
            -- love.audio.play( self.sound )
        end
    end
end


function MenuItem:SetCallback( iFunction )
    self.actionCB = iFunction
end


function MenuItem:SetSound( iSound )
    self.sound = iSound
end


return  MenuItem