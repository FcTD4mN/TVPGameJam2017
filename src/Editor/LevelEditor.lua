require( "imgui" )

LevelEditor = {
    mLevel = nil
}


function LevelEditor.Initialize( iLevel )

    LevelEditor.mLevel = iLevel

end

function LevelEditor.Draw()

    status, mainCommands = imgui.Begin( "Level Properties", nil, { "AlwaysAutoResize" } );

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

            if( imgui.Button( "Ok" ) ) then
                imgui.CloseCurrentPopup()
                Editor.SetCamera( gCameraX, gCameraY, gCameraW, gCameraH )
            end
            imgui.EndPopup()
        end

        if( imgui.Button( "Set fixed background" ) ) then
            imgui.OpenPopup( "Image path" )
        end
        if imgui.BeginPopupModal( "Image path", nil, { "AlwaysAutoResize", "NoResize" } ) then

            xStatus, text = imgui.InputText( "Image path" );

            if( imgui.Button( "Ok" ) ) then
                imgui.CloseCurrentPopup()
                Editor.SetFixedImage( text )
            end
            imgui.EndPopup()
        end

    imgui.End()

end


-- EDITOR FUNCTIONS ===================================================



function LevelEditor.SetCamera( iX, iY, iW, iH, iScale )

    LevelEditor.mLevel.mCamera.mX = iX
    LevelEditor.mLevel.mCamera.mY = iY
    LevelEditor.mLevel.mCamera.mW = iW
    LevelEditor.mLevel.mCamera.mH = iH

end


function  LevelEditor.SetFixedImage( iImagePath )

    LevelEditor.mLevel.mFixedBackground = BigImage:New( iImagePath, love.graphics.getWidth() )

end


return  LevelEditor


