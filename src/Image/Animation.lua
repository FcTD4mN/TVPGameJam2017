local Animation = {}

function Animation:New( iFileName )
    local newAnimation = {}
    setmetatable( newAnimation, self )
    self.__index = self

    newSimpleSprite.mImage = love.graphics.newImage( iFileName )
    newAnimations.mQuadW = mImage.getWidth() / mImageCount
    newAnimations.mQuadH = mImage.getHeight()
    newAnimations.mFlipX = iFlipX
    newAnimations.mFlipY = iFlipY
    newAnimations.mFPS = iFPS
    newAnimations.mImageCount = iImageCount
    newAnimations.mLoop = iLoop
    newAnimations.mIsPaused = iLoop
    newAnimations.mQuads = {}
    newAnimation.mTime = 0
    newAnimation.mCurrentQuadIndex = 1
    newAnimation.mPlayEndCB = nil
    newAnimation.mPlayEndCBArguments = nil
    
    for i = 0, mImageCount - 1, 1 do
        newAnimations.mQuads[i+1] = love.graphics.newQuad( newAnimations.mQuadW * i, 0, newAnimations.mQuadW, newAnimations.mQuadH, mImage.getWidth(), mImage.getHeight() )
    end

    return newAnimation
end


function  Animation:Type()
    return  "Animation"
end

return Animation