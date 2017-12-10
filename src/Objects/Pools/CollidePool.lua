
-- This class just registers mObjectsBeginning and their collider to call the Collide CB outside of box2D's callbacks

require("src/ECS/Systems/CollisionExtraSystem")

local CollidePool = {
    mObjectsBeginning = {},
    mCollidersBeginning = {},
    mObjectsEnding = {},
    mCollidersEnding = {},
    mObjectsPre = {},
    mCollidersPre = {},
    mObjectsPost = {},
    mCollidersPost = {}
}


-- ==========================================Type


function CollidePool.Type()
    return "CollidePool"
end


-- ==========================================Update/Draw


function CollidePool.Update( iDT )

    for k, v in pairs( CollidePool.mObjectsBeginning ) do

        CollisionBeginning( v, CollidePool.mCollidersBeginning[ k ] )

        -- Function has been called, we can remove from collision pool
        table.remove( CollidePool.mObjectsBeginning, k )
        table.remove( CollidePool.mCollidersBeginning, k )

    end
    for k, v in pairs( CollidePool.mObjectsEnding ) do

        CollisionEnding( v, CollidePool.mCollidersEnding[ k ] )

        -- Function has been called, we can remove from collision pool
        table.remove( CollidePool.mObjectsEnding, k )
        table.remove( CollidePool.mCollidersEnding, k )

    end
    for k, v in pairs( CollidePool.mObjectsPre ) do

        CollisionPre( v, CollidePool.mCollidersPre[ k ] )

        -- Function has been called, we can remove from collision pool
        table.remove( CollidePool.mObjectsPre, k )
        table.remove( CollidePool.mCollidersPre, k )

    end
    for k, v in pairs( CollidePool.mObjectsPost ) do

        CollisionPost( v, CollidePool.mCollidersPost[ k ] )

        -- Function has been called, we can remove from collision pool
        table.remove( CollidePool.mObjectsPost, k )
        table.remove( CollidePool.mCollidersPost, k )

    end

end


-- ==========================================Pool actions


function  CollidePool.AddCollisionBeginning( iObject, iCollider )

    table.insert( CollidePool.mObjectsBeginning, iObject )
    table.insert( CollidePool.mCollidersBeginning, iCollider )

end

function  CollidePool.AddCollisionEnding( iObject, iCollider )

    table.insert( CollidePool.mObjectsEnding, iObject )
    table.insert( CollidePool.mCollidersEnding, iCollider )

end

function  CollidePool.AddCollisionPre( iObject, iCollider )

    table.insert( CollidePool.mObjectsPre, iObject )
    table.insert( CollidePool.mCollidersPre, iCollider )

end

function  CollidePool.AddCollisionPost( iObject, iCollider )

    table.insert( CollidePool.mObjectsPost, iObject )
    table.insert( CollidePool.mCollidersPost, iCollider )

end


return CollidePool