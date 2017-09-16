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
