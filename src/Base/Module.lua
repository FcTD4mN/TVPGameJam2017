--[[=================================================================== 
    File: Base.Module.lua

    @@@@: A module is a Global Singleton Objects that will act like a
    namespace. A module is actually just a table in lua, with
    associated variables and functions.
    
    Its use differs with regular objects though:
        • A module is meant to be a Singleton.
        • A module is meant to be global.
        • A module is meant to be seen like a namespace, it provides 
          a layer of encapsulation to avoid function override and 
          name conflicts.
        • It provides a clean way to organise functions sets by roles.
        • It provides a clean way to avoid multiple inclusion hence
          having inter dependant modules by being loaded only once 
          ( see Global.lua ).
          
===================================================================--]]

-- INCLUDES ===========================================================
-- NONE

-- MODULE INITIALISATION ==============================================
local Module = {};

function Module:Initialize()
    newModule = {}
    setmetatable( newModule, self );
    self.__index = self;

    -- Init module members
    -- This should be inherited and overriden
    newModule.name = "Default";

    return  newModule;

end

-- This will be inherited by all Modules
function Module:Type()
    return "Module"

end

-- MODULE FUNCTIONS ===================================================
-- NONE HERE

-- RETURN CHUNK AS GLOBAL OBJECT ======================================
return Module
