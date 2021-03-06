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

-- Does the opposite of unpack(), takes n arguments and packs them in a table
function Pack( ... )

    local table = {}
    for k, v in pairs({...}) do
        table[k] = v
    end
    return  table

end

-- Clears a table
function ClearTable( iTable )

    for k in pairs( iTable ) do
        iTable[ k ] = nil
    end

end

-- Gets index of iObject in iTable
function GetObjectIndexInTable( iTable, iObject )

    for i = 1, #iTable do

        if iTable[ i ] == iObject then
            return  i
        end

    end

    return  -1

end
-- Gets index of iObject in iTable
function TableContains( iTable, iObject )

    for i = 1, #iTable do

        if iTable[i] == iObject then
            return  true
        end

    end

    return  false

end


-- Hey, lua doesn't have built in spliter, we need to do it ourselves ...
function SplitString( iString, iSeparator )

    local sep, fields = iSeparator, {}
    local pattern = string.format( "([^%s]+)", iSeparator )
    string.gsub( iString, pattern, function(c) fields[ #fields+1 ] = c end)

    return  fields

end

-- Converts a string to a boolean, returns true if iValue == "true"
function ToBoolean( iValue )
    return  iValue == "true"
end

function DeepCopyTable( iTable )
    local iTable_type = type(iTable)
    local copy
    if iTable_type == 'table' then
        copy = {}
        for iTable_key, iTable_value in next, iTable, nil do
            copy[deepcopy(iTable_key)] = deepcopy(iTable_value)
        end
        setmetatable(copy, deepcopy(getmetatable(iTable)))
    else -- number, string, boolean, etc
        copy = iTable
    end
    return copy
end



function  ReverseTable( iTable )

    local reversedTable = {}
    for i=#iTable, 1, -1 do

        table.insert( reversedTable, iTable[i] )

    end

    return  reversedTable
end

function deepCopy(object)
    local lookup_table = {}
    local function _copy(object)
        if type(object) ~= "table" then
            return object
        elseif lookup_table[object] then
            return lookup_table[object]
        end
        local new_table = {}
        lookup_table[object] = new_table
        for index, value in pairs(object) do
            new_table[_copy(index)] = _copy(value)
        end
        return setmetatable(new_table, getmetatable(object))
    end
    return _copy(object)
end

function shallowCopy (t) -- shallow-copy a table
    if type(t) ~= "table" then return t end
    local meta = getmetatable(t)
    local target = {}
    for k, v in pairs(t) do target[k] = v end
    setmetatable(target, meta)
    return target
end



-- RETURN CHUNK AS GLOBAL OBJECT ======================================
return Base
