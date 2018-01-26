local Node = {}


-- OBJECT INITIALISATION ==============================================

local Node = {}

function  Node:New( iParent )
    newNode = {}
    setmetatable( newNode, self )
    self.__index = self
 
    newNode.mConnections = {}
    newNode.mWeights = {}

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

-- RETURN CHUNK AS GLOBAL OBJECT ======================================
return  Node