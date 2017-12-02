local SystemBase = require( "src/ECS/Systems/SystemBase" )

local  SpriteRenderer = {}
setmetatable( SpriteRenderer, SystemBase )
SystemBase.__index = SystemBase


function  SpriteRenderer:Initialize()

    self.mEntityGroup = {}

end


function SpriteRenderer:Requirements()

    local requirements = {}
    table.insert( requirements, "box2d" )
    table.insert( requirements, "sprite" )

    return  unpack( requirements )

end


function SpriteRenderer:Update( iDT )
    --does nothing
end


function  SpriteRenderer:Draw( iCamera )

    for i = 1, #self.mEntityGroup do

        local box2d = self.mEntityGroup[ i ]:GetComponentByName( "box2d" )
        local sprite = self.mEntityGroup[ i ]:GetComponentByName( "sprite" )

        local x, y = iCamera:MapToScreen( box2d.mBody:getX() - sprite.mImage:getWidth() / 2, box2d.mBody:getY() - sprite.mImage:getHeight() / 2 )
        --love.graphics.draw( sprite.mImage, box2d.mBody:getX() - sprite.mImage:getWidth() / 2, box2d.mBody:getY() - sprite.mImage:getHeight() / 2 )
        love.graphics.draw( sprite.mImage, x, y, 0, iCamera.mScale, iCamera.mScale )
    end

end


-- ==========================================Type


function SpriteRenderer:Type()
    return "SpriteRenderer"
end


-- EVENTS : =================================================================================


function SpriteRenderer:KeyPressed( iKey, iScancode, iIsRepeat )

    for i = 1, #self.mSystems do

        local system = self.mSystems[ i ]
        system:KeyPressed( iKey, iScancode, iIsRepeat )

    end

end


function SpriteRenderer:KeyReleased( iKey, iScancode )

    for i = 1, #self.mSystems do

        local system = self.mSystems[ i ]
        system:KeyReleased( iKey, iScancode )

    end

end


return  SpriteRenderer
