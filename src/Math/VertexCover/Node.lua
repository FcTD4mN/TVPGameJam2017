local Node = {}


-- OBJECT INITIALISATION ==============================================


function  Node:New( iName, iProperty )
    newNode = {}
    setmetatable( newNode, self )
    self.__index = self
 
    newNode.mConnections = {}
    newNode.mWeights = {}
    newNode.mProperty = iProperty
    newNode.mName = iName

    return  newNode
end

-- OBJECT FUNCTIONS ===================================================

function Node:Type()
    return "Node"
end

-- NODE FUNCTION ===================================================

function Node:GetWeightForNode( iNode )

    local index = GetObjectIndexInTable( self.mConnections, iNode )
    return  self.mWeights[ index ]

end

-- RETURN CHUNK AS GLOBAL OBJECT ======================================
return  Node