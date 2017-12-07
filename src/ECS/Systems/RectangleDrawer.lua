local SystemBase = require( "src/ECS/Systems/SystemBase" )

local  RectangleDrawer = {}
setmetatable( RectangleDrawer, SystemBase )
SystemBase.__index = SystemBase


function  RectangleDrawer:Initialize()

    self.mEntityGroup = {}

end


function RectangleDrawer:IncomingEntity( iEntity )

    -- Here we decide if we are interested by iEntity or not
    -- =====================================================

    local body = iEntity:GetComponentByName( "body" )
    local color = iEntity:GetComponentByName( "color" )

    if color and body then
        table.insert( self.mEntityGroup, iEntity )
        table.insert( iEntity.mObserverSystems, self )
    end

end


function RectangleDrawer:Update( iDT )

    for i = 1, #self.mEntityGroup do

        local body = self.mEntityGroup[ i ]:GetComponentByName( "body" )
        body.mY = body.mY + 10

    end

end


function  RectangleDrawer:Draw( iCamera )

    for i = 1, #self.mEntityGroup do

        local body = self.mEntityGroup[ i ]:GetComponentByName( "body" )
        local color = self.mEntityGroup[ i ]:GetComponentByName( "color" )

        love.graphics.setColor( color.mR, color.mG, color.mB )
        love.graphics.rectangle( "fill", body.mX, body.mY, body.mW, body.mH )

    end

end


-- ==========================================Type


function RectangleDrawer:Type()
    return "RectangleDrawer"
end


return  RectangleDrawer
