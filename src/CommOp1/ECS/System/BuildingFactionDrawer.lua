local SystemBase = require( "src/ECS/Systems/SystemBase" )

local  BuildingFactionDrawer = {}
setmetatable( BuildingFactionDrawer, SystemBase )
SystemBase.__index = SystemBase


function  BuildingFactionDrawer:Initialize()

    self.mEntityGroup = {}

end


function BuildingFactionDrawer:IncomingEntity( iEntity )

    -- Here we decide if we are interested by iEntity or not
    -- =====================================================

    local position = iEntity:GetComponentByName( "position" )
    local faction = iEntity:GetComponentByName( "faction" )
    local size = iEntity:GetComponentByName( "size" )

    if position and faction and size then
        table.insert( self.mEntityGroup, iEntity )
        table.insert( iEntity.mObserverSystems, self )
    end

end


function BuildingFactionDrawer:Update( iDT )

end


function  BuildingFactionDrawer:Draw( iCamera )

    for i = 1, #self.mEntityGroup do

        local entity = self.mEntityGroup[ i ]
        local position = entity:GetComponentByName( "position" )
        local faction = entity:GetComponentByName( "faction" )
        local size = entity:GetComponentByName( "size" )

        local x,y = iCamera:MapToScreen( position.mX, position.mY )
        local w,h = size.mW * gCamera.mScale, size.mH * gCamera.mScale

        love.graphics.setLineWidth( w / 40 )

        local r,g,b = 0,0,0
        if faction.mFaction == "neutral" then
            r,g,b = 200,200,200
        elseif faction.mFaction == "capitalist" then
            r,g,b = 50,50,255
        else
            r,g,b = 255,50,50
        end


        love.graphics.setColor( r, g, b )
        love.graphics.rectangle( "line", x, y, w, h )
        love.graphics.setColor( r, g, b,100 )
        love.graphics.rectangle( "fill", x, y, w, h )
        love.graphics.setLineWidth( 1 )

    end

end


-- ==========================================Type


function BuildingFactionDrawer:Type()
    return "BuildingFactionDrawer"
end


return  BuildingFactionDrawer
