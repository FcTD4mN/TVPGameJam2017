MenuItem   = require( "src/MainMenu/MenuItem" )

local MenuPage = {}


function  MenuPage:New()
    newMenuPage = {}
    setmetatable( newMenuPage, self )
    self.__index = self

    -- Attributes
    newMenuPage.items = {}

    return  newMenuPage
end


function  MenuPage:AddItem( iMenuItem )
    table.insert( self.items, iMenuItem )
end


function MenuPage:HighlightItemUnderMouse()
    x, y = love.mouse.getPosition()
    for k,v in pairs( self.items ) do
        if( v.rectangle:ContainsPoint( x, y ) ) then
            v.isCurrent = true
        else
            v.isCurrent = false
        end
    end
end


function MenuPage:GetItemUnderMouse()
    x, y = love.mouse.getPosition()
    for k,v in pairs( self.items ) do
        if( v.rectangle:ContainsPoint( x, y ) ) then
            return  v
        end
    end

    return  "none"
end

function MenuPage:Draw()
    for k,v in pairs( self.items ) do
        v:Draw()
    end
end


return  MenuPage
