local SystemBase = require( "src/ECS/Systems/SystemBase" )
local Shortcuts = require( "src/Application/Shortcuts" )

local  DestinationDrawer = {}
setmetatable( DestinationDrawer, SystemBase )
SystemBase.__index = SystemBase


function  DestinationDrawer:Initialize()

    self.mEntityGroup = {}

end


function DestinationDrawer:IncomingEntity( iEntity )

    -- Here we decide if we are interested by iEntity or not
    -- =====================================================

    local position = iEntity:GetComponentByName( "position" )
    local destination = iEntity:GetComponentByName( "destination" )

    if destination and position then
        table.insert( self.mEntityGroup, iEntity )
        table.insert( iEntity.mObserverSystems, self )
    end

end


function DestinationDrawer:Update( iDT )

end


function  DestinationDrawer:Draw( iCamera )

    for i = 1, #self.mEntityGroup do

        local entity = self.mEntityGroup[ i ]
        local position = entity:GetComponentByName( "position" )
        local sprite = entity:GetComponentByName( "sprite" )
        local destination = entity:GetComponentByName( "destination" )

        if #destination.mX > 0 then

            local originX, originY = position.mX, position.mY
            local destX, destY = destination.mX[ 1 ], destination.mY[ 1 ]

            if( sprite ) then

                local w,h = sprite.mImage:getWidth(), sprite.mImage:getHeight()
                originX = originX + w/2
                originY = originY + h/2
                destX = destX + w/2
                destY = destY + h/2

            end
            love.graphics.setColor( 255, 0, 0 )
            love.graphics.line( iCamera:MapToScreenMultiple( originX, originY, destX, destY ) )


            for i=2, #destination.mX do

                originX, originY = destination.mX[ i-1 ], destination.mY[ i-1 ]
                destX, destY = destination.mX[ i ], destination.mY[ i ]

                if( sprite ) then

                    local w,h = sprite.mImage:getWidth(), sprite.mImage:getHeight()
                    originX = originX + w/2
                    originY = originY + h/2
                    destX = destX + w/2
                    destY = destY + h/2

                end
                love.graphics.setColor( 255, 0, 0 )
                love.graphics.line( iCamera:MapToScreenMultiple( originX, originY, destX, destY ) )

            end

        end

    end

end


-- ==========================================Type


function DestinationDrawer:Type()
    return "DestinationDrawer"
end


return  DestinationDrawer
