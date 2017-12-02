

function  Collision( iEntityA, iEntityB )

    -- Collision Entity/Terrain to set the jump flag
    if( iEntityA.Type() == "Entity" ) then

        if( iEntityA:GetTagByName( "canJump" ) == 1 ) then

            iEntityA:RemoveTag( "isJumping" )

        end

    end

end