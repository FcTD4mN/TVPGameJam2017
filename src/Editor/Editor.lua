require "imgui"

local LevelBase   = require( "src/Game/Level/LevelBase")
local LevelEditor   = require( "src/Editor/LevelEditor")
local Camera      = require( "src/Camera/Camera")


local BigImage    = require( "src/Image/BigImage" )

Editor = {
    mEditingLevel = nil
}

gWorld   = nil
local gCamera  = nil
local gCameraX = 0
local gCameraY = 0
local gCameraW = 800
local gCameraH = 600
local gCameraScale = 1.0


function Editor.Update( iDT )
    imgui.NewFrame()
end


function Editor.Draw()

    status, mainCommands = imgui.Begin( "MainMenu", nil, { "AlwaysAutoResize" } );

        if( imgui.Button( "New Level" ) ) then
            imgui.OpenPopup( "Camera settings" )
        end
        if imgui.BeginPopupModal( "Camera settings", nil, { "AlwaysAutoResize", "NoResize" } ) then

            xStatus, gCameraX = imgui.InputInt( "X", gCameraX )
            imgui.SameLine()
            yStatus, gCameraY = imgui.InputInt( "Y", gCameraY )

            wStatus, gCameraW = imgui.InputInt( "W", gCameraW )
            imgui.SameLine()
            hStatus, gCameraH = imgui.InputInt( "H", gCameraH )

            hStatus, gCameraScale = imgui.InputInt( "Scale", gCameraScale )

            if( imgui.Button( "Ok" ) ) then
                imgui.CloseCurrentPopup()
                Editor.SetCamera( gCameraX, gCameraY, gCameraW, gCameraH, gCameraScale )
                Editor.NewLevel()
            end
            imgui.EndPopup()
        end

    imgui.End()


    if( Editor.mEditingLevel ) then

        LevelEditor.Draw()

    end

    imgui.ShowTestWindow( true )
    imgui.Render()
end


function Editor.Quit()
    imgui.ShutDown();
end


function  ObjectDraw(x,y,w,h)

    love.graphics.setColor( 255, 0,0);
    love.graphics.rectangle( "fill", x,y, w, h );

end


-- EDITOR FUNCTIONS ===================================================



function Editor.SetCamera( iX, iY, iW, iH, iScale )

    gCamera = Camera:New( iX, iY, iW, iH, iScale )

end


function Editor.NewLevel()

    gWorld = love.physics.newWorld( 0, 9.81 * love.physics.getMeter(), true ) --normal gravity

    Editor.mEditingLevel  =  true
    LevelEditor.Initialize( LevelBase:New( gWorld, gCamera ) )

end


-- UNSER INPUTS ===================================================


function Editor.TextInput( iT )
    imgui.TextInput( iT )
    LevelEditor.TextInput( iT )
end


function Editor.KeyPressed( iKey, iScancode, iIsRepeat )
    imgui.KeyPressed( iKey )
    LevelEditor.KeyPressed( iKey, iScancode, iIsRepeat )
end


function Editor.KeyReleased( iKey, iScancode )
    imgui.KeyReleased( iKey )
    LevelEditor.KeyReleased( iKey, iScancode )
end


function Editor.MouseMoved( iX, iY )
    imgui.MouseMoved( iX, iY )
    LevelEditor.MouseMoved( iX, iY )
end


function Editor.MousePressed( iX, iY, iButton, iIsTouch )
    imgui.MousePressed( iButton )
    LevelEditor.MousePressed( iX, iY, iButton, iIsTouch )
end


function Editor.MouseReleased( iX, iY, iButton, iIsTouch )
    imgui.MouseReleased( iButton )
    LevelEditor.MouseReleased( iX, iY, iButton, iIsTouch )
end


function Editor.WheelMoved( iX, iY )
    imgui.WheelMoved( iY )
    LevelEditor.WheelMoved( iX, iY )
end


return  Editor
