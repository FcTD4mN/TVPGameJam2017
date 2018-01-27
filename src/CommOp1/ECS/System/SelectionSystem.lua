local SystemBase = require( "src/ECS/Systems/SystemBase" )

local  SelectionSystem = {}
setmetatable( SelectionSystem, SystemBase )
SystemBase.__index = SystemBase


function  SelectionSystem:Initialize()

    self.mEntityGroup = {}

end


function SelectionSystem:IncomingEntity( iEntity )

    -- Here we decide if we are interested by iEntity or not
    -- =====================================================

    local selectable = iEntity:GetComponentByName( "selectable" )

    if selectable then
        table.insert( self.mEntityGroup, iEntity )
        table.insert( iEntity.mObserverSystems, self )
    end

end


function SelectionSystem:Update( iDT )

    for i = 1, #self.mEntityGroup do

        local entity        = self.mEntityGroup[ i ]
        local selectable     = entity:GetComponentByName( "selectable" )

    end

end


function  SelectionSystem:Draw( iCamera )

end


-- ==========================================Type


function SelectionSystem:Type()
    return "SelectionSystem"
end



-- =============================================EVENTS


function  SelectionSystem:MousePressed( iX, iY, iButton, iIsTouch )
    if iButton == 1 then
    end
end


function SelectionSystem:MouseMoved( iX, iY )
end


function SelectionSystem:MouseReleased( iX, iY, iButton, iIsTouch )

    --for i = 1, #self.mEntityGroup do

    --    if iButton == 1 then

    --    end

    --end

end


return  SelectionSystem
