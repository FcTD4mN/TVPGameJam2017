
-- This class just registers objects and their collider to call the Collide CB outside of box2D's callbacks

require("src/ECS/Systems/CollisionExtraSystem")

local CollidePool = {
    objects = {},
    colliders = {}
}


-- ==========================================Type


function CollidePool.Type()
    return "CollidePool"
end


-- ==========================================Update/Draw


function CollidePool.Update( iDT )

    for k, v in pairs( CollidePool.objects ) do

        Collision( v, CollidePool.colliders[ k ] )

        -- Function has been called, we can remove from collision pool
        table.remove( CollidePool.objects, k )
        table.remove( CollidePool.colliders, k )

    end

end


-- ==========================================Pool actions


function  CollidePool.AddCollision( iObject, iCollider )

    table.insert( CollidePool.objects, iObject )
    table.insert( CollidePool.colliders, iCollider )

end


return CollidePool