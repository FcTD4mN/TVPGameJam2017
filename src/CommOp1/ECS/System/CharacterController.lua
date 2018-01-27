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
        local position      = entity:GetComponentByName( "position" )
        local destination   = entity:GetComponentByName( "destination" )

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


function CharacterController:MouseReleased( iX, iY, iButton, iIsTouch )
    for i = 1, #self.mEntityGroup do

        local entity        = self.mEntityGroup[ i ]
        local position      = entity:GetComponentByName( "position" )
        local destination   = entity:GetComponentByName( "destination" )
        local sprite        = entity:GetComponentByName( "sprite" )
        local selectable        = entity:GetComponentByName( "selectable" )

        --Move to clickLocation
        if iButton == 2 and  selectable.mSelected then
            
            local x,y = gCamera:MapToWorld( iX, iY )
            local w,h = sprite.mImage:getWidth(), sprite.mImage:getHeight()

            ClearTable( destination.mX )
            ClearTable( destination.mY )

            table.insert( destination.mX, x - w/2 )
            table.insert( destination.mY, y - h/2 )

            if #gSelection > 1 then

                local ecart = 40
                local randomX = math.random( ecart ) - ecart/2
                local randomY = math.random( ecart ) - ecart/2

                for i=1, #destination.mX do

                    destination.mX[ i ] = destination.mX[ i ] + randomX
                    destination.mY[ i ] = destination.mY[ i ] + randomY

                end

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
