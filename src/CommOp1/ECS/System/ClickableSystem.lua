local SystemBase = require( "src/ECS/Systems/SystemBase" )
local Shortcuts = require( "src/Application/Shortcuts" )

local  ClickableSystem = {}
setmetatable( ClickableSystem, SystemBase )
SystemBase.__index = SystemBase


function  ClickableSystem:Initialize()

    self.mEntityGroup = {}

end


function ClickableSystem:IncomingEntity( iEntity )

    -- Here we decide if we are interested by iEntity or not
    -- =====================================================

    local clickbox = iEntity:GetComponentByName( "clickbox" )
    local action = iEntity:GetComponentByName( "action" )

    if clickbox and action then
        table.insert( self.mEntityGroup, iEntity )
        table.insert( iEntity.mObserverSystems, self )
    end

end


function ClickableSystem:Update( iDT )
    
end

function  ClickableSystem:Draw( iCamera )
    if not self.mClickbox or not self.mAction then
        return
    end

    love.graphics.setColor( 255, 255, 255, 50 )love.graphics.setColor( 255, 255, 255, 50 )
    love.graphics.rectangle( "fill", self.mClickbox.mX, self.mClickbox.mY, self.mClickbox.mW, self.mClickbox.mH )
end


function ClickableSystem:MousePressed( iX, iY, iButton, iIsTouch )
    
    for i = 1, #self.mEntityGroup do

        local entity        = self.mEntityGroup[ i ]
        local clickbox     = entity:GetComponentByName( "clickbox" )
        local action      = entity:GetComponentByName( "action" )

        if iX >= clickbox.mX and iY >= clickbox.mY and iX < clickbox.mX + clickbox.mW and iY < clickbox.mY + clickbox.mH then
            self.mClickbox = clickbox
            self.mAction = action
            return
        end
    end

end


function ClickableSystem:MouseMoved( iX, iY )
    --Nothing
end


function ClickableSystem:MouseReleased( iX, iY, iButton, iIsTouch )
    if not self.mClickbox or not self.mAction then
        return
    end

    if iX >= self.mClickbox.mX and iY >= self.mClickbox.mY and iX < self.mClickbox.mX + self.mClickbox.mW and iY < self.mClickbox.mY + self.mClickbox.mH then
        self.mAction.mAction()
        self.mClickbox = nil
        self.mAction = nil
        return
    end
end


-- ==========================================Type


function ClickableSystem:Type()
    return "ClickableSystem"
end


return  ClickableSystem
