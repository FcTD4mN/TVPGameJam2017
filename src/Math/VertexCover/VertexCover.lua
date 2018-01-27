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


function VertexCover:FindShortestPath( iNodeA, iNodeB )
    
    local solutions = VertexCover:FindPaths( iNodeA, iNodeB )
    local smallestWeight = 9999999999999999999999999999999999999999
    local smallestIndex = -1
    for i=1, #solutions do
        local sum = VertexCover:ComputePathWeight( solutions[ i ] )
        
        if( sum < smallestWeight ) then
            smallestWeight = sum
            smallestIndex = i
        end

    end

    return solutions[i]
end

function VertexCover:FindPaths( iNodeA, iNodeB )
    local nodeHistory = {}
    local solutions = {}
    VertexCover:ExplorePathRecursive( iNodeA, iNodeB, nodeHistory, solutions )
    return solutions
end

function VertexCover:ExplorePathRecursive( iCurrentNode, iDestinationNode, iNodeHistory, iSolutions )

    local nodeHistory = shallowCopy( iNodeHistory )
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

    table.insert( iNodeB.mConnections, iNodeA )
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

function  VertexCover:ComputePathWeight( iPath )

    local weight = 0
    for i = 1, #iPath - 1 do

        weight = weight + iPath[ i ]:GetWeightForNode( iPath[ i + 1 ] )

    end
    return  weight

end


function VertexCover:StringKey( iNodeA, iNodeB )
    return iNodeA.mName .. "-" .. iNodeB.mName
end


-- RETURN CHUNK AS GLOBAL OBJECT ======================================
return VertexCover
