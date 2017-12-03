local Shortcuts = require( "src/Application/Shortcuts" )
local DeadBody   = require 'src/ECS/Factory/DeadBody'


function  Collision( iEntityA, iEntityB )

    -- Collision Killable/Killer
    if iEntityA.Type() == "Entity" and iEntityB.Type() == "Entity" then

        if iEntityA:GetComponentByName( "killable" ) ~= nil and iEntityB:GetTagByName( "canKill" ) == 1 then

            local  killable = iEntityA:GetComponentByName( "killable" )
            local  box2d    = iEntityA:GetComponentByName( "box2d" )

            ECSWorld:AddEntity( DeadBody:New( gWorld, box2d.mBody:getX() - box2d.mBodyW/2 - 70, box2d.mBody:getY() - box2d.mBodyH/2 - 30 ) )

            killable.mDeathCount = killable.mDeathCount + 1
            box2d.mBody:setX( 0 )
            box2d.mBody:setY( 100 )

            iEntityA:RemoveTag( "autoRun" )
            Shortcuts:Iterate()
        end

    end

    -- Collision Entity/Terrain to set the jump flag
    if( iEntityA.Type() == "Entity" ) then

        if( iEntityA:GetTagByName( "canJump" ) == 1 ) then

            iEntityA:RemoveTag( "isJumping" )

        end

    end

end