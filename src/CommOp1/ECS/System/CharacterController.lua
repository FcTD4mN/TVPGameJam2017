local SystemBase = require( "src/ECS/Systems/SystemBase" )
local Shortcuts = require( "src/Application/Shortcuts" )

local  CharacterController = {}
setmetatable( CharacterController, SystemBase )
SystemBase.__index = SystemBase


function  CharacterController:Initialize()

    self.mEntityGroup = {}

end


function CharacterController:IncomingEntity( iEntity )

    -- Here we decide if we are interested by iEntity or not
    -- =====================================================

    local userinput = iEntity:GetComponentByName( "userinput" )
    local position = iEntity:GetComponentByName( "position" )

    if userinput and position then
        table.insert( self.mEntityGroup, iEntity )
        table.insert( iEntity.mObserverSystems, self )
    end

end


function CharacterController:Update( iDT )

    for i = 1, #self.mEntityGroup do

        local entity        = self.mEntityGroup[ i ]
        local userinput     = entity:GetComponentByName( "userinput" )
        local position      = entity:GetComponentByName( "position" )
        local destination   = entity:GetComponentByName( "destination" )
        local sprite        = entity:GetComponentByName( "sprite" )

        --jump
        if( userinput.mActions[ "moverandom" ] ~= nil ) then
            position.mX = position.mX + 10
            position.mY = position.mY + 10
        end

        --Move to clickLocation
        if( userinput.mActions[ "movetolocation" ] == "pending" ) then
            userinput.mActions[ "movetolocation" ] = nil
            if( destination ) then
                local x,y = gCamera:MapToWorld( love.mouse.getPosition() )
                local w,h = sprite.mImage:getWidth(), sprite.mImage:getHeight()

                --ClearTable( destination.mX )
                --ClearTable( destination.mY )

                table.insert( destination.mX, x - w/2 )
                table.insert( destination.mY, y - h/2 )
            end
        end

        if #destination.mX > 0 then

            local vector = Vector:New( destination.mX[ 1 ] - position.mX, destination.mY[ 1 ] - position.mY )
            vector = vector:Normalized() -- SQRT !!
            position.mX = position.mX + vector.x
            position.mY = position.mY + vector.y

            if ( math.abs( destination.mX[ 1 ] - position.mX ) < 5 ) and ( math.abs( destination.mY[ 1 ] - position.mY ) < 5 ) then
                table.remove( destination.mX, 1 )
                table.remove( destination.mY, 1 )
            end

        end

    end

end


function  CharacterController:Draw( iCamera )

end


-- ==========================================Type


function CharacterController:Type()
    return "CharacterController"
end


return  CharacterController
