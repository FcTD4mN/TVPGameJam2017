
MenuItem    = require( "src/CommOp1/MainMenu/MenuItem" )
MenuPage    = require( "src/CommOp1/MainMenu/MenuPage" )

local  EditorScreen  = require( "src/CommOp1/Application/Screens/EditorScreen" )
local  GameScreen    = require( "src/CommOp1/Application/Screens/GameScreen" )

local MainMenu = {
    menuPages = {},
    currentPage = 1
}


function  MainMenu:Initialize()

    local verticalSpacing = 50

    -- ============================ MAIN MAIN ===============================
    y = 300
    dz = 0
    newGameCapi = MenuItem:New( "PLAY CAPITALISM", 2 * love.graphics.getWidth() / 3, y )
    y = y + verticalSpacing
    newGameCapi.rectangle.x = dz+ 2 * love.graphics.getWidth() / 3 - newGameCapi.rectangle.w /2

    newGameComm = MenuItem:New( "PLAY COMMUNISM", 2 * love.graphics.getWidth() / 3, y )
    y = y + verticalSpacing
    newGameComm.rectangle.x = dz+ 2 * love.graphics.getWidth() / 3 - newGameComm.rectangle.w /2

    options = MenuItem:New( "Options", 2 * love.graphics.getWidth() / 3, y )
    y = y + verticalSpacing
    options.rectangle.x = dz+ 2 * love.graphics.getWidth() / 3 - options.rectangle.w /2

    quit    = MenuItem:New( "Quit", 2 * love.graphics.getWidth() / 3, y )
    y = y + verticalSpacing
    quit.rectangle.x = dz+ 2 * love.graphics.getWidth() / 3 - quit.rectangle.w /2

    -- newSandBox    = MenuItem:New( "SandBox", 2 * love.graphics.getWidth() / 3, y )
    -- y = y + verticalSpacing
    -- newSandBox.rectangle.x = dz+ 2 * love.graphics.getWidth() / 3 - newSandBox.rectangle.w /2

    -- Callbacks
    newGameCapi:SetCallback( function() Manager:PushScreen( GameScreen:New( 0 ) ); end )
    newGameComm:SetCallback( function() Manager:PushScreen( GameScreen:New( 1 ) ); end )
    options:SetCallback(    function() MainMenu.currentPage = 2 end )
    quit:SetCallback(       function() love.event.quit() end )
    -- newSandBox:SetCallback( function() Manager:PushScreen( EditorScreen:New() ); love.audio.stop( zozoLoop ); end )
    -- newTest:SetCallback( function() Manager:PushScreen( TestScreen:New() ); love.audio.stop( zozoLoop ); end )

    -- Sounds
    newGameCapi:SetSound( love.audio.newSource( "resources/CommOp1/Audio/FXSound/Valider.mp3", "static" ) )
    newGameComm:SetSound( love.audio.newSource( "resources/CommOp1/Audio/FXSound/Valider.mp3", "static" ) )
    options:SetSound( love.audio.newSource( "resources/CommOp1/Audio/FXSound/Valider.mp3", "static" ) )

    -- Item building
    mainPage = MenuPage:New()
    mainPage:AddItem( newGameCapi )
    mainPage:AddItem( newGameComm )
    mainPage:AddItem( options )
    mainPage:AddItem( quit )
    -- mainPage:AddItem( newSandBox )
    -- mainPage:AddItem( newTest )

    self:AddPage( mainPage )


    -- ========================== MAIN OPTIONS =============================
    y = 300
    dz = 0
    video = MenuItem:New( "Video", 2 * love.graphics.getWidth() / 3, y )
    y = y + verticalSpacing
    video.rectangle.x = dz+ 2 * love.graphics.getWidth() / 3 - video.rectangle.w /2
    sound = MenuItem:New( "Sound", 2 * love.graphics.getWidth() / 3, y )
    y = y + verticalSpacing
    sound.rectangle.x = dz+ 2 * love.graphics.getWidth() / 3 - sound.rectangle.w /2
    controls = MenuItem:New( "Controls", 2 * love.graphics.getWidth() / 3, y )
    y = y + verticalSpacing
    controls.rectangle.x = dz+ 2 * love.graphics.getWidth() / 3 - controls.rectangle.w /2
    back    = MenuItem:New( "Back", 2 * love.graphics.getWidth() / 3, y )
    back.rectangle.x = dz+ 2 * love.graphics.getWidth() / 3 - back.rectangle.w /2

    -- Callbacks
    video:SetCallback( function() MainMenu.currentPage = 3 end )
    back:SetCallback( function() MainMenu.currentPage = 1 end )


    -- Item building
    optionPage = MenuPage:New()
    optionPage:AddItem( video )
    optionPage:AddItem( sound )
    optionPage:AddItem( controls )
    optionPage:AddItem( back )

    self:AddPage( optionPage )


    -- ========================== VIDEO OPTIONS =============================
    y = 300
    dz = 0
    local fullScreen = MenuItem:New( "FullScreen", 2 * love.graphics.getWidth() / 3, y )
    y = y + verticalSpacing
    fullScreen.rectangle.x = dz +  2 * love.graphics.getWidth() / 3 - video.rectangle.w /2
    local lowerRes  = MenuItem:New( "1200x720",  2 *love.graphics.getWidth() / 3, y )
    y = y + verticalSpacing
    lowerRes.rectangle.x = dz + 2 * love.graphics.getWidth() / 3 - video.rectangle.w /2
    local back  = MenuItem:New( "Back", 2 * love.graphics.getWidth() / 3, y )
    back.rectangle.x = dz+ 2 * love.graphics.getWidth() / 3 - back.rectangle.w /2

    -- Callbacks
    fullScreen:SetCallback( function() love.window.setMode( 800, 600, { fullscreen=true } ) end )
    lowerRes:SetCallback( function() love.window.setMode( 1200, 720, { fullscreen=false } ) end )
    back:SetCallback( function() MainMenu.currentPage = 2 end )

    -- Item building
    videoOptions = MenuPage:New()
    videoOptions:AddItem( fullScreen )
    videoOptions:AddItem( lowerRes )
    videoOptions:AddItem( back )

    self:AddPage( videoOptions )

    -- ================================ END =================================

    --Menu Images
    imageBG = love.graphics.newImage( "resources/CommOp1/Images/Backgrounds/MainMenu.png" )
    imageLOGO = love.graphics.newImage( "resources/CommOp1/Images/Logo.png" )

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
    love.graphics.setColor( 255, 255, 255, 255 )
    love.graphics.draw( imageBG, 2 * love.graphics.getWidth() / 3 - imageBG:getWidth() /2, love.graphics.getHeight() / 2 - imageBG:getHeight() /2 )
    love.graphics.draw( imageLOGO, love.graphics.getWidth() / 3 + love.graphics.getWidth() / 3 - imageLOGO:getWidth()/2 , love.graphics.getHeight() / 3 - imageLOGO:getHeight()/2 )


    self.menuPages[ self.currentPage ]:Draw()
end


function MainMenu:KeyPressed( key, scancode, isrepeat )
    return  false
end

function MainMenu:KeyReleased( key, scancode )
    return  false
end


function MainMenu:MousePressed( iX, iY, iButton, iIsTouch )
    itemUM = self.menuPages[ self.currentPage ]:GetItemUnderMouse()
    if( itemUM ~= "none" ) then
        itemUM:Click();
        return  true
    end
    return  false
end



return  MainMenu