--[[=================================================================== 
    File: Base.Base.lua

    @@@@: This is the Base Module.
    A module is a Global Singleton Objects that will act like a
    namespace. See Base.Module.lua for more details.

===================================================================--]]

-- INCLUDES ===========================================================
------- Modules =======================================================
local Module    = require "src/Base/Module"

-- MODULE INITIALISATION ==============================================
local Base = {}
setmetatable( Base, Module )
Module.__index = Module

function Base:Initialize()
    local newBase = {}
    setmetatable( newBase, self )
    self.__index = self
    
    -- Init module members
    newBase.name = "Base";

    return newBase

end

-- MODULE FUNCTIONS ===================================================
-- Short alias for print
function Base:log( iString )
    print( iString )

end



-- Short alias for _separator
function Base:separator()
    print("==========================================================");

end



-- Short alias for new line
function Base:endl()
    log("");

end



-- _log + InvalidOperation for error handling
function Base:Crash( iErrorMessage )
    Base:separator(); Base:endl(); if( iErrorMessage ) then Base:log( iErrorMessage ); Base:endl(); end Base:log( "Program Crash Requested" ); Base:endl(); Base:separator();
    local invalidOperation;
    print( invalidOperation["No Wai-"] );

end



-- necessary condition check, optional message
function Base:xAssert( iCondition, iMessage )
    if( iCondition == false ) then
        if( iMessage ) then Base:log( iMessage ); end
        Base:Crash("Crash on xAssert");
    end

end



function Base:IsNil( iParameter )
    return iParameter == nil;

end



-- is type of iParameter one of these... objects are typically tables
function Base:IsBasicType( iParameter )
    local basicTypes = "boolean number string table";
    return  string.find(basicTypes, type( iParameter ) );

end



function Base:IsValidObject( iParameter)
    if( type( iParameter ) == "table" ) then
        if( iParameter[ Type ] ) then
            if( type( iParameter:Type() ) == "string" ) then
                return true;
            end
        end
    end
    return false;

end



function Base:SmartType( iParameter )
    local parameterType = nil;
    if( Base:IsValidObject( iParameter ) ) then
        parameterType = iParameter:Type();
    end
    if( Base:IsBasicType( iParameter ) ) then
        parameterType = type( iParameter );
    end

    return parameterType;
end


-- Make sure your input parameters are valid
function Base:ValidParameter( iParameter, iType, iDefaultValue)
    local paramType = Base:SmartType( iParameter );
    if( iType == paramType ) then
        return iParameter;
    else
        return iDefaultValue;
    end
end

-- RETURN CHUNK AS GLOBAL OBJECT ======================================
return Base