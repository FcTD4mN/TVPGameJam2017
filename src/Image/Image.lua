--[[=================================================================== 
    File: Image.Image.lua

    @@@@: This is the Image Module.
    A module is a Global Singleton Objects that will act like a
    namespace. See Base.Module.lua for more details.

===================================================================--]]

-- INCLUDES ===========================================================
------- Modules =======================================================
local Module    = require "src/Base/Module"

-- MODULE INITIALISATION ==============================================
local Image = {}
setmetatable( Image, Module )
Module.__index = Module

function Image:Initialize()
    local newImage = {}
    setmetatable( newImage, self )
    self.__index = self
    
    -- Init module members
    newImage.name = "Image";

    return newImage

end

-- MODULE FUNCTIONS ===================================================
-- NONE YET

-- RETURN CHUNK AS GLOBAL OBJECT ======================================
return Image