local Shortcuts = require( "src/Application/Shortcuts" )
local DeadBody   = require 'src/ECS/Factory/DeadBody'


function  CollisionBeginning( iEntityA, iEntityB )

    local iEA = iEntityA
    local iEB = iEntityB

    -- Collision Killable/Killer
    if iEA.Type() == "Entity" and iEB.Type() == "Entity" then

        if iEA:GetComponentByName( "killable" ) ~= nil and iEB:GetTagByName( "canKill" ) == "1" then

            local  killable = iEA:GetComponentByName( "killable" )
            local  box2d    = iEA:GetComponentByName( "box2d" )

            ECSWorld:AddEntity( DeadBody:New( gWorld, box2d.mBody:getX() - box2d.mBodyW/2 - 70, box2d.mBody:getY() - box2d.mBodyH/2 - 30 ) )

            killable.mDeathCount = killable.mDeathCount + 1

            if iEA.mID == "hero" then
                local a = iEA.mCheckPoints[iEA.mCheckPoint]
                local x = a.mBody:getX()
                local aw = a.mBodyW
                box2d.mBody:setX( iEA.mCheckPoints[iEA.mCheckPoint].mBody:getX() )
                box2d.mBody:setY( iEA.mCheckPoints[iEA.mCheckPoint].mBody:getY() )
            end

            iEA:RemoveTag( "isInAir" )
            iEA:RemoveTag( "isDead" )
            iEA:RemoveTag( "isDashing" )
            iEA:RemoveTag( "isMoving" )
            iEA:RemoveTag( "isCrouch" )
            iEA:RemoveTag( "didDoubleJump" )
            iEA:RemoveTag( "didTripleJump" )
            iEA:RemoveTag( "didDash" )

            return
        end

    end

    -- Collision Entity/Terrain to set the jump flag
    if( iEntityA.Type() == "Entity" ) then
        local box2d     = iEntityA:GetComponentByName( "box2d" )
        if box2d then
            for k,v in pairs( box2d.mBody:getContactList() ) do
                fix1, fix2 = v:getFixtures()
                if( fix1:getCategory() == 1 and fix2:getCategory() == 2 or
                    fix2:getCategory() == 1 and fix1:getCategory() == 2
                    ) then
                    local x1, y1, x2, y2  = v:getPositions()
                    if x1 and y1 then
                        x1, y1 = box2d.mBody:getLocalPoint( x1, y1 )
                        if y1 > box2d.mBodyH / 2 then
                            iEntityA:RemoveTag( "isInAir" )
                            iEntityA:RemoveTag( "didDoubleJump" )
                            iEntityA:RemoveTag( "didTripleJump" )
                            iEntityA:RemoveTag( "didDash" )
                        end
                    end

                    if x2 and y2 then
                        x2, y2 = box2d.mBody:getLocalPoint( x2, y2 )
                        if y2 > box2d.mBodyH / 2 then
                            iEntityA:RemoveTag( "isInAir" )
                            iEntityA:RemoveTag( "didDoubleJump" )
                            iEntityA:RemoveTag( "didTripleJump" )
                            iEntityA:RemoveTag( "didDash" )
                        end
                    end
                end
            end
             --> Optimisation, but not possible atm :: require more tests : type hero and type terrain
        end
    end


    -- Collision Entity/Teleporter
    if iEA.Type() == "Entity" and iEB.Type() == "Entity" then

        if iEA.mID == "hero" and iEB:GetComponentByName( "teleporter" ) ~= nil then

            local box2d         = iEA:GetComponentByName( "box2d" )
            local teleporter    = iEB:GetComponentByName( "teleporter" )

            box2d.mBody:setX( teleporter.mTeleporterX )
            box2d.mBody:setY( teleporter.mTeleporterY )
        end

    end

    -- Collision Entity/ActionGiver
    if iEA.Type() == "Entity" and iEB.Type() == "Entity" then

        if iEA.mID == "hero" and iEB:GetComponentByName( "actiongiver" ) ~= nil then

            local actiongiver    = iEB:GetComponentByName( "actiongiver" )

            Shortcuts.RegisterActionWithRandomKey( actiongiver.mAction )
            iEA:RemoveTag( "isAutoRun" )

        end

    end

    if iEA.Type() == "Entity" and iEB.Type() == "Entity" then

        if iEA.mID == "hero" and iEB:GetComponentByName( "checkpoint" ) ~= nil then

            local checkpoint = iEB:GetComponentByName( "checkpoint" )
            local box2d = iEB:GetComponentByName( "box2d" )
            if GetObjectIndexInTable( iEA.mCheckPoints, box2d ) == -1 then
                iEA.mCheckPoints[ checkpoint.mCheckPoint ] = box2d
            end

        end

    end


    -- Collision Hero/checkpoint
    if iEA.Type() == "Entity" and iEB.Type() == "Entity" then

        if iEA.mID == "hero" and iEB:GetComponentByName( "checkpointsetter" ) ~= nil then

            local checkpointsetter = iEB:GetComponentByName( "checkpointsetter" )
            iEA.mCheckPoint = checkpointsetter.mCheckPoint

        end

    end


end

function  CollisionEnding( iEntityA, iEntityB )
end

function  CollisionPre( iEntityA, iEntityB )
end

function  CollisionPost( iEntityA, iEntityB )
end




