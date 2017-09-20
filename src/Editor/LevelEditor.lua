require( "imgui" )

local Background    = require( "src/Image/Background" )
local Camera        = require( "src/Camera/Camera")
local LevelBase     = require( "src/Game/Level/LevelBase" )
local Rectangle     = require( "src/Math/Rectangle" )
local Terrain       = require( "src/Objects/Terrain" )
local SLAXML        = require 'src/ExtLibs/XML/SLAXML/slaxdom'

-- ASSETS
--      HEROS
local Lapin         = require( "src/Objects/Heros/Lapin")
local Singe         = require( "src/Objects/Heros/Singe")

--      ENVIRONNEMENT
local BabyTree      = require( "src/Objects/Environnement/BabyTree")
local GrownTree     = require( "src/Objects/Environnement/GrownTree")
local Object_Box    = require( "src/Objects/Environnement/Object_Box")
local Tree          = require( "src/Objects/Environnement/Tree")
local WaterPipe     = require( "src/Objects/Environnement/WaterPipe")


-- TODO: Add it in Base/Global
ObjectPool      = require "src/Objects/Pools/ObjectPool"


LevelEditor = {
    mLevel = nil,
    mState = "uninitialized",
    mEditorCamera = nil,
    mLevelPropertiesGUIRect = nil
}



local renderPreviewLine = false
local dragMode = false
local xStartingMouse, yStartingMouse = 0, 0
local xCurrentMouse, yCurrentMouse = 0, 0

local gCurrentEditedAsset = nil
local gInPopup = false


function LevelEditor.Initialize( iLevel )

    LevelEditor.mLevel = iLevel
    LevelEditor.mEditorCamera = Camera:New( 0, 0, love.graphics.getWidth(), love.graphics.getHeight(), 1.0 )


    Terrain.Initialize( LevelEditor.mLevel.mWorld )
    LevelEditor.mLevel.mTerrain = Terrain

    gCameraX = LevelEditor.mLevel.mCamera.mX
    gCameraY = LevelEditor.mLevel.mCamera.mY
    gCameraW = LevelEditor.mLevel.mCamera.mW
    gCameraH = LevelEditor.mLevel.mCamera.mH
    gCameraScale = LevelEditor.mLevel.mCamera.mScale

    gIntX = 0
    gIntY = 0
    gIntA = 0
    gFileName = "Save/Level1.xml" -- Just so it's quicker to debug

    gFixedBGFile = "test"

    LevelEditor.mState = "menu"
    LevelEditor.mLevelPropertiesGUIRect = Rectangle:New( 0, 0, 0, 0 )

end

function LevelEditor.Draw()

    if( LevelEditor.mLevel ) then

        LevelEditor.mLevel:Draw( LevelEditor.mEditorCamera )
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
                gCurrentEditedAsset:Destroy()
                ObjectPool.Update( 0 )
                gInPopup = false
                gCurrentEditedAsset = nil
            end

            if( imgui.Button( "Cancel" ) ) then
                imgui.CloseCurrentPopup()
                gInPopup = false
                gCurrentEditedAsset = nil
            end
            imgui.EndPopup()
        end

    end

    imgui.End()

    if renderPreviewLine then
        love.graphics.line( xStartingMouse, yStartingMouse, xCurrentMouse, yCurrentMouse )
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

    xmlData = LevelEditor.mLevel:SaveLevelBaseXML()
    file = io.open( iFilePath, "w" )
    -- file = io.open( "/home/damien/work2/Love2D/TVPGameJam2017/Save/Level1.xml", "w" )
    file:write( xmlData )

end


function  LevelEditor.LoadLevel( iFilePath )

    local xml = io.open( iFilePath ):read('*all')
    local doc = SLAXML:dom( xml )
    LevelEditor.Initialize( LevelBase:NewFromXML( doc.root, gWorld ) )

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
        gCurrentEditedAsset = ObjectPool.ObjectAtCoordinates( xMapped, yMapped )

        if gCurrentEditedAsset then
            dragMode = true
            previousX, previousY = iX, iY
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

    elseif LevelEditor.mState == "propedition" and dragMode == true then

        local  speedX = ( iX - previousX ) *  ( 1 / ( LevelEditor.mEditorCamera.mScale + 0.01 ) )
        local  speedY = ( iY - previousY ) *  ( 1 / ( LevelEditor.mEditorCamera.mScale + 0.01 ) )

        if( gCurrentEditedAsset ) then
            gCurrentEditedAsset:SetX( gCurrentEditedAsset:GetX() + speedX )
            gCurrentEditedAsset:SetY( gCurrentEditedAsset:GetY() + speedY )
            previousX, previousY = iX, iY
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

        LevelEditor.mLevel.mTerrain.AppendEdgeToPrevious( xMapped, yMapped, rulerType )

    elseif LevelEditor.mState == "navigation" then

        dragMode = false

    elseif LevelEditor.mState == "propedition" then

        if iButton == 2 and gCurrentEditedAsset then
            gInPopup = true
        elseif not gInPopup then
            gCurrentEditedAsset = nil
        end
        dragMode = false

    end

end


function LevelEditor.WheelMoved( iX, iY )

    if LevelEditor.mState == "navigation" then

        LevelEditor.mEditorCamera:SetScale( LevelEditor.mEditorCamera.mScale + iY/20 )

    end

end


return  LevelEditor


