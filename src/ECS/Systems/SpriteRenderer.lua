local SystemBase = require( "src/ECS/Systems/SystemBase" )

local  SpriteRenderer = {}
setmetatable( SpriteRenderer, SystemBase )
SystemBase.__index = SystemBase


function  SpriteRenderer:Initialize()

    self.mEntityGroup = {}

end


function SpriteRenderer:IncomingEntity( iEntity )

    -- Here we decide if we are interested by iEntity or not
    -- =====================================================

    local sprite = iEntity:GetComponentByName( "sprite" )
    local box2d = iEntity:GetComponentByName( "box2d" )

    if box2d and sprite then
        table.insert( self.mEntityGroup, iEntity )
        table.insert( iEntity.mObserverSystems, self )
    end

end


function SpriteRenderer:Update( iDT )
    --does nothing
end


function  SpriteRenderer:Draw( iCamera )

    for i = 1, #self.mEntityGroup do

        local box2d = self.mEntityGroup[ i ]:GetComponentByName( "box2d" )
        local sprite = self.mEntityGroup[ i ]:GetComponentByName( "sprite" )
        love.graphics.setColor( 255, 255, 255 )
        local x, y = iCamera:MapToScreen( box2d.mBody:getX() - sprite.mImage:getWidth() / 2, box2d.mBody:getY() - sprite.mImage:getHeight() / 2 )
        --love.graphics.draw( sprite.mImage, box2d.mBody:getX() - sprite.mImage:getWidth() / 2, box2d.mBody:getY() - sprite.mImage:getHeight() / 2 )
        love.graphics.draw( sprite.mImage, x, y, 0, iCamera.mScale, iCamera.mScale )
    end

end


-- ==========================================Type


function SpriteRenderer:Type()
    return "SpriteRenderer"
end


return  SpriteRenderer
