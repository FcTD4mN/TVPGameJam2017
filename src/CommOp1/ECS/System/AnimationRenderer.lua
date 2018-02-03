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

    local position = iEntity:GetComponentByName( "position" )
    local animations = iEntity:GetComponentByName( "animations" )
    local size = iEntity:GetComponentByName( "size" )

    if animations and position and size then
        table.insert( self.mEntityGroup, iEntity )
        table.insert( iEntity.mObserverSystems, self )
    end

end


function AnimationRenderer:Update( iDT )

    if gCamera.mScale > 0.1 then

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
end


function  AnimationRenderer:Draw( iCamera )

    love.graphics.setColor( 255, 255, 255 )

    for i = 1, #self.mEntityGroup do

        local entity = self.mEntityGroup[ i ]
        local position = entity:GetComponentByName( "position" )
        local animationComponent = entity:GetComponentByName( "animations" )

        if( gCamera.mScale > 0.1 ) then

            local animation = animationComponent.mAnimations[ animationComponent.mCurrentAnimationIndex ]
            if animation then
                local x, y = iCamera:MapToScreen( position.mX, position.mY )

                local scaleX = iCamera.mScale
                local scaleY = iCamera.mScale
                local currentQuad = animation.mQuads[ animation.mCurrentQuadIndex ]
                qx, qy, qw, qh = currentQuad:getViewport()

                if animation.mFlipX then
                    scaleX = -scaleX
                    x = x + qw * iCamera.mScale
                end
                if animation.mFlipY then
                    scaleY = -scaleY
                    y = y + qh * iCamera.mScale
                end



                    love.graphics.draw( animation.mImage, currentQuad, x, y, 0, scaleX, scaleY, 0, 0 )
            end

        else

            local size = entity:GetComponentByName( "size" )
            local faction = entity:GetComponentByName( "faction" )

            local r,g,b = 0,0,0
            if faction and faction.mFaction == "neutral" then
                r,g,b = 200,200,200
            elseif faction and faction.mFaction == "capitalist" then
                r,g,b = 50,50,255
            else
                r,g,b = 255,50,50
            end

            love.graphics.setColor( r, g, b )
            love.graphics.rectangle( "fill", position.mX, position.mY, size.mW * gCamera.mScale, size.mH * gCamera.mScale )

        end
    end

end


-- ==========================================Type


function AnimationRenderer:Type()
    return "AnimationRenderer"
end


return  AnimationRenderer
