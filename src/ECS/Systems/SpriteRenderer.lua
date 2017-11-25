local SystemBase = require( "src/ECS/Systems/SystemBase" )

local  SpriteRenderer = {}
setmetatable( SpriteRenderer, SystemBase )
SystemBase.__index = SystemBase


function  SpriteRenderer:Initialize()

    self.mEntityGroup = {}

end


function SpriteRenderer:Requirements()

    local requirements = {}
    table.insert( requirements, "body" )
    table.insert( requirements, "sprite" )

    return  unpack( requirements )

end


function SpriteRenderer:Update( iDT )

    for i = 1, #self.mEntityGroup do

        local body = self.mEntityGroup[ i ]:GetComponentByName( "body" )
        body.mX = body.mX + 10

    end

end


function  SpriteRenderer:Draw( iCamera )

    for i = 1, #self.mEntityGroup do

        local body = self.mEntityGroup[ i ]:GetComponentByName( "body" )
        local sprite = self.mEntityGroup[ i ]:GetComponentByName( "sprite" )

        love.graphics.draw( sprite.mImage, body.mX, body.mY )

    end

end


-- ==========================================Type


function SpriteRenderer:Type()
    return "SpriteRenderer"
end


return  SpriteRenderer
