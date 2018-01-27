--[[===================================================================
    File: Math.VertexCover.VertexCover.lua

    @@@@: This is the VertexCover Module.
    A module is a Global Singleton Objects that will act like a
    namespace. See Base.Module.lua for more details.

===================================================================--]]

-- INCLUDES ===========================================================
local Module = require "src/Base/Module"
local Module = require "src/Math/Utilities/Math"


-- MODULE INITIALISATION ==============================================
local VertexCover = {}
setmetatable( VertexCover, Module )
Module.__index = Module

function VertexCover:Initialize()
    local newVertexCover = {}
    setmetatable( newVertexCover, self )
    self.__index = self

    return newVertexCover

end


-- MODULE FUNCTIONS ===================================================


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


function VertexCover:FindPaths( iNodeA, iNodeB )

    local nodeHistory = {}
    local solutions = {}
    VertexCover:ExplorePathRecursive( iNodeA, iNodeB, nodeHistory, solutions )
    return solutions
end

function VertexCover:ExplorePathRecursive( iCurrentNode, iDestinationNode, iNodeHistory, iSolutions )

    local nodeHistory = deepCopy( iNodeHistory )
    table.insert( nodeHistory, iCurrentNode )

    if( iCurrentNode == iDestinationNode ) then
        table.insert( iSolutions, nodeHistory )
        return
    end

    for i = 1, #iCurrentNode.mConnections do
        local nextExploreNode = iCurrentNode.mConnections[i]
        if( not TableContains( nodeHistory, nextExploreNode ) ) then
            VertexCover:ExplorePathRecursive( nextExploreNode, iDestinationNode, nodeHistory, iSolutions )
        end
    end

end


function VertexCover:AddConnection( iNodeA, iNodeB, iWeight )

    table.insert( iNodeA.mConnections, iNodeB )
    table.insert( iNodeA.mWeights, iWeight )

    table.insert( iNodeB.mConnections, iNodeB )
    table.insert( iNodeB.mWeights, iWeight )

end

function VertexCover:RemoveConnection( iNodeA, iNodeB )

    local indexA = GetObjectIndexInTable( iNodeA.mConnections, iNodeB )
    table.remove( iNodeA.mConnections, indexA )
    table.remove( iNodeA.mWeights, indexA )

    local indexB = GetObjectIndexInTable( iNodeB.mConnections, iNodeA )
    table.remove( iNodeB.mConnections, indexB )
    table.remove( iNodeB.mWeights, indexB )

end 


function VertexCover:Distance( iNodeA, iNodeB )
    return iNodeA.mProperty:SubstractionResult( iNodeB.mProperty ):LengthSquared()
end


-- RETURN CHUNK AS GLOBAL OBJECT ======================================
return VertexCover
