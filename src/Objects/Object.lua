local Animation = require "src/Image/Animation"
local Camera    = require "src/Camera/Camera"

local Object = {}

-- ==========================================Constructor/Destructor


function Object:Destroy()
    self.body:destroy()
    self.body = nil
    self.shape = nil
    self.fixture = nil
end


function Object:New( iWorld, iX, iY, iW, iH, iPhysicType )
    local newObject = {}
    setmetatable( newObject, self )
    self.__index = self

    newObject.w = iW
    newObject.h = iH

    newObject.body      = 0         --love.physics.newBody( iWorld, iX + iW/2, iY + iH/2, iType )
    newObject.shape     = 0        --love.physics.newRectangleShape( iW, iH )
    newObject.fixture   = 0      --love.physics.newFixture( newObject.body, newObject.shape, 1 )
                            --newObject.fixture:setUserData( newObject )
                            --newObject.fixture:setFriction( friction )

    newObject.animations = {}
    newObject.currentAnimation = 0
    return newObject
end


-- ==========================================Type


function Object:Type()
    return "Object"
end


-- ==========================================Set/Get


function Object:GetX()
    return  self.body:getX() - self.w / 2
end


function Object:GetY()
    return  self.body:getY() - self.h / 2
end

function Object:SetX( iX )
    return  self.body:setX( iX + self.w/2 ) -- Body is the center point, we talk in top left coords
end


function Object:SetY( iY )
    return  self.body:setY( iY + self.h/2 ) -- Body is the center point, we talk in top left coords
end


-- ==========================================Update/Draw


function Object:UpdateObject( dt )
    if not self.body then
        return
    end

    if self.currentAnimation > 0 then
        self.animations[self.currentAnimation]:Update( dt, self:GetX(), self:GetY() )
    end
end


function Object:DrawObject()
    if not self.body then
        return
    end

    if self.currentAnimation > 0 then
        self.animations[ self.currentAnimation ]:Draw()
    end
end


function Object:DEBUGDrawHitBox()
    love.graphics.setColor( 255, 0, 0, 125 )

    fixtures = self.body:getFixtureList()
    for k,v in pairs( fixtures ) do

        if( v:getShape():getType() == "polygon" ) then
            -- Need a x1, y1, x2, y2 ... = Camera.MapToScreen( x1, y1, x2, y2 ... )

            -- love.graphics.polygon( "fill", self.body:getWorldPoints( self.shape:getPoints() ) )
        elseif ( v:getShape():getType() == "circle" ) then
            --do smth
        elseif ( v:getShape():getType() == "edge" ) then
            --do smth
        elseif ( v:getShape():getType() == "chain" ) then
            --do smth
        end

    end

    -- AABB box will have centered coord ...
    -- So we need to translate back from TL ( topleft ) to C ( centered )
    x, y, x2, y2 = self.shape:computeAABB( self:GetX() + self.w/2, self:GetY() + self.h/2, 0 )
    x, y = Camera.MapToScreen( x, y )
    x2, y2 = Camera.MapToScreen( x2, y2 )

    love.graphics.rectangle( "fill", x, y, x2-x, y2-y )
end


-- ==========================================Animations stuff


function Object:AddAnimation( iSpriteFile, iImagecount, iFps, iFlipX, iFlipY )
    if not self.body then
        return
    end

    x = self.body:getX() - self.w / 2
    y = self.body:getY() - self.h / 2
    table.insert( self.animations, Animation:New( iSpriteFile, x, y, self.w, self.h, self.body:getAngle(), iImagecount, iFps, iFlipX, iFlipY ) )
end


function Object:PlayAnimation( current, iNumberOfPlays, iPlayEndCB )
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
    self.animations[self.currentAnimation]:Play( iNumberOfPlays, iPlayEndCB )
end

return Object