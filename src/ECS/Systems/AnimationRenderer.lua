local SystemBase = require( "src/ECS/Systems/SystemBase" )

local  AnimationRenderer = {}
setmetatable( AnimationRenderer, SystemBase )
SystemBase.__index = SystemBase


function  AnimationRenderer:Initialize()

    self.mEntityGroup = {}

    self.mTime = 0
    self.mTime = 0
end


function AnimationRenderer:Requirements()

    local requirements = {}
    table.insert( requirements, "box2d" )
    table.insert( requirements, "animations" )

    return  unpack( requirements )

end


function AnimationRenderer:Update( iDT )
    --does nothing
    for i = 1, #self.mEntityGroup do
        local animationComponent = self.mEntityGroup[ i ]:GetComponentByName( "animations" )

        local animation = animationComponent.mAnimations[ animationComponent.mCurrentAnimationIndex ]
        if animation then
            if not animation.mIsPaused then
                animation.mTime = animation.mTime + iDT
                animation.mCurrentQuadIndex =  math.floor( animation.mTime * animation.mFPS ) % animation.mImageCount
                if animation.mLoop and animation.mMaxTime and animation.mTime <= animation.mMaxTime then
                    animation.mCurrentQuadIndex = animation.mCurrentQuadIndex % ( animation.mImageCount )
                elseif ( animation.mMaxTime and animation.mTime > animation.mMaxTime ) or ( not animation.mMaxTime and animation.mCurrentQuadIndex >= animation.mImageCount ) then
                    animation.mIsPaused = true
                    if animation.mPlayEndCB then
                        animation.mPlayEndCB( animation.mPlayEndCBArguments )
                    end
                end
                animation.mCurrentQuadIndex = animation.mCurrentQuadIndex + 1 --arrays starts at index 1
            end
        end
    end
end


function  AnimationRenderer:Draw( iCamera )

    for i = 1, #self.mEntityGroup do

        local box2d = self.mEntityGroup[ i ]:GetComponentByName( "box2d" )
        local direction = self.mEntityGroup[ i ]:GetComponentByName( "direction" )
        local animationComponent = self.mEntityGroup[ i ]:GetComponentByName( "animations" )

        local animation = animationComponent.mAnimations[ animationComponent.mCurrentAnimationIndex ]
        if animation then
            local x, y = iCamera:MapToScreen( box2d.mBody:getX() - animation.mQuadW / 2, box2d.mBody:getY() - animation.mQuadH / 2 )

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
