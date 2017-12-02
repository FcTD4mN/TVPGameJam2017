local Animation = {}

function Animation:New( iFileName, iImageCount, iFPS, iLoop, iFlipX, iFlipY )
    local newAnimation = {}
    setmetatable( newAnimation, self )
    self.__index = self

    newAnimation.mImage = love.graphics.newImage( iFileName )
    newAnimation.mImageCount = iImageCount
    newAnimation.mQuadW = newAnimation.mImage:getWidth() / newAnimation.mImageCount
    newAnimation.mQuadH = newAnimation.mImage:getHeight()
    newAnimation.mFlipX = iFlipX
    newAnimation.mFlipY = iFlipY
    newAnimation.mFPS = iFPS
    newAnimation.mLoop = iLoop
    newAnimation.mIsPaused = false
    newAnimation.mQuads = {}
    newAnimation.mTime = 0
    newAnimation.mCurrentQuadIndex = 1
    newAnimation.mPlayEndCB = nil
    newAnimation.mPlayEndCBArguments = nil
    
    for i = 0, newAnimation.mImageCount - 1, 1 do
        newAnimation.mQuads[i+1] = love.graphics.newQuad( newAnimation.mQuadW * i, 0, newAnimation.mQuadW, newAnimation.mQuadH, newAnimation.mImage:getWidth(), newAnimation.mImage:getHeight() )
    end

    return newAnimation
end


function  Animation:Type()
    return  "Animation"
end

return Animation