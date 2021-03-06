local SystemBase = require( "src/ECS/Systems/SystemBase" )

local  AnimationRenderer = {}
setmetatable( AnimationRenderer, SystemBase )
SystemBase.__index = SystemBase


function  AnimationRenderer:Initialize()

    self.mEntityGroup = {}

end


function AnimationRenderer:IncomingEntity( iEntity )

    -- Here we decide if we are interested by iEntity or not
    -- =====================================================

    local box2d = iEntity:GetComponentByName( "box2d" )
    local animations = iEntity:GetComponentByName( "animations" )

    if animations and box2d then
        table.insert( self.mEntityGroup, iEntity )
        table.insert( iEntity.mObserverSystems, self )
    end

end


function AnimationRenderer:Update( iDT )
    --does nothing
    for i = 1, #self.mEntityGroup do
        local animationComponent = self.mEntityGroup[ i ]:GetComponentByName( "animations" )

        local animation = animationComponent.mAnimations[ animationComponent.mCurrentAnimationIndex ]
        if animation then
            if not animation.mIsPaused then
                animation.mTime = animation.mTime + iDT
                animation.mCurrentQuadIndex =  math.floor( animation.mTime * animation.mFPS )
                if animation.mLoop and ( not animation.mMaxTime or ( animation.mMaxTime and animation.mTime <= animation.mMaxTime ) ) then
                    animation.mCurrentQuadIndex = animation.mCurrentQuadIndex % ( animation.mImageCount )
                elseif ( animation.mMaxTime and animation.mTime > animation.mMaxTime ) or ( ( not animation.mMaxTime ) and animation.mCurrentQuadIndex >= animation.mImageCount ) then
                    animation.mIsPaused = true
                    if animation.mPlayEndCB then
                        animation.mPlayEndCB( animation.mPlayEndCBArguments )
                    end
                end
                animation.mCurrentQuadIndex = math.min( animation.mCurrentQuadIndex + 1, animation.mImageCount ) --arrays starts at index 1
            end
        end
    end
end


function  AnimationRenderer:Draw( iCamera )

    love.graphics.setColor( 255, 255, 255 )

    for i = 1, #self.mEntityGroup do

        local box2d = self.mEntityGroup[ i ]:GetComponentByName( "box2d" )
        local direction = self.mEntityGroup[ i ]:GetComponentByName( "direction" )
        local animationComponent = self.mEntityGroup[ i ]:GetComponentByName( "animations" )

        local animation = animationComponent.mAnimations[ animationComponent.mCurrentAnimationIndex ]
        if animation then
            local x, y = iCamera:MapToScreen( box2d.mBody:getX() - animation.mQuadW / 2, box2d.mBody:getY() + box2d.mBodyH / 2 - animation.mQuadH + box2d.mOffsetY )

            local scaleX = iCamera.mScale
            local scaleY = iCamera.mScale

            if animation.mFlipX then
                scaleX = -scaleX
            end
            if animation.mFlipY then
                scaleY = -scaleY
            end

            if direction then
                if direction.mDirectionH == "left" then
                    scaleX = -scaleX
                end
                if direction.mDirectionV == "down" then
                    scaleY = -scaleY
                end
            end

            local currentQuad = animation.mQuads[ animation.mCurrentQuadIndex ]
            love.graphics.draw( animation.mImage, currentQuad, x + animation.mQuadW / 2, y + animation.mQuadH / 2, box2d.mBody:getAngle(), scaleX, scaleY, animation.mQuadW / 2, animation.mQuadH / 2 )
        end
    end

end


-- ==========================================Type


function AnimationRenderer:Type()
    return "AnimationRenderer"
end


return  AnimationRenderer
