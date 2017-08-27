
MenuItem    = require( "src/MainMenu/MenuItem" )
MenuPage    = require( "src/MainMenu/MenuPage" )

local MainMenu = {
    menuPages = {},
    currentPage = 1,
    returnValue = 0
}

function  MainMenu:Initialize()

    -- ============================ MAIN MAIN ===============================
    y = 100
    newGame = MenuItem:New( "NewGame", love.graphics.getWidth() / 2, y )
    y = y + 30
    options = MenuItem:New( "Options", love.graphics.getWidth() / 2, y )
    y = y + 30
    quit    = MenuItem:New( "Quit", love.graphics.getWidth() / 2, y )

    -- Callbacks
    newGame:SetCallback( function() MainMenu.returnValue = 1 end )
    options:SetCallback( function() MainMenu.currentPage = 2 end )
    quit:SetCallback( function() love.event.quit() end )


    -- Item building
    mainPage = MenuPage:New()
    mainPage:AddItem( newGame )
    mainPage:AddItem( options )
    mainPage:AddItem( quit )

    self:AddPage( mainPage )


    -- ========================== MAIN OPTIONS =============================
    y = 100
    video = MenuItem:New( "Video", love.graphics.getWidth() / 2, y )
    y = y + 30
    sound = MenuItem:New( "Sound", love.graphics.getWidth() / 2, y )
    y = y + 30
    controls = MenuItem:New( "Controls", love.graphics.getWidth() / 2, y )
    y = y + 30
    back    = MenuItem:New( "Back", love.graphics.getWidth() / 2, y )

    -- Callbacks
    back:SetCallback( function() MainMenu.currentPage = 1 end )

    -- Item building
    optionPage = MenuPage:New()
    optionPage:AddItem( video )
    optionPage:AddItem( sound )
    optionPage:AddItem( controls )
    optionPage:AddItem( back )

    self:AddPage( optionPage )
end

function  MainMenu:AddPage( iPage )
    table.insert( self.menuPages, iPage )
end

function MainMenu:Update( iDT )
    self:HighlightItemUnderMouse()
    return  self.returnValue
end

function MainMenu:HighlightItemUnderMouse()
    self.menuPages[ self.currentPage ]:HighlightItemUnderMouse()
end

function MainMenu:Draw()
    self.menuPages[ self.currentPage ]:Draw()
end


function MainMenu:mousepressed( iX, iY, iButton, iIsTouch )
    itemUM = self.menuPages[ self.currentPage ]:GetItemUnderMouse()
    if( itemUM ~= 0 ) then
        itemUM:Click();
    end
end



return  MainMenu