
MenuItem    = require( "src/MainMenu/MenuItem" )
MenuPage    = require( "src/MainMenu/MenuPage" )

local  EditorScreen  = require( "src/Application/Screens/EditorScreen" )
local  GameScreen    = require( "src/Application/Screens/GameScreen" )
local  TestScreen    = require( "src/Application/Screens/TestScreen" )
local  Animation     = require( "src/Image/AnimationCoopains")
local  Camera        = require( "src/Camera/Camera")

local MainMenu = {
    menuPages = {},
    currentPage = 1
}


function  MainMenu:Initialize()

    local spaceBetItems = 50

    -- Sounds
    -- back:SetSound( love.audio.newSource( "resources/Audio/FXSound/Retour.mp3", "static" ) )
    zozoStart = love.audio.newSource( "resources/Audio/Ko-Pain/MenuMusicBeginning.mp3", "static" )
    zozoLoop = love.audio.newSource( "resources/Audio/Ko-Pain/MenuMusicLoop.mp3", "static" )

    zozoLoop:setLooping( true )
    love.audio.play( zozoLoop )

    -- ============================ MAIN MAIN ===============================
    y = 300
    dz = 0
    newGame = MenuItem:New( "NewGame", 2 * love.graphics.getWidth() / 3, y )
    y = y + spaceBetItems
    newGame.rectangle.x = dz+ 2 * love.graphics.getWidth() / 3 - newGame.rectangle.w /2


    options = MenuItem:New( "Options", 2 * love.graphics.getWidth() / 3, y )
    y = y + spaceBetItems
    options.rectangle.x = dz+ 2 * love.graphics.getWidth() / 3 - options.rectangle.w /2

    quit    = MenuItem:New( "Quit", 2 * love.graphics.getWidth() / 3, y )
    y = y + spaceBetItems
    quit.rectangle.x = dz+ 2 * love.graphics.getWidth() / 3 - quit.rectangle.w /2

    newSandBox    = MenuItem:New( "SandBox", 2 * love.graphics.getWidth() / 3, y )
    y = y + spaceBetItems
    newSandBox.rectangle.x = dz+ 2 * love.graphics.getWidth() / 3 - newSandBox.rectangle.w /2

    newTest    = MenuItem:New( "Test", 2 * love.graphics.getWidth() / 3, y )
    y = y + spaceBetItems
    newTest.rectangle.x = dz+ 2 * love.graphics.getWidth() / 3 - newTest.rectangle.w /2

    -- Callbacks
    newGame:SetCallback(    function() Manager:PushScreen( GameScreen:New() ); love.audio.stop( zozoLoop ); end )
    options:SetCallback(    function() MainMenu.currentPage = 2 end )
    quit:SetCallback(       function() love.event.quit() end )
    newSandBox:SetCallback( function() Manager:PushScreen( EditorScreen:New() ); love.audio.stop( zozoLoop ); end )
    newTest:SetCallback( function() Manager:PushScreen( TestScreen:New() ); love.audio.stop( zozoLoop ); end )

    -- Sounds
    newGame:SetSound( love.audio.newSource( "resources/Audio/FXSound/Valider.mp3", "static" ) )
    options:SetSound( love.audio.newSource( "resources/Audio/FXSound/Valider.mp3", "static" ) )

    -- Item building
    mainPage = MenuPage:New()
    mainPage:AddItem( newGame )
    mainPage:AddItem( options )
    mainPage:AddItem( quit )
    mainPage:AddItem( newSandBox )
    mainPage:AddItem( newTest )

    self:AddPage( mainPage )


    -- ========================== MAIN OPTIONS =============================
    y = 300
    dz = 0
    video = MenuItem:New( "Video", 2 * love.graphics.getWidth() / 3, y )
    y = y + spaceBetItems
    video.rectangle.x = dz+ 2 * love.graphics.getWidth() / 3 - video.rectangle.w /2
    sound = MenuItem:New( "Sound", 2 * love.graphics.getWidth() / 3, y )
    y = y + spaceBetItems
    sound.rectangle.x = dz+ 2 * love.graphics.getWidth() / 3 - sound.rectangle.w /2
    controls = MenuItem:New( "Controls", 2 * love.graphics.getWidth() / 3, y )
    y = y + spaceBetItems
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
    y = y + spaceBetItems
    fullScreen.rectangle.x = dz +  2 * love.graphics.getWidth() / 3 - video.rectangle.w /2
    local lowerRes  = MenuItem:New( "1200x720",  2 *love.graphics.getWidth() / 3, y )
    y = y + spaceBetItems
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
    imageBG = love.graphics.newImage( "resources/Images/Backgrounds/BGGRID2000.png" )
    imageLOGO = love.graphics.newImage( "resources/Images/LOGOROBOT.png" )

    camZozo = Camera:New( 0, 0, love.graphics.getWidth(), love.graphics.getHeight(), 1 )
    imageZozo = love.graphics.newImage( "resources/Animation/Characters/Dummy/Dancing3.png" )
    animZozo = Animation:New( imageZozo, 0, 0, 30000/60, 506, 0, 60, 24, false, false )
    animZozo:Play( 0 )

    runZozo = love.graphics.newImage( "resources/Animation/Characters/Dummy/run.png" )
    animrunZozo = Animation:New( runZozo, 0, 0, 2600/13, 169, 0, 13, 24, false, false )
    animrunZozo:Play( 0 )

    nDummies = 50
    dummies = {}
    math.randomseed( os.time() )
    for i=1, nDummies do
      dummies[i] = {}
      dummies[i].mx = math.random() * love.graphics.getWidth()
      dummies[i].mspeed = math.random() * 6 + 6
      dummies[i].mStartFrame = math.floor( math.random() * 12 ) + 1
    end

end

function  MainMenu:AddPage( iPage )
    table.insert( self.menuPages, iPage )
end

function MainMenu:Update( iDT )
    animZozo:Update( iDT, 0, 0, 30000/60, 506, 0 )
    animrunZozo:Update( iDT, 0, 0, 2600/13, 169, 0 )
    self:HighlightItemUnderMouse()
    for i=1, nDummies do
      dummies[i].mx = dummies[i].mx + dummies[i].mspeed;
      if dummies[i].mx > love.graphics.getWidth() + 2600/13 then
        dummies[i].mx = - (2600/13) + math.random() * 200
      end
    end

    --nDummies = nDummies + 1
    --dummies[nDummies] = {}
    --dummies[nDummies].mx = - (2600/13)
    --dummies[nDummies].mspeed = math.random() * 6 + 6
end

function MainMenu:HighlightItemUnderMouse()
    self.menuPages[ self.currentPage ]:HighlightItemUnderMouse()
end

function MainMenu:Draw()
    love.graphics.setColor( 255, 255, 255, 255 )
    love.graphics.draw( imageBG, 2 * love.graphics.getWidth() / 3 - imageBG:getWidth() /2, love.graphics.getHeight() / 2 - imageBG:getHeight() /2 )
    love.graphics.draw( imageLOGO, love.graphics.getWidth() / 3 + love.graphics.getWidth() / 3 - imageLOGO:getWidth()/2 , love.graphics.getHeight() / 3 - imageLOGO:getHeight()/2 )


    self.menuPages[ self.currentPage ]:Draw()

    animZozo:Draw( camZozo, 50, love.graphics.getHeight() / 2 + imageBG:getHeight() / 2 - imageZozo:getHeight() )
    for i=1, nDummies do
      animrunZozo.currentquad = math.floor( ( animrunZozo.currentquad + dummies[i].mStartFrame ) % 13 ) + 1
      animrunZozo:Draw( camZozo, dummies[i].mx, love.graphics.getHeight() / 2 + imageBG:getHeight() / 2 - runZozo:getHeight() + 20 )
    end
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