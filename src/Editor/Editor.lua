require "imgui"

local LevelBase   = require( "src/Game/Level/LevelBase")
local LevelEditor   = require( "src/Editor/LevelEditor")
local Camera      = require( "src/Camera/Camera")


local BigImage    = require( "src/Image/BigImage" )

Editor = {
    mCurrentEditedLevel = nil
}

local gWorld   = nil
local gCamera  = nil
local gCameraX = 0
local gCameraY = 0
local gCameraW = 800
local gCameraH = 600


function Editor.Update( iDT )
    imgui.NewFrame()
end


function Editor.Draw()

    if( Editor.mCurrentEditedLevel ) then
        Editor.mCurrentEditedLevel:Draw()
    end

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

            if( imgui.Button( "Ok" ) ) then
                imgui.CloseCurrentPopup()
                Editor.SetCamera( gCameraX, gCameraY, gCameraW, gCameraH )
                Editor.NewLevel()

            end
            imgui.EndPopup()
        end

    imgui.End()


    if( Editor.mCurrentEditedLevel ) then

        LevelEditor.Draw()

    end


    imgui.ShowTestWindow( true )
    imgui.Render()

    -- imgui.SetNextWindowSize(love.graphics.getWidth(), love.graphics.getHeight())
    -- if imgui.Begin("DockArea", nil, { "NoTitleBar", "NoResize", "NoMove", "NoBringToFrontOnFocus" }) then
    --     imgui.BeginDockspace()

    --     if imgui.BeginDock("DrawingDock") then
    --         x, y = imgui.GetItemRectMin()
    --         w, h = imgui.GetWindowSize()
    --         w = w - 16
    --         h = h - 34
    --         if imgui.Button("Draw") then
    --             draw = not draw
    --         end
    --     end
    --     imgui.EndDock()
    --     imgui.EndDockspace()
    -- end
    -- imgui.End()

    -- love.graphics.clear(100, 100, 100, 255)
    -- imgui.Render();
    -- if draw then
    --     ObjectDraw( x, y, w, h )
    -- end
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

    Editor.mCurrentEditedLevel  = LevelBase:New( gWorld, gCamera )
    LevelEditor.Initialize( Editor.mCurrentEditedLevel )

end


-- UNSER INPUTS ===================================================


function Editor.TextInput( iT )
    imgui.TextInput( iT )
end


function Editor.KeyPressed( iKey, iScancode, iIsRepeat )
    imgui.KeyPressed( iKey )
end


function Editor.KeyReleased( iKey, iScancode )
    imgui.KeyReleased( iKey )
end


function Editor.MouseMoved( iX, iY )
    imgui.MouseMoved( iX, iY )
end


function Editor.MousePressed( iX, iY, iButton, iIsTouch )
    imgui.MousePressed( iButton )
end


function Editor.MouseReleased( iX, iY, iButton, iIsTouch )
    imgui.MouseReleased( iButton )
end


function Editor.WheelMoved( iX, iY )
    imgui.WheelMoved( iY )
end


return  Editor
