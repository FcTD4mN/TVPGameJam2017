--[[===================================================================
    File: Application.Global.lua

    @@@@: The Global Centralized initializer.
    Init Modules & Singletons.

===================================================================--]]

-- INCLUDES ===========================================================
    -- Modules ========================================================
    Base    = require "src/Base/Utilities/Base"
    Math    = require "src/Math/Utilities/Math"
    Image   = require "src/Image/Utilities/Image"
    Image2  = require "src/Image/Utilities/Image2"

    -- Singletons Objects =============================================
    Manager = require "src/Application/Manager"

    -- Other Dependencies =============================================
    ColorRGBA   = require "src/Image/ColorRGBA"

-- INITIALISATION =====================================================
    -- Modules ========================================================
    Base    = Base:Initialize();
    Math    = Math:Initialize();
    Image   = Image:Initialize();
    Image2  = Image2:Initialize();

    -- Singletons Objects =============================================
    Manager.Initialize();

    -- Color Schemes / Default Color Values ===========================
    --  NAME                                R       G       B       A
    W_COLOR_DEBUG       = ColorRGBA:New(    255,    0,      255,    255     );
    W_COLOR_FILL        = ColorRGBA:New(    204,    201,    202,    255     );
    W_COLOR_OUTLINE     = ColorRGBA:New(    151,    159,    156,    255     );
    W_COLOR_SHADOW      = ColorRGBA:New(    20,     10,     60,     255     );
    E_BACKGROUND        = ColorRGBA:New(    65,     49,     62,     255     );
    grey                = ColorRGBA:New(    35,     35,     35,     255     );
    dark                = ColorRGBA:New(    10,     10,     10,     255     );
    black               = ColorRGBA:New(    0,      0,      0,      255     );



-- DEBUG ===================================================
function  DEBUGWorldHITBOXESDraw( iWorld, iCamera, iWhatToDraw )
    local red = 255
    local green = 0
    local blue = 0

    allBodies = iWorld:getBodyList()

    for a, b in pairs( allBodies ) do
        red = 255
        green = 0
        blue = 0
        fixtures = b:getFixtureList()

        for k,v in pairs( fixtures ) do

            love.graphics.setColor( red, green, blue, 125 )

            -- POLYGONS
            if( v:getShape():getType() == "polygon" ) and ( iWhatToDraw == "all" or iWhatToDraw == "polygon"  ) then

                love.graphics.polygon( "fill", iCamera:MapToScreenMultiple( b:getWorldPoints( v:getShape():getPoints() ) ) )

            -- CIRCLES
            elseif ( v:getShape():getType() == "circle" ) and ( iWhatToDraw == "all" or iWhatToDraw == "circle"  ) then

                radius  = v:getShape():getRadius()
                x, y    = v:getShape():getPoint()
                xBody, yBody = b:getPosition()

                -- x, y are coordinates from the center of body, so we offset to match center in screen coordinates
                x = x + xBody
                y = y + yBody
                x, y = iCamera:MapToScreen( x, y )
                love.graphics.circle( "fill", x, y, radius )

            -- EDGES
            elseif ( v:getShape():getType() == "edge" ) and ( iWhatToDraw == "all" or iWhatToDraw == "edge"  ) then

                love.graphics.setColor( 255, 0, 0, 200 )
                love.graphics.line( iCamera:MapToScreenMultiple( b:getWorldPoints( v:getShape():getPoints() ) ) )

            -- CHAINS
            elseif ( v:getShape():getType() == "chain" ) and ( iWhatToDraw == "all" or iWhatToDraw == "chain"  ) then

                --TODO
            end

            -- We cycle through colors
            red = red + 100
            green = green + math.floor( red / 255 ) * 100
            blue = blue + math.floor( blue / 255 ) * 100
            red = red % 256
            green = green % 256
            blue = blue % 256

        end

    end

end
