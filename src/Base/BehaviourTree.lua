BehaviourTree = {
    mTree = nil
}

BTSuccess = 1
BTFailure = 2
BTRunning = 3
BTError   = 4

--Some good explanation of the concept here : http://blog.renatopp.com/2014/07/25/an-introduction-to-behavior-trees-part-1/

function BehaviourTree:New( iTree )
    local newBehaviourTree = {}
    setmetatable( newBehaviourTree, BehaviourTree )
    BehaviourTree.__index = BehaviourTree

    newBehaviourTree.mTree = iTree

    return newObject
end

function BehaviourTree:Execute()
    ExecuteNode( self.mTree )
end

-- Creating New Nodes

function BehaviourTree:NewAction( iAction )
    return  { "action", iAction }
end

function BehaviourTree:NewSequence( iChildren )
    return  { "sequence", iChildren }
end

function BehaviourTree:NewMemSequence( iChildren )
    return  { "memsequence", 3, iChildren }
end

function BehaviourTree:NewPriority( iChildren )
    return  { "priority", iChildren }
end

function BehaviourTree:NewMemPriority( iChildren )
    return  { "mempriority", 3, iChildren }
end

function BehaviourTree:NewParallel( iChildren )
    return  { "parallel", iChildren }
end

function BehaviourTree:NewDecorator( iChild )
    return  { "decorator", iChild }
end

-- Private methods

function BehaviourTree:ExecuteNode( iNode )
    local nodeType = iNode[1]
    if      nodeType == "action"    then return ExecuteAction( iNode )
    elseif  nodeType == "sequence"  then return ExecuteSequence( iNode )
    elseif  nodeType == "memsequence"  then return ExecuteMemSequence( iNode )
    elseif  nodeType == "priority"      then return ExecutePriority( iNode )
    elseif  nodeType == "mempriority"  then return ExecuteMemPriority( iNode )
    elseif  nodeType == "parallel"  then return ExecuteParallel( iNode )
    elseif  nodeType == "decorator" then return ExecuteDecorator( iNode )
    end
end

function BehaviourTree:ExecuteAction( iNode )
    return  iNode[2]()
end

function BehaviourTree:ExecuteSequence( iNode )
    for i=2, #iNode then
        local result = ExecuteNode( iNode[i] )
        if result ~= BTSuccess then
            return  result
        end
    end
    return  BTSuccess
end

function BehaviourTree:ExecutePriority( iNode )
    for i=2, #iNode then
        local result = ExecuteNode( iNode[i] )
        if result ~= BTFailure then
            return  result
        end
    end
    return  BTFailure
end

function BehaviourTree:ExecuteMemSequence( iNode )
    startNode = iNode[2]
    iNode[2] = 3

    for i=startNode, #iNode then
        local result = ExecuteNode( iNode[i] )
        if result ~= BTSuccess then
            if result == BTRunning then
                iNode[2] = i
            end
            return  result
        end
    end

    return  BTSuccess
end

function BehaviourTree:ExecuteMemPriority( iNode )
    startNode = iNode[2]
    iNode[2] = 3
    for i=startNode, #iNode then
        local result = ExecuteNode( iNode[i] )
        if result ~= BTFailure then
            if result == BTRunning then
                iNode[2] = i
            end
            return  result
        end
    end
    return  BTFailure
end

function BehaviourTree:ExecuteParallel( iNode )
    assert( false ) --do it when needed
end

function BehaviourTree:ExecuteDecorator( iNode )
    return  iNode[2]( ExecuteNode( iNode[3] ) )
end

return  ObjectRegistry