
MenuItem    = require( "src/MainMenu/MenuItem" )
MenuPage    = require( "src/MainMenu/MenuPage" )

local MainMenu = {
    menuPages = {}
}

function  MainMenu:Initialize()
    newGame = MenuItem:New( "NewGame", love.graphics.getWidth() / 2, 10 )
    quit    = MenuItem:New( "Quit", love.graphics.getWidth() / 2, 20 )

    mainPage = MenuPage:New()
    mainPage:AddItem( newGame )
    mainPage:AddItem( quit )
    self:AddPage( mainPage )
end

function  MainMenu:AddPage( iPage )
    table.insert( self.menuPages, iPage )
end

function MainMenu:Update( iDT )
    return
end

function MainMenu:Draw()
    -- love.graphics.setColor( 255, 255, 0 )
    -- love.graphics.rectangle( "fill", 10, 10, 50, 50 )
    for k,v in pairs( self.menuPages ) do
        print( "YO" )
        v:Draw()
    end
end



return  MainMenu