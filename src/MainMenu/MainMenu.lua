
MenuItem    = require( "src/MainMenu/MenuItem" )
MenuPage    = require( "src/MainMenu/MenuPage" )

local MainMenu = {
    menuPages = {},
    currentPage = 1
}

function  MainMenu:Initialize()
    newGame = MenuItem:New( "NewGame", love.graphics.getWidth() / 2, 10 )
    options = MenuItem:New( "Options", love.graphics.getWidth() / 2, 25 )
    quit    = MenuItem:New( "Quit", love.graphics.getWidth() / 2, 40 )

    quit:SetCallback( function() love.event.quit() end )

    mainPage = MenuPage:New()
    mainPage:AddItem( newGame )
    mainPage:AddItem( options )
    mainPage:AddItem( quit )

    self:AddPage( mainPage )
end

function  MainMenu:AddPage( iPage )
    table.insert( self.menuPages, iPage )
end

function MainMenu:Update( iDT )
    self:HighlightItemUnderMouse()
end

function MainMenu:HighlightItemUnderMouse()
    self.menuPages[ self.currentPage ]:HighlightItemUnderMouse()
end

function MainMenu:Draw()
    -- love.graphics.setColor( 255, 255, 0 )
    -- love.graphics.rectangle( "fill", 10, 10, 50, 50 )
    for k,v in pairs( self.menuPages ) do
        v:Draw()
    end
end


function MainMenu:mousepressed( iX, iY, iButton, iIsTouch )
    itemUM = self.menuPages[ self.currentPage ]:GetItemUnderMouse()
    if( itemUM ~= 0 ) then
        itemUM:Click();
    end
end



return  MainMenu