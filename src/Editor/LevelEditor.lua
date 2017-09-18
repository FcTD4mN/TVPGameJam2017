require( "imgui" )

local Background    = require( "src/Image/Background" )
local Terrain       = require( "src/Objects/Terrain" )
local LevelBase     = require( "src/Game/Level/LevelBase" )
local SLAXML        = require 'src/ExtLibs/XML/SLAXML/slaxdom'


LevelEditor = {
    mLevel = nil,
    mState = "menu"
}



local renderPreviewLine = false
local xStartingMouse, yStartingMouse = 0, 0
local xCurrentMouse, yCurrentMouse = 0, 0


function LevelEditor.Initialize( iLevel )

    LevelEditor.mLevel = iLevel


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
    gFileName = ""

    gFixedBGFile = "test"

end

function LevelEditor.Draw()

    if( LevelEditor.mLevel ) then

        LevelEditor.mLevel:Draw()
        DEBUGWorldHITBOXESDraw( gWorld, LevelEditor.mLevel.mCamera, "all" )

    end

    status, mainCommands = imgui.Begin( "Level Properties", nil, { "AlwaysAutoResize" } );



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

            if LevelEditor.mState == "menu" then
                if( imgui.Button( "Start terrain edition" ) ) then
                    LevelEditor.mState = "placingterrain"
                    love.mouse.setCursor( love.mouse.getSystemCursor( "crosshair" ) )
                end
            elseif LevelEditor.mState == "placingterrain" then
                if( imgui.Button( "Stop terrain edition" ) ) then
                    LevelEditor.mState = "menu"
                    love.mouse.setCursor( love.mouse.getSystemCursor( "arrow" ) )
                    renderPreviewLine = false
                    LevelEditor.mLevel.mTerrain.RemoveLastSegment() -- Cuz event still goes to mouse event first ..
                end
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


function LevelEditor.MousePressed( iX, iY, iButton, iIsTouch )

    if LevelEditor.mState == "placingterrain" then

        renderPreviewLine = true

    end

end


function LevelEditor.MouseMoved( iX, iY )

    if LevelEditor.mState == "placingterrain" then

        xCurrentMouse, yCurrentMouse = iX, iY

        if love.keyboard.isDown( 'lshift' ) then
            yCurrentMouse = yStartingMouse
        elseif love.keyboard.isDown( 'lctrl' ) then
            xCurrentMouse = xStartingMouse
        end

    end

end


function LevelEditor.MouseReleased( iX, iY, iButton, iIsTouch )

    if LevelEditor.mState == "placingterrain" then

        -- xStartingMouse, yStartingMouse = iX, iY

        xMapped, yMapped = LevelEditor.mLevel.mCamera:MapToWorld( iX, iY )

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

    end

end


function LevelEditor.WheelMoved( iX, iY )

    -- LevelEditor.mLevel.mCamera.mScale = LevelEditor.mLevel.mCamera.mScale + iY/10

end


return  LevelEditor


