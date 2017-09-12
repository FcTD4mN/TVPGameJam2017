require( "src/Base/Utilities/XML" )

local Animation     = require "src/Image/Animation"
local Camera        = require "src/Camera/Camera"
local ObjectPool    = require "src/Objects/Pools/ObjectPool"


local SLAXML            = require 'src/ExtLibs/XML/SLAXML/slaxdom'

local Object = {}

-- ==========================================Constructor/Destructor


function Object:Finalize()
    self.mBody:destroy()
    self.mBody = nil
end


function Object:New( iWorld, iX, iY, iW, iH, iPhysicType )
    local newObject = {}
    setmetatable( newObject, Object )
    Object.__index = Object

    newObject:BuildObject( iWorld, iX, iY, iW, iH, iPhysicType )

    return newObject
end


function  Object:BuildObject( iWorld, iX, iY, iW, iH, iPhysicType, iDoesRotation )

    self.mX = iX
    self.mY = iY
    self.mW = iW
    self.mH = iH

    --inherited values
    self.mBody     = love.physics.newBody( iWorld, self.mX + self.mW / 2, self.mY + self.mH / 2, iPhysicType )
    self.mBody:setFixedRotation( iDoesRotation )

    self.mAnimations         = {}
    self.mCurrentAnimation   = 0

    self.mNeedDestroy = false

    ObjectPool.AddObject( self )

end


-- ==========================================Type


function Object:Type()
    return "Object"
end


-- ==========================================Set/Get


function Object:GetX()
    return  self.mBody:getX() - self.mW / 2
end


function Object:GetY()
    return  self.mBody:getY() - self.mH / 2
end

function Object:SetX( iX )
    return  self.mBody:setX( iX + self.mW/2 ) -- Body is the center point, we talk in top left coords
end


function Object:SetY( iY )
    return  self.mBody:setY( iY + self.mH/2 ) -- Body is the center point, we talk in top left coords
end


function Object:Destroy()
    self.mNeedDestroy = true
end


-- ==========================================Update/Draw


function  Object:DrawToMiniMap( iCamera )

    self:DrawObjectOnMiniMap( iCamera )

end


function Object:UpdateObject( iDT )

    if not self.mBody then
        return
    end

    if self.mCurrentAnimation > 0 then
        self.mAnimations[self.mCurrentAnimation]:Update( iDT, self:GetX(), self:GetY(), self.mW, self.mH, self.mBody:getAngle() )
    end

end


function Object:DrawObject( iCamera )

    if not self.mBody then
        return
    end

    if self.mCurrentAnimation > 0 then
        self.mAnimations[ self.mCurrentAnimation ]:Draw( iCamera )
    end

end


function Object:DrawObjectOnMiniMap( iMiniMap )

    if not self.mBody then
        return
    end

    x, y = iMiniMap:MapToScreen( self:GetX(), self:GetY() )

    love.graphics.setColor( 20,50,200 )
    love.graphics.rectangle( "fill", x, y, self.mW * iMiniMap.mCamera.mScale, self.mH * iMiniMap.mCamera.mScale )

end


function Object:DEBUGDrawHitBox()
    love.graphics.setColor( 255, 0, 0, 125 )

    fixtures = self.mBody:getFixtureList()
    for k,v in pairs( fixtures ) do

        if( v:getShape():getType() == "polygon" ) then
            love.graphics.polygon( "fill", Camera.MapToScreenMultiple( self.mBody:getWorldPoints( self.mShape:getPoints() ) ) )
        elseif ( v:getShape():getType() == "circle" ) then
            radius  = v:getShape():getRadius()
            x, y    = v:getShape():getPoint()

            -- x, y are coordinates from the center of body, so we offset to match center in screen coordinates
            x = x + self:GetX() + self.mW/2
            y = y + self:GetY() + self.mH/2
            x, y = Camera.MapToScreen( x, y )
            love.graphics.circle( "fill", x, y, radius )
        elseif ( v:getShape():getType() == "edge" ) then
            --TODO
        elseif ( v:getShape():getType() == "chain" ) then
            --TODO
        end

    end
end


-- ==========================================Animations stuff


function Object:AddAnimation( iSpriteFile, iImagecount, iFps, iFlipX, iFlipY )
    if not self.mBody then
        return
    end

    x = self.mBody:getX() - self.mW / 2
    y = self.mBody:getY() - self.mH / 2
    table.insert( self.mAnimations, Animation:New( iSpriteFile, x, y, self.mW, self.mH, self.mBody:getAngle(), iImagecount, iFps, iFlipX, iFlipY ) )
end


function Object:PlayAnimation( current, iNumberOfPlays, iPlayEndCB, iPlayEndCBArguments )
    if self.mCurrentAnimation == current then
        return
    end
    if self.mCurrentAnimation > 0 then
        self.mAnimations[self.mCurrentAnimation]:Stop()
    end

    self.mCurrentAnimation = current
    if current == 0 then
        return
    end
    self.mAnimations[self.mCurrentAnimation]:Play( iNumberOfPlays, iPlayEndCB, iPlayEndCBArguments )
end


-- ==========================================Collision stuff


function Object:Collide( iObject )
    --does nothing
end


-- ==========================================XML IO


function  Object:SaveXML()
    xassert( false ) -- This method shouldn't be called as Object is abstract
                        -- Your object needs to override this method
end


function  Object:SaveObjectXML()

    xmlData = "<object "

    xmlData = xmlData .. "x='" .. self.mX .. "' " ..
                         "y='" .. self.mY .. "' " ..
                         "w='" .. self.mW .. "' " ..
                         "h='" .. self.mH .. "' " ..
                         " >\n"

    xmlData = xmlData .. SaveBodyXML( self.mBody )

    -- TODO at some point, save those :
        -- self.mAnimations         = {}
        -- self.mCurrentAnimation   = 0

    xmlData = xmlData .. "</object>\n"

    return  xmlData

end


function  Object:LoadObjectXML( iNode, iWorld )

    assert( iNode.name == "object" )

    self.mBody = LoadBodyXML( iNode.el[ 1 ], iWorld, self )

    self.mX  = iNode.attr[ 1 ].value
    self.mY  = iNode.attr[ 2 ].value
    self.mW  = iNode.attr[ 3 ].value
    self.mH  = iNode.attr[ 4 ].value

    self.mAnimations         = {}
    self.mCurrentAnimation   = 0

    self.mNeedDestroy = false

    ObjectPool.AddObject( self )

end



return Object

