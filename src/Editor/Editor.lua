require "imgui"


Editor = {}

--
-- LOVE callbacks
--

function Editor.Update( iDT )
    imgui.NewFrame()
end

local draw = false

function Editor.Draw()

    imgui.SetNextWindowPos(0, 0)
    imgui.SetNextWindowSize(love.graphics.getWidth(), love.graphics.getHeight())
    if imgui.Begin("DockArea", nil, { "NoTitleBar", "NoResize", "NoMove", "NoBringToFrontOnFocus" }) then
        imgui.BeginDockspace()

        -- Create 10 docks
        for i = 1, 10 do
            if imgui.BeginDock("dock_"..i) then
                imgui.Text("Hello, dock "..i.."!");
            end
            imgui.EndDock()
        end

        if imgui.BeginDock("DrawingDock") then
            x, y = imgui.GetItemRectMin()
            w, h = imgui.GetWindowSize()
            w = w - 16
            h = h - 34
            if imgui.Button("Draw") then
                draw = not draw
            end
        end
        imgui.EndDock()


        imgui.EndDockspace()
    end
    imgui.End()

    love.graphics.clear(100, 100, 100, 255)
    imgui.Render();
    if draw then
        ObjectDraw( x, y, w, h )
    end
end

function Editor.Quit()
    imgui.ShutDown();
end

function  ObjectDraw(x,y,w,h)

    love.graphics.setColor( 255, 0,0);
    love.graphics.rectangle( "fill", x,y, w, h );

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
