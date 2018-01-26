local Node = {}


-- OBJECT INITIALISATION ==============================================

local Node = {}

function  Node:New( iParent )
    newNode = {}
    setmetatable( newNode, self )
    self.__index = self
 
    newNode.mConnections = {}
    newNode.mWeights = {}
    newNode.mVisited = false

    return  newNode
end

-- OBJECT FUNCTIONS ===================================================

function Node:Type()
    return "Node"
end

-- NODE FUNCTION ===================================================

function Node:AddConnection( iNode, iWeight )

    table.insert( mConnections, iNode )
    table.insert( mWeights, iWeight )

end 

function Node:GetWeightTo( iNode )

    local index = GetObjectIndexInTable( self.mConnections, iNode )
    return  self.mWeights[ index ]

end 

function  Node:ComputePathWeight( iPath )

    local weight = 0
    for i = 1, #iPath - 1 do

        weight = weight + iPath[ i ]:GetWeightTo( iPath[ i + 1 ] )

    end
    return  weight

end

function Node:GetShorterWayTo( iNode )
 
    local allPaths = {}

    local path = {}
    table.insert( path, self ) 

    for i = 1, #self.mConnections do
        
        local pathCopy = DeepCopyTable( path )
        table.insert( allPaths, self.mConnections[ i ]:GetPathTo( iNode, pathCopy ) )
       
    end
 
end


function  Node:GetPathTo( iNode, iPath )

    table.insert( iPath, self ) 
    local allPaths = {}

    for i = 1, #self.mConnections do
        
        if( iNode == self.mConnections[ i ] ) then

            table.insert( iPath, self.mConnections[ i ] )   
            return  iPath

        end

        if not TableContains( iPath, self.mConnections[ i ] ) then
 
            local pathCopy = DeepCopyTable( iPath )
            table.insert( allPaths, self.mConnections[ i ]:GetPathTo( iNode, pathCopy ) )

        end

    end 

    local lowestWeight = 0
    local index = 0
    for i = 1, #allPaths do

        local pathWeight = self:ComputePathWeight( allPaths[ i ] )
        if pathWeight < lowestWeight then
            lowestWeight = pathWeight
            index = i
        end

    end
 
    if( index > 0 ) then
        return  allPaths[ index ]
    else
        return  iPath
    end

end

-- RETURN CHUNK AS GLOBAL OBJECT ======================================
return  Node