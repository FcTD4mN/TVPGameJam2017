local Animation = require "src/Objects/Animation"

local Object = {}

function Object:Destroy()
    self.body:destroy()
    self.body = nil
    self.shape = nil
    self.fixture = nil
end

function Object:New( world, x, y, w, h, physicType, fixedRotation, friction )
    local newObject = {}
    setmetatable( newObject, self )
    self.__index = self

    newObject.body = nil--love.physics.newBody( world, x, y, physicType )
    --newObject.body:setFixedRotation( fixedRotation )
    newObject.shape = nil--love.physics.newRectangleShape( w, h )
    newObject.fixture = nil--love.physics.newFixture( newObject.body, newObject.shape )
    --newObject.fixture:setFriction( friction )
    newObject.animations = {}
    newObject.currentAnimation = 0
    return newObject
end

function Object:UpdateObject( dt )
    if not self.body then
        return
    end

    if self.currentAnimation > 0 then
        x = self.body:getX() - self.w / 2
        y = self.body:getY() - self.h / 2
        self.animations[self.currentAnimation]:Update( dt, x, y )
    end
end

function Object:AddAnimation( spriteFile, imagecount, fps, quadX, quadY, quadW, quadH, flipX, flipY )
    if not self.body then
        return
    end
    
    x = self.body:getX() - self.w / 2
    y = self.body:getY() - self.h / 2
    table.insert( self.animations, Animation:New( spriteFile, imagecount, fps, x, y, self.w, self.h, quadX, quadY, quadW, quadH, flipX, flipY ) )
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
    if not self.body then
        return
    end
    --love.graphics.polygon( "fill", self.body:getWorldPoints( self.shape:getPoints() ) )
    if self.currentAnimation > 0 then
        self.animations[self.currentAnimation]:Draw()
    end
end

return Object