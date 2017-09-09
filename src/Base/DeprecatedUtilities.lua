--[[=================================================================== 
    File: Base.Utilities.lua
    @@@@: Basic handy methods
===================================================================--]]

-- INCLUDES ===========================================================
require("src/Math/Utilities");

-- FUNCTIONS ==========================================================

-- Short alias for print
function _log( iString )
    print( iString )

end



-- Short alias for _separator
function _separator()
    print("==========================================================");

end



-- Short alias for new line
function _endl()
    _log("");

end



-- _log + InvalidOperation for error handling
function Crash( iErrorMessage )
    _separator(); _endl(); if( iErrorMessage ) then _log( iErrorMessage ); _endl(); end _log( "Program Crash Requested" ); _endl(); _separator();
    local invalidOperation;
    print( invalidOperation["No Wai-"] );

end



-- necessary condition check, optional message
function xAssert( iCondition, iMessage )
    if( iCondition == false ) then
        if( iMessage ) then _log( iMessage ); end
        Crash("Crash on xAssert");
    end

end



function IsNil( iParameter )
    return iParameter == nil;

end



-- is type of iParameter one of these... objects are typically tables
function IsBasicType( iParameter )
    local basicTypes = "boolean number string table";
    return  string.find(basicTypes, type( iParameter ) );

end



function IsValidObject( iParameter)
    if( type( iParameter ) == "table" ) then
        if( iParameter[ Type ] ) then
            if( type( iParameter:Type() ) == "string" ) then
                return true;
            end
        end
    end
    return false;

end



function SmartType( iParameter )
    local parameterType = nil;
    if( IsValidObject( iParameter ) ) then
        parameterType = iParameter:Type();
    end
    if( IsBasicType( iParameter ) ) then
        parameterType = type( iParameter );
    end

    return parameterType;
end


-- Make sure your input parameters are valid
function ValidParameter( iParameter, iType, iDefaultValue)
    local paramType = SmartType( iParameter );
    if( iType == paramType ) then
        return iParameter;
    else
        return iDefaultValue;
    end
end
