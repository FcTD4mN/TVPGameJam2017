local SystemBase = require( "src/ECS/Systems/SystemBase" )
local Shortcuts = require( "src/Application/Shortcuts" )
local  SoundEngine = require "src/CommOp1/SoundSystem/SoundMachine"

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
    local selectable = iEntity:GetComponentByName( "selectable" )

    if userinput and position and selectable then
        table.insert( self.mEntityGroup, iEntity )
        table.insert( iEntity.mObserverSystems, self )
    end

end


function CharacterController:Update( iDT )

    for i = 1, #self.mEntityGroup do

        local entity        = self.mEntityGroup[ i ]
        local position      = entity:GetComponentByName( "position" )
        local destination   = entity:GetComponentByName( "destination" )
        local speed      = entity:GetComponentByName( "speed" )

        if #destination.mX > 0 then

            local vector = Vector:New( destination.mX[ 1 ] - position.mX, destination.mY[ 1 ] - position.mY )
            local vectorNorm = vector:Normalized() -- SQRT !!

            local xspeed = vectorNorm.x * speed.mSpeed * gGameSpeed
            local yspeed = vectorNorm.y * speed.mSpeed * gGameSpeed
            if math.abs( xspeed ) > math.abs( vector.x ) and math.abs( yspeed ) > math.abs( vector.y ) then 
                position.mX = destination.mX[ 1 ]
                position.mY = destination.mY[ 1 ]
                table.remove( destination.mX, 1 )
                table.remove( destination.mY, 1 )
            else
                position.mX = position.mX + xspeed
                position.mY = position.mY + yspeed

                if math.abs( xspeed ) > math.abs( vector.x ) then
                    position.mX = destination.mX[ 1 ]
                end
                if math.abs( yspeed ) > math.abs( vector.y ) then 
                    position.mY = destination.mY[ 1 ]
                end
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

                local ecart = 100
                local randomX = math.random( ecart ) - ecart/2
                local randomY = math.random( ecart ) - ecart/2

                for i=1, #destination.mX do

                    destination.mX[ i ] = destination.mX[ i ] + randomX
                    destination.mY[ i ] = destination.mY[ i ] + randomY

                end

            end
            SoundEngine:PlayOrder()

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
