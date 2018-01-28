local SystemBase = require( "src/ECS/Systems/SystemBase" )

local  SelectionDrawer = {}
setmetatable( SelectionDrawer, SystemBase )
SystemBase.__index = SystemBase


function  SelectionDrawer:Initialize()

    self.mEntityGroup = {}

end


function SelectionDrawer:IncomingEntity( iEntity )

    -- Here we decide if we are interested by iEntity or not
    -- =====================================================

    local position = iEntity:GetComponentByName( "position" )
    local selectable = iEntity:GetComponentByName( "selectable" )

    if position and selectable then
        table.insert( self.mEntityGroup, iEntity )
        table.insert( iEntity.mObserverSystems, self )
    end

end


function SelectionDrawer:Update( iDT )

end


function  SelectionDrawer:Draw( iCamera )

    for i = 1, #self.mEntityGroup do

        local entity = self.mEntityGroup[ i ]
        local position = entity:GetComponentByName( "position" )
        local selectable = entity:GetComponentByName( "selectable" )
        local size = entity:GetComponentByName( "size" )

        if selectable.mSelected then

            local x,y = iCamera:MapToScreen( position.mX, position.mY )
            local w,h = 0, 0

            if size then
                w,h = size.mW * gCamera.mScale, size.mH * gCamera.mScale
            end
            local size = entity:GetComponentByName( "size" )
            if size then
                w,h = size.mW * gCamera.mScale, size.mH * gCamera.mScale
                love.graphics.setLineWidth( w / 40 )
            end

            love.graphics.setColor( 10, 100, 10 )
            love.graphics.rectangle( "line", x, y, w, h )
            love.graphics.setLineWidth( 1 )

        end

    end

end


-- ==========================================Type


function SelectionDrawer:Type()
    return "SelectionDrawer"
end


return  SelectionDrawer
