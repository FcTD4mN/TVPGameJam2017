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

    for i = 1, #self.mEntityGroup do

        local position = self.mEntityGroup[ i ]:GetComponentByName( "position" )
        local sprite = self.mEntityGroup[ i ]:GetComponentByName( "sprite" )
        local simpleT = self.mEntityGroup[ i ]:GetComponentByName( "simpletransformation" )

        local  rotation = 0
        local  scale = iCamera.mScale
        if simpleT then

            rotation = simpleT.mRotation
            scale = scale * simpleT.mScale

        end

        love.graphics.setColor( 255, 255, 255 )
        local x, y = iCamera:MapToScreen( position.mX, position.mY )
        love.graphics.draw( sprite.mImage, x, y, rotation, scale, scale )
    end

end


-- ==========================================Type


function SpriteRenderer:Type()
    return "SpriteRenderer"
end


return  SpriteRenderer
