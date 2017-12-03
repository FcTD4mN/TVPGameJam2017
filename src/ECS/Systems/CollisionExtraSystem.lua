

function  Collision( iEntityA, iEntityB )

    -- Collision Killable/Killer
    if iEntityA.Type() == "Entity" and iEntityB.Type() == "Entity" then

        if iEntityA:GetComponentByName( "killable" ) ~= nil and iEntityB:GetTagByName( "canKill" ) == 1 then

            local  killable = iEntityA:GetComponentByName( "killable" )
            local  box2d    = iEntityA:GetComponentByName( "box2d" )

            killable.mDeathCount = killable.mDeathCount + 1
            box2d.mBody:setX( 0 )
            box2d.mBody:setY( 100 )

            iEntityA:RemoveTag( "autoRun" )

        end

    end

    -- Collision Entity/Terrain to set the jump flag
    if( iEntityA.Type() == "Entity" ) then

        if( iEntityA:GetTagByName( "canJump" ) == 1 ) then

            iEntityA:RemoveTag( "isJumping" )

        end

    end

end