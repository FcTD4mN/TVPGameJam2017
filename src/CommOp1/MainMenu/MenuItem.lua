Rectangle   = require( "src/Math/Rectangle" )


local MenuItem = {}

local sgHeight = 20


function  MenuItem:New( iText, iX, iY, iColorR, iColorG, iColorB )
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
    newMenuItem.mColorR = iColorR
    newMenuItem.mColorG = iColorG
    newMenuItem.mColorB = iColorB

    return  newMenuItem
end


function MenuItem:Draw()
    love.graphics.setFont( self.font )
    if( self.isCurrent ) then
        love.graphics.setColor( iColorR + 30, iColorG + 30, iColorB + 30 )
    else
        love.graphics.setColor( iColorR, iColorG, iColorB )
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