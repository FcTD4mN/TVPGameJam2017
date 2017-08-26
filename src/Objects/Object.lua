local Animation = require "src/Objects/Animation"

local Object = {}

function Object:New( world, x, y, w, h, physicType, fixedRotation, friction )
    local newObject = {}
    setmetatable( newObject, self )
    self.__index = self

    newObject.body = 0--love.physics.newBody( world, x, y, physicType )
    --newObject.body:setFixedRotation( fixedRotation )
    newObject.shape = 0--love.physics.newRectangleShape( w, h )
    newObject.fixture = 0--love.physics.newFixture( newObject.body, newObject.shape )
    --newObject.fixture:setFriction( friction )
    newObject.animations = {}
    newObject.currentAnimation = 0
    return newObject
end

function Object:UpdateObject( dt )
    if self.currentAnimation > 0 then
        local topLeftX, topLeftY, bottomRightX, bottomRightY = self.shape:computeAABB( 0, 0, 0 )
        topLeftX, topLeftY, bottomRightX, bottomRightY = self.body:getWorldPoints( topLeftX, topLeftY, bottomRightX, bottomRightY )
        self.animations[self.currentAnimation]:Update( dt, topLeftX, topLeftY )
    end
end

function Object:AddAnimation( spriteFile, imagecount, fps, quadX, quadY, quadW, quadH, flipX, flipY )

    local topLeftX, topLeftY, bottomRightX, bottomRightY = self.shape:computeAABB( 0, 0, 0 )
    topLeftX, topLeftY, bottomRightX, bottomRightY = self.body:getWorldPoints( topLeftX, topLeftY, bottomRightX, bottomRightY )

    table.insert( self.animations, Animation:New( spriteFile, imagecount, fps, topLeftX, topLeftY, bottomRightX - topLeftX + 1, bottomRightY - topLeftY + 1, quadX, quadY, quadW, quadH, flipX, flipY ) )
end

function Object:SetCurrentAnimation( current )
    if self.currentAnimation == current then
        return
    end
    if self.currentAnimation > 0 then
        self.animations[self.currentAnimation]:Stop()
    end

    self.currentAnimation = current
    if current == 0 then
        return    
    end
    self.animations[self.currentAnimation]:Play()
end

function Object:DrawObject()
    --love.graphics.polygon( "fill", self.body:getWorldPoints( self.shape:getPoints() ) )
    if self.currentAnimation > 0 then
        self.animations[self.currentAnimation]:Draw()
    end
end

return Object