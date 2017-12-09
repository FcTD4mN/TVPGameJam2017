require( "imgui" )

local Background    = require( "src/Image/Background" )
local Camera        = require( "src/Camera/Camera")
local LevelBaseECS  = require( "src/Game/Level/LevelBaseECS" )
local Rectangle     = require( "src/Math/Rectangle" )
      Terrain       = require( "src/Objects/Terrain" )
local TerrainHUD    = require( "src/HUD/Terrain/TerrainHUD" )
local SLAXML        = require 'src/ExtLibs/XML/SLAXML/slaxdom'

-- ASSETS
--      HEROS
local Lapin         = require( "src/Objects/Heros/Lapin")
local Singe         = require( "src/Objects/Heros/Singe")
local Wall          = require( "src/ECS/Factory/Wall")
local Spike         = require( "src/ECS/Factory/Spike")
local ECSIncludes   = require( "src/ECS/ECSIncludes")

--      ENVIRONNEMENT
local BabyTree      = require( "src/Objects/Environnement/BabyTree")
local GrownTree     = require( "src/Objects/Environnement/GrownTree")
local Object_Box    = require( "src/Objects/Environnement/Object_Box")
local Tree          = require( "src/Objects/Environnement/Tree")
local WaterPipe     = require( "src/Objects/Environnement/WaterPipe")
local Ribbon            = require( "src/ECS/Factory/Ribbon")
local TeleporterRibbon  = require( "src/ECS/Factory/TeleporterRibbon")
local TriggerCheckPoint  = require( "src/ECS/Factory/TriggerCheckPoint")


-- TODO: Add it in Base/Global
ObjectPool      = require "src/Objects/Pools/ObjectPool"


LevelEditor = {
    mLevel = nil,
    mState = "uninitialized",
    mEditorCamera = nil,
    mLevelPropertiesGUIRect = nil,

    mDoingMultiselection = false,
    mSelectedObjects = {},
    mSelectionInitialPositionX = nil,
    mSelectionInitialPositionY = nil,

    mSelectionRectangle = Rectangle:New( 0, 0, 0, 0 )
}



local renderPreviewLine = false
local dragMode = false
local xStartingMouse, yStartingMouse = 0, 0
local xCurrentMouse, yCurrentMouse = 0, 0

local gCurrentEditedComponent = nil
local gCurrentEditedEntityIndex = -1
local gInPopup = false


function LevelEditor.Initialize( iLevel )

    LevelEditor.mLevel = iLevel
    LevelEditor.mEditorCamera = Camera:New( 0, 0, love.graphics.getWidth(), love.graphics.getHeight(), 1.0 )

    if LevelEditor.mLevel.mTerrain == nil then
        Terrain.Initialize( LevelEditor.mLevel.mWorld )
        LevelEditor.mLevel.mTerrain = Terrain
    end

    LevelEditor.mTerrainHUD = TerrainHUD:New( LevelEditor.mLevel.mTerrain, LevelEditor.mEditorCamera )

    gCameraX = LevelEditor.mLevel.mCamera.mX
    gCameraY = LevelEditor.mLevel.mCamera.mY
    gCameraW = LevelEditor.mLevel.mCamera.mW
    gCameraH = LevelEditor.mLevel.mCamera.mH
    gCameraScale = LevelEditor.mLevel.mCamera.mScale

    gIntX = 0
    gIntY = 0
    gIntW = 0
    gIntH = 0
    gIntA = 0
    gFileName = "Save/LevelTEST.xml" -- Just so it's quicker to debug

    gFixedBGFile = "test"

    LevelEditor.mState = "menu"
    LevelEditor.mLevelPropertiesGUIRect = Rectangle:New( 0, 0, 0, 0 )

end

function LevelEditor.Draw()

    if( LevelEditor.mLevel ) then


        bgZozo = love.graphics.newImage( "resources/Images/BGGRID.png" )
        local camera = LevelEditor.mEditorCamera
        love.graphics.clear( 40, 40, 40 )
        local width = love.graphics.getWidth();
        local height = love.graphics.getHeight();

        local rwidth = width / camera.mScale;
        local rheight = height / camera.mScale;

        local zozoWidth = bgZozo:getWidth()
        local zozoHeight = bgZozo:getHeight()
        local nfw = math.ceil( rwidth / zozoWidth );
        local nfh = math.ceil( rheight / zozoHeight );
        local zozoDepth = 1
        love.graphics.setColor(255,255,255,127);
        for i=0, nfw, 1 do
            for j=0, nfh, 1 do
                love.graphics.draw( bgZozo, - ( camera.mX % zozoWidth ) * zozoDepth + i * zozoWidth * camera.mScale, - ( camera.mY % zozoHeight ) * zozoDepth + j * zozoHeight * camera.mScale, 0, camera.mScale, camera.mScale )
            end
        end
        love.graphics.setColor(255,255,255,255);

        LevelEditor.mLevel:Draw( LevelEditor.mEditorCamera )
        LevelEditor.mTerrainHUD:Draw( LevelEditor.mEditorCamera )
        DEBUGWorldHITBOXESDraw( gWorld, LevelEditor.mEditorCamera, "all" )

    end

    love.graphics.setColor( 255, 255, 255, 255 )

    status, mainCommands = imgui.Begin( "Level Properties", nil, { "AlwaysAutoResize" } );

    x, y = imgui.GetWindowPos()
    w, h = imgui.GetWindowSize()

    LevelEditor.mLevelPropertiesGUIRect.w = w
    LevelEditor.mLevelPropertiesGUIRect.h = h
    LevelEditor.mLevelPropertiesGUIRect:SetX( x )
    LevelEditor.mLevelPropertiesGUIRect:SetY( y )

        -- Camera =====================================
        if( imgui.CollapsingHeader("Camera") ) then
            if( imgui.Button( "Edit Camera" ) ) then
                imgui.OpenPopup( "Camera settings" )
            end
            if imgui.BeginPopupModal( "Camera settings", nil, { "AlwaysAutoResize", "NoResize" } ) then

                xStatus, gCameraX = imgui.InputInt( "X", gCameraX )
                imgui.SameLine()
                yStatus, gCameraY = imgui.InputInt( "Y", gCameraY )

                wStatus, gCameraW = imgui.InputInt( "W", gCameraW )
                imgui.SameLine()
                hStatus, gCameraH = imgui.InputInt( "H", gCameraH )

                hStatus, gCameraScale = imgui.InputInt( "H", gCameraScale )

                if( imgui.Button( "Ok" ) ) then
                    Editor.SetCamera( gCameraX, gCameraY, gCameraW, gCameraH, gCameraScale )
                    imgui.CloseCurrentPopup()
                end
                imgui.EndPopup()
            end

        end



        -- Fixed BG =====================================
        if( imgui.CollapsingHeader("Fixed Background") ) then

            if( imgui.Button( "Set fixed background" ) ) then
                imgui.OpenPopup( "Image path" )
            end
            if imgui.BeginPopupModal( "Image path", nil, { "AlwaysAutoResize", "NoResize" } ) then

                xStatus, gFixedBGFile = imgui.InputText( "Image path", gFixedBGFile, 200 );

                if( imgui.Button( "Ok" ) ) then
                    LevelEditor.SetFixedImage( gFixedBGFile )
                    imgui.CloseCurrentPopup()
                end
                if( imgui.Button( "Cancel" ) ) then
                    imgui.CloseCurrentPopup()
                end
                imgui.EndPopup()
            end

        end



        -- BACKGROUNDS ==================================
        if( imgui.CollapsingHeader("Backgrounds") ) then

            if( imgui.Button( "Add a background" ) ) then
                imgui.OpenPopup( "Background" )
            end
            if imgui.BeginPopupModal( "Background", nil, { "AlwaysAutoResize", "NoResize" } ) then

                xStatus, gFileName = imgui.InputText( "Background path", gFileName, 200 );

                xStatus, gIntX = imgui.InputInt( "X", gIntX )
                yStatus, gIntY = imgui.InputInt( "Y", gIntY )
                yStatus, gIntA = imgui.InputInt( "Depth", gIntA )


                if( imgui.Button( "Ok" ) ) then
                    LevelEditor.AddBackground( gFileName, gIntX, gIntY, gIntA )
                    imgui.CloseCurrentPopup()
                end
                if( imgui.Button( "Cancel" ) ) then
                    imgui.CloseCurrentPopup()
                end
                imgui.EndPopup()
            end

            for k,v in pairs( LevelEditor.mLevel.mBackgrounds ) do

                imgui.Text( v.filename )
                imgui.SameLine()
                if( imgui.Button( "EditBG"..k ) ) then
                    gFileName = v.filename
                    gIntX = v.originX
                    gIntY = v.originY
                    gIntA = v.depth
                    imgui.OpenPopup( "EditBackground"..k )
                end
                if imgui.BeginPopupModal( "EditBackground"..k, nil, { "AlwaysAutoResize", "NoResize" } ) then

                    xStatus, gFileName = imgui.InputText( "Background path", gFileName, 200 );

                    xStatus, gIntX = imgui.InputInt( "X", gIntX )
                    yStatus, gIntY = imgui.InputInt( "Y", gIntY )
                    yStatus, gIntA = imgui.InputInt( "Depth", gIntA )

                    if( imgui.Button( "Ok" ) ) then
                        table.remove( LevelEditor.mLevel.mBackgrounds, k )
                        LevelEditor.AddBackground( gFileName, gIntX, gIntY, gIntA )
                        imgui.CloseCurrentPopup()
                    end
                    if( imgui.Button( "Cancel" ) ) then
                        imgui.CloseCurrentPopup()
                    end
                    imgui.EndPopup()
                end
                imgui.SameLine()
                if( imgui.Button( "DeleteBG"..k ) ) then
                    table.remove( LevelEditor.mLevel.mBackgrounds, k )
                end

            end

        end



        -- FOREGROUNDS ==================================
        if( imgui.CollapsingHeader("Foregrounds") ) then

            if( imgui.Button( "Add a foregrounds" ) ) then
                imgui.OpenPopup( "Foregrounds" )
            end
            if imgui.BeginPopupModal( "Foregrounds", nil, { "AlwaysAutoResize", "NoResize" } ) then

                xStatus, gFileName = imgui.InputText( "Foregrounds path", gFileName, 200 );

                xStatus, gIntX = imgui.InputInt( "X", gIntX )
                yStatus, gIntY = imgui.InputInt( "Y", gIntY )
                yStatus, gIntA = imgui.InputInt( "Depth", gIntA )


                if( imgui.Button( "Ok" ) ) then
                    LevelEditor.AddForeground( gFileName, gIntX, gIntY, gIntA )
                    imgui.CloseCurrentPopup()
                end
                if( imgui.Button( "Cancel" ) ) then
                    imgui.CloseCurrentPopup()
                end
                imgui.EndPopup()
            end

            for k,v in pairs( LevelEditor.mLevel.mForegrounds ) do

                imgui.Text( v.filename )
                imgui.SameLine()
                if( imgui.Button( "EditFG"..k ) ) then
                    gFileName = v.filename
                    gIntX = v.originX
                    gIntY = v.originY
                    gIntA = v.depth
                    imgui.OpenPopup( "EditForeground"..k )
                end
                if imgui.BeginPopupModal( "EditForeground"..k, nil, { "AlwaysAutoResize", "NoResize" } ) then

                    xStatus, gFileName = imgui.InputText( "Foreground path", gFileName, 200 );

                    xStatus, gIntX = imgui.InputInt( "X", gIntX )
                    yStatus, gIntY = imgui.InputInt( "Y", gIntY )
                    yStatus, gIntA = imgui.InputInt( "Depth", gIntA )

                    if( imgui.Button( "Ok" ) ) then
                        table.remove( LevelEditor.mLevel.mForegrounds, k )
                        LevelEditor.AddForeground( gFileName, gIntX, gIntY, gIntA )
                        imgui.CloseCurrentPopup()
                    end
                    if( imgui.Button( "Cancel" ) ) then
                        imgui.CloseCurrentPopup()
                    end
                    imgui.EndPopup()
                end
                imgui.SameLine()
                if( imgui.Button( "DeleteFG"..k ) ) then
                    table.remove( LevelEditor.mLevel.mForegrounds, k )
                end

            end

        end


        -- TERRAIN ==================================
        if( imgui.CollapsingHeader("Terrain") ) then

            if LevelEditor.mState ~= "placingterrain" then
                if( imgui.Button( "Start terrain edition" ) ) then
                    LevelEditor.mState = "placingterrain"
                    love.mouse.setCursor( love.mouse.getSystemCursor( "crosshair" ) )
                end
            elseif LevelEditor.mState == "placingterrain" then
                if( imgui.Button( "Stop terrain edition" ) ) then
                    LevelEditor.mState = "menu"
                    love.mouse.setCursor( love.mouse.getSystemCursor( "arrow" ) )
                    renderPreviewLine = false
                end
            end

        end



        -- ASSETS ==================================
        if( imgui.CollapsingHeader("Assets") ) then

            local x, y = LevelEditor.mEditorCamera.mX, LevelEditor.mEditorCamera.mY

            if (imgui.TreeNode("Heros")) then

                imgui.Text( "Lapin" );
                imgui.SameLine()
                if imgui.Button( "AddLapin" ) then
                    Lapin:New( gWorld, x + LevelEditor.mEditorCamera.mW / 2, y + LevelEditor.mEditorCamera.mH / 2 )
                end

                imgui.Text( "Singe" );
                imgui.SameLine()
                if imgui.Button( "AddSinge" ) then
                    Singe:New( gWorld, x + LevelEditor.mEditorCamera.mW / 2, y + LevelEditor.mEditorCamera.mH / 2 )
                end

                imgui.TreePop();
            end

            if (imgui.TreeNode("Wall")) then

                imgui.Text( "Wall" );
                imgui.SameLine()
                if imgui.Button( "AddWall" ) then
                    imgui.OpenPopup( "WallSizes" )
                end

                if imgui.BeginPopupModal( "WallSizes", nil, { "AlwaysAutoResize", "NoResize", "NoTitleBar" } ) then

                    xStatus, gIntW = imgui.InputInt( "W", gIntW )
                    yStatus, gIntH = imgui.InputInt( "H", gIntH )

                    if( imgui.Button( "Ok" ) ) then
                        Wall:New( gWorld, x + LevelEditor.mEditorCamera.mW / 2, y + LevelEditor.mEditorCamera.mH / 2, gIntW, gIntH )
                        imgui.CloseCurrentPopup()
                    end
                    if( imgui.Button( "Cancel" ) ) then
                        imgui.CloseCurrentPopup()
                    end

                    imgui.EndPopup()
                end

                imgui.Text( "Spike" );
                imgui.SameLine()
                if imgui.Button( "AddSpike" ) then
                    imgui.OpenPopup( "SpikeSize" )
                end

                if imgui.BeginPopupModal( "SpikeSize", nil, { "AlwaysAutoResize", "NoResize", "NoTitleBar" } ) then

                    xStatus, gIntW = imgui.InputInt( "W", gIntW )
                    yStatus, gIntH = imgui.InputInt( "H", gIntH )

                    if( imgui.Button( "Ok" ) ) then
                        Spike:New( gWorld, x + LevelEditor.mEditorCamera.mW / 2, y + LevelEditor.mEditorCamera.mH / 2, gIntW, gIntH )
                        imgui.CloseCurrentPopup()
                    end
                    if( imgui.Button( "Cancel" ) ) then
                        imgui.CloseCurrentPopup()
                    end

                    imgui.EndPopup()
                end

                imgui.TreePop();
            end

            if (imgui.TreeNode("Environnement")) then

                imgui.Text( "BabyTree" );
                imgui.SameLine()
                if imgui.Button( "AddBabyTree" ) then
                    BabyTree:New( gWorld, x + LevelEditor.mEditorCamera.mW / 2, y + LevelEditor.mEditorCamera.mH / 2 )
                end

                imgui.Text( "GrownTree" );
                imgui.SameLine()
                if imgui.Button( "AddGrownTree" ) then
                    GrownTree:New( gWorld, x + LevelEditor.mEditorCamera.mW / 2, y + LevelEditor.mEditorCamera.mH / 2 )
                end

                imgui.Text( "Object_Box" );
                imgui.SameLine()
                if imgui.Button( "AddObject_Box" ) then
                    Object_Box:New( gWorld, x + LevelEditor.mEditorCamera.mW / 2, y + LevelEditor.mEditorCamera.mH / 2 )
                end

                imgui.Text( "Tree" );
                imgui.SameLine()
                if imgui.Button( "AddTree" ) then
                    Tree:New( gWorld, x + LevelEditor.mEditorCamera.mW / 2, y + LevelEditor.mEditorCamera.mH / 2 )
                end

                imgui.Text( "WaterPipe" );
                imgui.SameLine()
                if imgui.Button( "AddWaterPipe" ) then
                    WaterPipe:New( gWorld, x + LevelEditor.mEditorCamera.mW / 2, y + LevelEditor.mEditorCamera.mH / 2 )
                end

                imgui.Text( "Ribbon01" );
                imgui.SameLine()
                if imgui.Button( "Ribbon01" ) then
                    Ribbon:New( gWorld, x + LevelEditor.mEditorCamera.mW / 2, y + LevelEditor.mEditorCamera.mH / 2, "resources/Images/Decor/ruban_01.png" )
                end

                imgui.Text( "Ribbon02" );
                imgui.SameLine()
                if imgui.Button( "Ribbon02" ) then
                    Ribbon:New( gWorld, x + LevelEditor.mEditorCamera.mW / 2, y + LevelEditor.mEditorCamera.mH / 2, "resources/Images/Decor/ruban_02.png" )
                end

                imgui.Text( "Ribbon03" );
                imgui.SameLine()
                if imgui.Button( "Ribbon03" ) then
                    Ribbon:New( gWorld, x + LevelEditor.mEditorCamera.mW / 2, y + LevelEditor.mEditorCamera.mH / 2, "resources/Images/Decor/ruban_03.png" )
                end

                imgui.Text( "Ribbon04" );
                imgui.SameLine()
                if imgui.Button( "Ribbon04" ) then
                    Ribbon:New( gWorld, x + LevelEditor.mEditorCamera.mW / 2, y + LevelEditor.mEditorCamera.mH / 2, "resources/Images/Decor/ruban_04.png" )
                end

                imgui.Text( "TriggerCheckPoint01" );
                imgui.SameLine()
                if imgui.Button( "TriggerCheckPoint01" ) then
                    TriggerCheckPoint:New( gWorld, x + LevelEditor.mEditorCamera.mW / 2, y + LevelEditor.mEditorCamera.mH / 2, 1 )
                end

                imgui.Text( "TriggerCheckPoint02" );
                imgui.SameLine()
                if imgui.Button( "TriggerCheckPoint02" ) then
                    TriggerCheckPoint:New( gWorld, x + LevelEditor.mEditorCamera.mW / 2, y + LevelEditor.mEditorCamera.mH / 2, 2 )
                end

                imgui.Text( "TriggerCheckPoint03" );
                imgui.SameLine()
                if imgui.Button( "TriggerCheckPoint03" ) then
                    TriggerCheckPoint:New( gWorld, x + LevelEditor.mEditorCamera.mW / 2, y + LevelEditor.mEditorCamera.mH / 2, 3 )
                end

                imgui.Text( "TriggerCheckPoint04" );
                imgui.SameLine()
                if imgui.Button( "TriggerCheckPoint04" ) then
                    TriggerCheckPoint:New( gWorld, x + LevelEditor.mEditorCamera.mW / 2, y + LevelEditor.mEditorCamera.mH / 2, 4 )
                end

                imgui.Text( "TriggerCheckPoint05" );
                imgui.SameLine()
                if imgui.Button( "TriggerCheckPoint05" ) then
                    TriggerCheckPoint:New( gWorld, x + LevelEditor.mEditorCamera.mW / 2, y + LevelEditor.mEditorCamera.mH / 2, 5 )
                end

                imgui.Text( "TriggerCheckPoint06" );
                imgui.SameLine()
                if imgui.Button( "TriggerCheckPoint06" ) then
                    TriggerCheckPoint:New( gWorld, x + LevelEditor.mEditorCamera.mW / 2, y + LevelEditor.mEditorCamera.mH / 2, 6 )
                end

                imgui.Text( "TriggerCheckPoint07" );
                imgui.SameLine()
                if imgui.Button( "TriggerCheckPoint07" ) then
                    TriggerCheckPoint:New( gWorld, x + LevelEditor.mEditorCamera.mW / 2, y + LevelEditor.mEditorCamera.mH / 2, 7 )
                end

                imgui.Text( "TriggerCheckPoint08" );
                imgui.SameLine()
                if imgui.Button( "TriggerCheckPoint08" ) then
                    TriggerCheckPoint:New( gWorld, x + LevelEditor.mEditorCamera.mW / 2, y + LevelEditor.mEditorCamera.mH / 2, 8 )
                end

                imgui.Text( "TriggerCheckPoint09" );
                imgui.SameLine()
                if imgui.Button( "TriggerCheckPoint09" ) then
                    TriggerCheckPoint:New( gWorld, x + LevelEditor.mEditorCamera.mW / 2, y + LevelEditor.mEditorCamera.mH / 2, 9 )
                end

                imgui.Text( "TriggerCheckPoint10" );
                imgui.SameLine()
                if imgui.Button( "TriggerCheckPoint10" ) then
                    TriggerCheckPoint:New( gWorld, x + LevelEditor.mEditorCamera.mW / 2, y + LevelEditor.mEditorCamera.mH / 2, 10 )
                end

                imgui.Text( "TriggerCheckPoint11" );
                imgui.SameLine()
                if imgui.Button( "TriggerCheckPoint11" ) then
                    TriggerCheckPoint:New( gWorld, x + LevelEditor.mEditorCamera.mW / 2, y + LevelEditor.mEditorCamera.mH / 2, 11 )
                end


                imgui.Text( "TELERibbon01" );
                imgui.SameLine()
                if imgui.Button( "TELERibbon01" ) then
                    TeleporterRibbon:New( gWorld, x + LevelEditor.mEditorCamera.mW / 2, y + LevelEditor.mEditorCamera.mH / 2, "resources/Images/Decor/ruban_01.png", 0, 0 )
                end

                imgui.Text( "TELERibbon02" );
                imgui.SameLine()
                if imgui.Button( "TELERibbon02" ) then
                    TeleporterRibbon:New( gWorld, x + LevelEditor.mEditorCamera.mW / 2, y + LevelEditor.mEditorCamera.mH / 2, "resources/Images/Decor/ruban_02.png", 0, 0 )
                end

                imgui.Text( "TELERibbon03" );
                imgui.SameLine()
                if imgui.Button( "TELERibbon03" ) then
                    TeleporterRibbon:New( gWorld, x + LevelEditor.mEditorCamera.mW / 2, y + LevelEditor.mEditorCamera.mH / 2, "resources/Images/Decor/ruban_03.png", 0, 0 )
                end

                imgui.Text( "TELERibbon04" );
                imgui.SameLine()
                if imgui.Button( "TELERibbon04" ) then
                    TeleporterRibbon:New( gWorld, x + LevelEditor.mEditorCamera.mW / 2, y + LevelEditor.mEditorCamera.mH / 2, "resources/Images/Decor/ruban_04.png", 0, 0 )
                end

                imgui.Text( "TELERibbon05" );
                imgui.SameLine()
                if imgui.Button( "TELERibbon05" ) then
                    TeleporterRibbon:New( gWorld, x + LevelEditor.mEditorCamera.mW / 2, y + LevelEditor.mEditorCamera.mH / 2, "resources/Images/Decor/ruban_05.png", 0, 0 )
                end

                imgui.Text( "TELERibbon06" );
                imgui.SameLine()
                if imgui.Button( "TELERibbon06" ) then
                    TeleporterRibbon:New( gWorld, x + LevelEditor.mEditorCamera.mW / 2, y + LevelEditor.mEditorCamera.mH / 2, "resources/Images/Decor/ruban_06.png", 0, 0 )
                end
                imgui.Text( "TELERibbon07" );
                imgui.SameLine()
                if imgui.Button( "TELERibbon07" ) then
                    TeleporterRibbon:New( gWorld, x + LevelEditor.mEditorCamera.mW / 2, y + LevelEditor.mEditorCamera.mH / 2, "resources/Images/Decor/ruban_07.png", 0, 0 )
                end

                imgui.Text( "TELERibbon08" );
                imgui.SameLine()
                if imgui.Button( "TELERibbon08" ) then
                    TeleporterRibbon:New( gWorld, x + LevelEditor.mEditorCamera.mW / 2, y + LevelEditor.mEditorCamera.mH / 2, "resources/Images/Decor/ruban_08.png", 0, 0 )
                end

                imgui.Text( "TELERibbonwin" );
                imgui.SameLine()
                if imgui.Button( "TELERibbonwin" ) then
                    TeleporterRibbon:New( gWorld, x + LevelEditor.mEditorCamera.mW / 2, y + LevelEditor.mEditorCamera.mH / 2, "resources/Images/Decor/ruban_win.png", 0, 0 )
                end

                imgui.TreePop();
            end

        end


        -- SAVE ==================================
        if( imgui.Button( "Save level" ) ) then
            imgui.OpenPopup( "Save" )
        end
        if imgui.BeginPopupModal( "Save", nil, { "AlwaysAutoResize", "NoResize" } ) then

            xStatus, gFileName = imgui.InputText( "File Name", gFileName, 200 );

            if( imgui.Button( "Save" ) ) then
                LevelEditor.SaveLevel( gFileName )
                imgui.CloseCurrentPopup()
            end
            imgui.SameLine()
            if( imgui.Button( "Cancel" ) ) then
                imgui.CloseCurrentPopup()
            end
            imgui.EndPopup()
        end

        imgui.SameLine()


        -- LOAD ==================================
        if( imgui.Button( "Load level" ) ) then
            imgui.OpenPopup( "Load" )
        end
        if imgui.BeginPopupModal( "Load", nil, { "AlwaysAutoResize", "NoResize" } ) then

            xStatus, gFileName = imgui.InputText( "File Name", gFileName, 200 );

            if( imgui.Button( "Load" ) ) then
                LevelEditor.LoadLevel( gFileName )
                imgui.CloseCurrentPopup()
            end
            imgui.SameLine()
            if( imgui.Button( "Cancel" ) ) then
                imgui.CloseCurrentPopup()
            end
            imgui.EndPopup()
        end


    -- POPUPS ======================================
    if gInPopup then

        imgui.OpenPopup( "Test" )
        if imgui.BeginPopupModal( "Test", nil, { "AlwaysAutoResize", "NoResize", "NoTitleBar" } ) then

            if( imgui.Button( "Delete" ) ) then
                imgui.CloseCurrentPopup()
                if( gCurrentEditedComponent ) then
                    table.remove( ECSWorld.mEntities, gCurrentEditedEntityIndex )
                end
                gInPopup = false
                gCurrentEditedComponent = nil
                gCurrentEditedEntityIndex = -1
            end

            if( imgui.Button( "Cancel" ) ) then
                imgui.CloseCurrentPopup()
                gInPopup = false
                gCurrentEditedComponent = nil
                gCurrentEditedEntityIndex = -1
            end
            imgui.EndPopup()
        end

    end

    imgui.End()

    if renderPreviewLine then
        love.graphics.line( xStartingMouse, yStartingMouse, xCurrentMouse, yCurrentMouse )
    end

    if LevelEditor.mDoingMultiselection then

        love.graphics.setColor( 100, 50, 255, 100 )
        love.graphics.rectangle( "fill", LevelEditor.mSelectionRectangle.x, LevelEditor.mSelectionRectangle.y, LevelEditor.mSelectionRectangle.w, LevelEditor.mSelectionRectangle.h )
    end

    for i = 1, #LevelEditor.mSelectedObjects do

        local box2d = LevelEditor.mSelectedObjects[i]
        local rectX, rectY = LevelEditor.mEditorCamera:MapToScreen( box2d.mBody:getX() - box2d.mBodyW/2, box2d.mBody:getY() - box2d.mBodyH/2 )
        local rectW, rectH = box2d.mBodyW * LevelEditor.mEditorCamera.mScale, box2d.mBodyH * LevelEditor.mEditorCamera.mScale

        love.graphics.setColor( 150, 100, 255, 100 )
        love.graphics.rectangle( "fill", rectX, rectY, rectW, rectH )

    end

end


-- EDITOR FUNCTIONS ===================================================


function LevelEditor.SetCamera( iX, iY, iW, iH, iScale )

    LevelEditor.mLevel.mCamera.mX = iX
    LevelEditor.mLevel.mCamera.mY = iY
    LevelEditor.mLevel.mCamera.mW = iW
    LevelEditor.mLevel.mCamera.mH = iH
    LevelEditor.mLevel.mCamera.mScale = iScale

end


function  LevelEditor.SetFixedImage( iImagePath )

    if iImagePath ~= nil and iImagePath ~= "" then
        LevelEditor.mLevel.mFixedBackground = BigImage:New( iImagePath, love.graphics.getWidth() )
    end

end


function  LevelEditor.AddBackground( iFilePath, iX, iY, iDepth )

    table.insert( LevelEditor.mLevel.mBackgrounds, Background:New( iFilePath, iX, iY, iDepth ) )

end


function  LevelEditor.AddForeground( iFilePath, iX, iY, iDepth )

    table.insert( LevelEditor.mLevel.mForegrounds, Background:New( iFilePath, iX, iY, iDepth ) )

end


function  LevelEditor.SaveLevel( iFilePath )

    xmlData = LevelEditor.mLevel:SaveLevelBaseECSXML()
    file = io.open( iFilePath, "w" )
    -- file = io.open( "/home/damien/work2/Love2D/TVPGameJam2017/Save/Level1.xml", "w" )
    file:write( xmlData )
    file:flush()
    file:close()
end


function  LevelEditor.LoadLevel( iFilePath )

    local xml = io.open( iFilePath ):read('*all')
    local doc = SLAXML:dom( xml )
    LevelEditor.Initialize( LevelBaseECS:NewFromXML( doc.root, gWorld ) )

end


-- UNSER INPUTS ===================================================


function LevelEditor.TextInput( iT )
    --Nothing
end


function LevelEditor.KeyPressed( iKey, iScancode, iIsRepeat )

    if iKey == "lalt" then
        LevelEditor.mState = "navigation"
    elseif iKey == "lshift" and LevelEditor.mState ~= "placingterrain" then
        LevelEditor.mState = "propedition"
    elseif iKey == "u" and LevelEditor.mState == "placingterrain" then
        LevelEditor.mLevel.mTerrain:RemoveLastSegment()
    elseif iKey == "delete" then

        for i = #ECSWorld.mEntities, 1, -1 do

            local box2d  = ECSWorld.mEntities[i]:GetComponentByName( "box2d" )

            if box2d and TableContains( LevelEditor.mSelectedObjects, box2d )  then
                table.remove( ECSWorld.mEntities, i )
            end
        end

        ClearTable( LevelEditor.mSelectedObjects )
end

end


function LevelEditor.KeyReleased( iKey, iScancode )

    if iKey == "lalt" then
        LevelEditor.mState = "menu"
    elseif iKey == "lshift" and LevelEditor.mState ~= "placingterrain" then
        LevelEditor.mState = "menu"
    end
end


function LevelEditor.MousePressed( iX, iY, iButton, iIsTouch )

    if LevelEditor.mState == "placingterrain" and not LevelEditor.mLevelPropertiesGUIRect:ContainsPoint( iX, iY ) then

        renderPreviewLine = true
        dragMode = false

    elseif LevelEditor.mState == "navigation" then

        dragMode = true
        previousX, previousY = iX, iY

    elseif LevelEditor.mState == "propedition" and not gInPopup and not LevelEditor.mLevelPropertiesGUIRect:ContainsPoint( iX, iY ) then

        xMapped, yMapped = LevelEditor.mEditorCamera:MapToWorld( iX, iY )
        for k,v in pairs( ECSWorld.mEntities ) do
            local box2d  = v:GetComponentByName( "box2d" )
            if box2d then
                local rect = Rectangle:New( box2d.mBody:getX() - box2d.mBodyW/2, box2d.mBody:getY() - box2d.mBodyH/2, box2d.mBodyW, box2d.mBodyH )
                if rect:ContainsPoint( xMapped, yMapped ) then
                    gCurrentEditedComponent = box2d
                    -- table.insert( LevelEditor.mSelectedObjects, box2d )
                    gCurrentEditedEntityIndex = k
                end
            end
        end


        if gCurrentEditedComponent then
            dragMode = true
            previousX, previousY = iX, iY
        else -- We clicked on void : start multiselection
            LevelEditor.mDoingMultiselection = true
            LevelEditor.mSelectionInitialPositionX = iX
            LevelEditor.mSelectionInitialPositionY = iY
        end

        -- HUD Event forwarding
        if LevelEditor.mTerrainHUD then

            LevelEditor.mTerrainHUD:MousePressed( iX, iY, iButton, iIsTouch )

        end

    end

end


function LevelEditor.MouseMoved( iX, iY )

    if LevelEditor.mState == "placingterrain" and not LevelEditor.mLevelPropertiesGUIRect:ContainsPoint( iX, iY ) then

        xCurrentMouse, yCurrentMouse = iX, iY

        if love.keyboard.isDown( 'lshift' ) then
            yCurrentMouse = yStartingMouse
        elseif love.keyboard.isDown( 'lctrl' ) then
            xCurrentMouse = xStartingMouse
        end

    elseif LevelEditor.mState == "navigation" and dragMode == true then

        local  speedX = ( previousX - iX ) *  ( 1 / ( LevelEditor.mEditorCamera.mScale + 0.01 ) )
        local  speedY = ( previousY - iY ) *  ( 1 / ( LevelEditor.mEditorCamera.mScale + 0.01 ) )

        LevelEditor.mEditorCamera.mX = LevelEditor.mEditorCamera.mX + speedX
        LevelEditor.mEditorCamera.mY = LevelEditor.mEditorCamera.mY + speedY
        previousX, previousY = iX, iY

    elseif LevelEditor.mState == "propedition" then

        if( gCurrentEditedComponent ) then
            local  deltaX = ( iX - previousX ) *  ( 1 / ( LevelEditor.mEditorCamera.mScale + 0.01 ) )
            local  deltaY = ( iY - previousY ) *  ( 1 / ( LevelEditor.mEditorCamera.mScale + 0.01 ) )

            if( gCurrentEditedComponent ) then
                gCurrentEditedComponent.mBody:setX( gCurrentEditedComponent.mBody:getX() + deltaX )
                gCurrentEditedComponent.mBody:setY( gCurrentEditedComponent.mBody:getY() + deltaY )
            end

            -- SELECTION MINUS gCurrentEditedComponent, which is moved above
            for i = 1, #LevelEditor.mSelectedObjects do

                local box2d = LevelEditor.mSelectedObjects[i]
                if box2d ~= gCurrentEditedComponent then -- Because we already moved it
                    box2d.mBody:setX( box2d.mBody:getX() + deltaX )
                    box2d.mBody:setY( box2d.mBody:getY() + deltaY )
                end

            end

            previousX, previousY = iX, iY
        end

        if LevelEditor.mDoingMultiselection then

            LevelEditor.mSelectionRectangle:SetX( LevelEditor.mSelectionInitialPositionX )
            LevelEditor.mSelectionRectangle:SetY( LevelEditor.mSelectionInitialPositionY )
            LevelEditor.mSelectionRectangle:SetX2( iX )
            LevelEditor.mSelectionRectangle:SetY2( iY )

        end

        -- HUD Event forwarding
        if LevelEditor.mTerrainHUD then

            LevelEditor.mTerrainHUD:MouseMoved( iX, iY )

        end

    end

end


function LevelEditor.MouseReleased( iX, iY, iButton, iIsTouch )

    if LevelEditor.mState == "placingterrain" and not LevelEditor.mLevelPropertiesGUIRect:ContainsPoint( iX, iY ) then

        xMapped, yMapped = LevelEditor.mEditorCamera:MapToWorld( iX, iY )

        local rulerType = "norule"

        if love.keyboard.isDown( 'lshift' ) then
            rulerType = "horizontal"
            xStartingMouse = iX
        elseif love.keyboard.isDown( 'lctrl' ) then
            rulerType = "vertical"
            yStartingMouse = iY
        else
            xStartingMouse = iX
            yStartingMouse = iY
        end

        if iButton == 1 then
            LevelEditor.mLevel.mTerrain.AppendEdgeToPrevious( xMapped, yMapped, rulerType )
        elseif iButton == 2 then
            LevelEditor.mLevel.mTerrain.CutEdgeAppending()
            renderPreviewLine = false
        end

        LevelEditor.mTerrainHUD = TerrainHUD:New( LevelEditor.mLevel.mTerrain, LevelEditor.mEditorCamera )

    elseif LevelEditor.mState == "navigation" then

        dragMode = false



    elseif LevelEditor.mState == "propedition" then

        if iButton == 2 and gCurrentEditedComponent then
            gInPopup = true
        elseif not gInPopup then

            if LevelEditor.mDoingMultiselection then

                ClearTable( LevelEditor.mSelectedObjects )

                local xMapped, yMapped = LevelEditor.mEditorCamera:MapToWorld( iX, iY )

                local rectX, rectY = LevelEditor.mEditorCamera:MapToScreen( LevelEditor.mSelectionRectangle.x, LevelEditor.mSelectionRectangle.y )
                local rectW = LevelEditor.mSelectionRectangle.w * LevelEditor.mEditorCamera.mScale
                local rectH = LevelEditor.mSelectionRectangle.h * LevelEditor.mEditorCamera.mScale
                local rectangleMapped = Rectangle:New( rectX, rectY, rectW, rectH )

                for k,v in pairs( ECSWorld.mEntities ) do
                    local box2d  =  v:GetComponentByName( "box2d" )
                    if box2d then
                        local rect = Rectangle:New( box2d.mBody:getX() - box2d.mBodyW/2, box2d.mBody:getY() - box2d.mBodyH/2, box2d.mBodyW, box2d.mBodyH )
                        if rectangleMapped:ContainsRectangleEntirely( rect ) then
                            table.insert( LevelEditor.mSelectedObjects, box2d )
                        end
                    end
                end

            end

            gCurrentEditedComponent = nil
            gCurrentEditedEntityIndex = -1
        end

        LevelEditor.mDoingMultiselection = false
        LevelEditor.mSelectionInitialPositionX = nil
        LevelEditor.mSelectionInitialPositionY = nil
        LevelEditor.mSelectionRectangle:Clear()
        dragMode = false

        -- HUD Event forwarding
        if LevelEditor.mTerrainHUD then

            LevelEditor.mTerrainHUD:MouseReleased( iX, iY, iButton, iIsTouch )

        end

    end

end


function LevelEditor.WheelMoved( iX, iY )

    if LevelEditor.mState == "navigation" then

        LevelEditor.mEditorCamera:SetScale( LevelEditor.mEditorCamera.mScale + iY/20 )

    end

end


return  LevelEditor


