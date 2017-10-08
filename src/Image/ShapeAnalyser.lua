local  Camera       =  require("src/Camera/Camera")
local  Rectangle    =  require("src/Math/Rectangle")
local  Point        =  require("src/Math/Point")


ShapeAnalyser  = {
    mTopLeftVertices = {},
    mTopRightVertices = {},
    mBottomLeftVertices = {},
    mBottomRightVertices = {},

    mImage = 0, -- Shared resource, read only

    mArea = 0,
    mBrushSize = 0,
}


function  ShapeAnalyser.Initialize( iImageFile  )

    ShapeAnalyser.mImage = love.image.newImageData( iImageFile )
    ShapeAnalyser.mImageDrawable = love.graphics.newImage( iImageFile )

end


function  ShapeAnalyser.Run( iArea, iBrushSize, iStep )

    ShapeAnalyser.mArea = iArea
    ShapeAnalyser.mBrushSize = iBrushSize

    local  widthIterations = iArea.w / iBrushSize
    local  heightIterations = iArea.h / iBrushSize

    for w = 0, widthIterations - 1 do

        for h = 0, heightIterations - 1 do

            ShapeAnalyser.ProcessArea( Rectangle:New( w * iBrushSize, h * iBrushSize, iBrushSize, iBrushSize ), iStep )

        end

    end

    -- TODO: process the remaining part that's left over
    -- local remaining
    -- ProcessArea( Rectangle:New( w * iBrushSize, h * iBrushSize, iBrushSize, iBrushSize ), iStep )

end


function  ShapeAnalyser.ProcessArea( iArea, iStep )

    -- This area is a subdivision of the size of the brush
    -- This will simplifie the analysis as there can only be at worst a + shape of clear area
    -- So as we read top to bottom, there will be a fine line separating top from bottom

    -- Are we on the top part or the bottom part
    local  overOpaque = false
    local  state = {}

    local  topState = "Left"
    local  bottomState = "Left"
    local  currentState = 0

    for x = 0, iArea.w-1, iStep do

        overOpaque = false
        for y = 0, iArea.h-1 do

            local r, g, b, a = ShapeAnalyser.mImage:getPixel( x, y )

            if y == 0 and a < 127 then
                topState = "Right"
            elseif y == iArea.h-1 and a < 127 then
                bottomState = "Right"
            end

            if a >= 127 and not overOpaque then

                if y == 0 then
                    currentState = "Top"
                else
                    currentState = "Bottom"
                end
                ShapeAnalyser.AddXY( x, y, currentState, topState, bottomState )
                overOpaque = true

            elseif a < 127 and overOpaque then

                ShapeAnalyser.AddXY( x, y, currentState, topState, bottomState )
                overOpaque = false
            end


        end

        local r, g, b, a = ShapeAnalyser.mImage:getPixel( x, iArea.h-1 )

        if( a >= 127 ) then
            ShapeAnalyser.AddXY( x, iArea.h-1, currentState, topState, bottomState )
        end

    end

    print( "DONE" )
end


function  ShapeAnalyser.AddXY( iX, iY, iCurrentState, iTopState, iBottomState  )

    if iCurrentState == "Top" and iTopState == "Left" then
        table.insert( ShapeAnalyser.mTopLeftVertices, Point:New( iX, iY ) )
    elseif iCurrentState == "Top" and iTopState == "Right" then
        table.insert( ShapeAnalyser.mTopRightVertices, Point:New( iX, iY ) )
    elseif iCurrentState == "Bottom" and iBottomState == "Left" then
        table.insert( ShapeAnalyser.mBottomLeftVertices, Point:New( iX, iY ) )
    elseif iCurrentState == "Bottom" and iBottomState == "Right" then
        table.insert( ShapeAnalyser.mBottomRightVertices, Point:New( iX, iY ) )
    end

end

function  ShapeAnalyser.DebugDraw( iCamera )


    love.graphics.setColor( 255, 255, 255, 255 )

    local xImage, yImage = iCamera:MapToWorld( 0, 0 )

    love.graphics.draw( ShapeAnalyser.mImageDrawable, xImage, yImage, 0 )
    local handleSize = 2

    love.graphics.setColor( 255, 0, 0, 255 )
    for k,v in pairs( ShapeAnalyser.mTopLeftVertices ) do

        local x = v.mX - handleSize/2
        local y = v.mY - handleSize/2
        x, y = iCamera:MapToWorld( x, y )

        love.graphics.rectangle( "line", x, y, handleSize, handleSize )

    end
    love.graphics.setColor( 0, 255, 0, 255 )
    for k,v in pairs( ShapeAnalyser.mTopRightVertices ) do

        local x = v.mX - handleSize/2
        local y = v.mY - handleSize/2
        x, y = iCamera:MapToWorld( x, y )

        love.graphics.rectangle( "line", x, y, handleSize, handleSize )

    end

    love.graphics.setColor( 0, 0, 255, 255 )
    for k,v in pairs( ShapeAnalyser.mBottomLeftVertices ) do

        local x = v.mX - handleSize/2
        local y = v.mY - handleSize/2
        x, y = iCamera:MapToWorld( x, y )

        love.graphics.rectangle( "line", x, y, handleSize, handleSize )

    end
    love.graphics.setColor( 255, 255, 0, 255 )
    for k,v in pairs( ShapeAnalyser.mBottomRightVertices ) do

        local x = v.mX - handleSize/2
        local y = v.mY - handleSize/2
        x, y = iCamera:MapToWorld( x, y )

        love.graphics.rectangle( "line", x, y, handleSize, handleSize )

    end

end


return  ShapeAnalyser

