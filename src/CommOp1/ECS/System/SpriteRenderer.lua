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

    if position and sprite and iEntity:GetTagByName( "isGUI" ) == "0" then
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
        local selectable = self.mEntityGroup[ i ]:GetComponentByName( "selectable" )
        local faction = self.mEntityGroup[ i ]:GetComponentByName( "faction" )

        local isCameraFree = self.mEntityGroup[ i ]:GetTagByName( "camerafree" ) == "1"

        local  rotation = 0

        local  scale = 1.0
        if not isCameraFree then
            scale = iCamera.mScale
        end

        if simpleT then

            rotation = simpleT.mRotation
            scale = scale * simpleT.mScale

        end

        local x, y = position.mX, position.mY
        local w,h = sprite.mW, sprite.mH
        if not isCameraFree then
            x, y = iCamera:MapToScreen( position.mX, position.mY )
            w,h = sprite.mW * iCamera.mScale, sprite.mH * iCamera.mScale
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
