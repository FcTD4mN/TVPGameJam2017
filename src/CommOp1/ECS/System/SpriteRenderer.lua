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
    local position = iEntity:GetComponentByName( "position" )

    if position and sprite then
        table.insert( self.mEntityGroup, iEntity )
        table.insert( iEntity.mObserverSystems, self )
    end

end


function SpriteRenderer:Update( iDT )
    --does nothing
end


function  SpriteRenderer:Draw( iCamera )

    local xRadius = 10 * iCamera.mScale
    local yRadius = 5 * iCamera.mScale

    for i = 1, #self.mEntityGroup do

        local position = self.mEntityGroup[ i ]:GetComponentByName( "position" )
        local sprite = self.mEntityGroup[ i ]:GetComponentByName( "sprite" )
        local simpleT = self.mEntityGroup[ i ]:GetComponentByName( "simpletransformation" )

        local selectable = self.mEntityGroup[ i ]:GetComponentByName( "selectable" )

        local  rotation = 0
        local  scale = iCamera.mScale
        if simpleT then

            rotation = simpleT.mRotation
            scale = scale * simpleT.mScale

        end


        local x, y = iCamera:MapToScreen( position.mX, position.mY )
        local w,h = sprite.mImage:getWidth() * iCamera.mScale, sprite.mImage:getHeight() * iCamera.mScale

        if selectable and selectable.mSelected then

            love.graphics.setColor( 50, 255, 50 )
            love.graphics.ellipse( "line", x + w/2, y + h-7, xRadius, yRadius )

        end

        love.graphics.setColor( 255, 255, 255 )
        sprite.mImage:setFilter( "nearest", "nearest" )

        love.graphics.draw( sprite.mImage, sprite.mQuad, x, y, rotation, scale, scale )
    end

end


-- ==========================================Type


function SpriteRenderer:Type()
    return "SpriteRenderer"
end


return  SpriteRenderer
