local Connection = {}

local  Vector = require "src/Math/Vector"

-- OBJECT INITIALISATION ==============================================


function  Connection:New( iNodeA, iNodeB, iWeight )
    newConnection = {}
    setmetatable( newConnection, self )
    self.__index = self
 
    newConnection.mNodeA = iNodeA
    newConnection.mNodeB = iNodeB
    newConnection.mWeight = iWeight
    newConnection.mNorm = math.sqrt( iWeight )
    newConnection.mVector = iNodeB.mProperty:SubstractionResult( iNodeA.mProperty )
    newConnection.mVector.x = newConnection.mVector.x / newConnection.mNorm
    newConnection.mVector.y = newConnection.mVector.y / newConnection.mNorm

    return  newConnection
end

-- OBJECT FUNCTIONS ===================================================

function Connection:Type()
    return "Connection"
end

-- RETURN CHUNK AS GLOBAL OBJECT ======================================
return  Connection