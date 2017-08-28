
MenuItem    = require( "src/MainMenu/MenuItem" )
MenuPage    = require( "src/MainMenu/MenuPage" )

local MainMenu = {
    menuPages = {},
    currentPage = 1,
    returnValue = 0
}

-- local music = love.audio.newSource( "resources/Audio/Music/DaRealMenu.mp3", "stream" )

function  MainMenu:Initialize()

    local spaceBetItems = 50
    -- music:setLooping( true )

    -- ============================ MAIN MAIN ===============================
    y = 250
    dz = 0
    newGame = MenuItem:New( "NewGame", love.graphics.getWidth() / 2, y )
    y = y + spaceBetItems
    newGame.rectangle.x = dz+ love.graphics.getWidth() / 2 - newGame.rectangle.w /2


    options = MenuItem:New( "Options", love.graphics.getWidth() / 2, y )
    y = y + spaceBetItems
    options.rectangle.x = dz+ love.graphics.getWidth() / 2 - options.rectangle.w /2

    quit    = MenuItem:New( "Quit", love.graphics.getWidth() / 2, y )
    quit.rectangle.x = dz+ love.graphics.getWidth() / 2 - quit.rectangle.w /2

    -- Callbacks
    newGame:SetCallback(    function() MainMenu.returnValue = 1 end )
    options:SetCallback(    function() MainMenu.currentPage = 2 end )
    quit:SetCallback(       function() love.event.quit() end )

    -- Sounds
    newGame:SetSound( love.audio.newSource( "resources/Audio/FXSound/Valider.mp3", "static" ) )
    options:SetSound( love.audio.newSource( "resources/Audio/FXSound/Valider.mp3", "static" ) )

    -- Item building
    mainPage = MenuPage:New()
    mainPage:AddItem( newGame )
    mainPage:AddItem( options )
    mainPage:AddItem( quit )

    self:AddPage( mainPage )


    -- ========================== MAIN OPTIONS =============================
    y = 250
    dz = 0
    video = MenuItem:New( "Video", love.graphics.getWidth() / 2, y )
    y = y + spaceBetItems
    video.rectangle.x = dz+ love.graphics.getWidth() / 2 - video.rectangle.w /2
    sound = MenuItem:New( "Sound", love.graphics.getWidth() / 2, y )
    y = y + spaceBetItems
    sound.rectangle.x = dz+ love.graphics.getWidth() / 2 - sound.rectangle.w /2
    controls = MenuItem:New( "Controls", love.graphics.getWidth() / 2, y )
    y = y + spaceBetItems
    controls.rectangle.x = dz+ love.graphics.getWidth() / 2 - controls.rectangle.w /2
    back    = MenuItem:New( "Back", love.graphics.getWidth() / 2, y )
    back.rectangle.x = dz+ love.graphics.getWidth() / 2 - back.rectangle.w /2

    -- Callbacks
    back:SetCallback( function() MainMenu.currentPage = 1 end )

    -- Sounds
    back:SetSound( love.audio.newSource( "resources/Audio/FXSound/Retour.mp3", "static" ) )

    -- Item building
    optionPage = MenuPage:New()
    optionPage:AddItem( video )
    optionPage:AddItem( sound )
    optionPage:AddItem( controls )
    optionPage:AddItem( back )

    self:AddPage( optionPage )

    -- love.audio.play( music )

    --Menu Images
    imageBG = love.graphics.newImage( "resources/Images/Backgrounds/Final/MenuBG.png" )
    imageLOGO = love.graphics.newImage( "resources/Images/Backgrounds/Final/MenuLOGO.png" )

end

function  MainMenu:AddPage( iPage )
    table.insert( self.menuPages, iPage )
end

function MainMenu:Update( iDT )
    self:HighlightItemUnderMouse()

    -- if( self.returnValue == 1 ) then
    --     love.audio.stop( music )
    -- end

    return  self.returnValue
end

function MainMenu:HighlightItemUnderMouse()
    self.menuPages[ self.currentPage ]:HighlightItemUnderMouse()
end

function MainMenu:Draw()
    love.graphics.setColor( 255, 255, 255, 255 )
    love.graphics.draw( imageBG, love.graphics.getWidth() / 2 - imageBG:getWidth() /2, 0 )
    love.graphics.draw( imageLOGO, love.graphics.getWidth() / 2 - imageLOGO:getWidth()/2 , 0 )


    self.menuPages[ self.currentPage ]:Draw()
end


function MainMenu:KeyPressed( key, scancode, isrepeat )
    return
end

function MainMenu:KeyReleased( key, scancode )
    return
end


function MainMenu:mousepressed( iX, iY, iButton, iIsTouch )
    itemUM = self.menuPages[ self.currentPage ]:GetItemUnderMouse()
    if( itemUM ~= "none" ) then
        itemUM:Click();
    end
end



return  MainMenu