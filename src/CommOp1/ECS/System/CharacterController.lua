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

        local entity = self.mEntityGroup[ i ]
        local userinput = entity:GetComponentByName( "userinput" )
        local position = entity:GetComponentByName( "position" )
        local destination = entity:GetComponentByName( "destination" )

        --jump
        if( userinput.mActions[ "moverandom" ] ~= nil ) then
            position.mX = position.mX + 10
            position.mY = position.mY + 10
        end

        --Move to clickLocation
        if( userinput.mActions[ "movetolocation" ] == "pending" ) then
            userinput.mActions[ "movetolocation" ] = nil
            if( destination ) then
                destination.mActive = true
                local x,y = gCamera:MapToWorld( love.mouse.getPosition() )
                destination.mX = x
                destination.mY = y
            end
        end

        if destination.mActive then

            if math.abs( destination.mX - position.mX ) < 5 and math.abs( destination.mY - position.mY ) then
                destination.mActive = false
            end

            local vector = Vector:New( destination.mX - position.mX, destination.mY - position.mY )
            vector = vector:Normalized() -- SQRT !!
            position.mX = position.mX + vector.x
            position.mX = position.mX + vector.y

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
