local BasicComponents = {}


function  BasicComponents:NewBodyComponent( iX, iY, iW, iH )

    local  newBodyComponent = {}
    newBodyComponent.mName = "body"

    newBodyComponent.mX = iX
    newBodyComponent.mY = iY
    newBodyComponent.mW = iW
    newBodyComponent.mH = iH

    return  newBodyComponent

end


function  BasicComponents:NewBox2DComponent( iWorld, iBodyX, iBodyY, iBodyW, iBodyH, iPhysicType, iFixedRotation, iGravity )

    local  newBox2DComponent = {}
    newBox2DComponent.mName = "box2d"

    newBox2DComponent.mBodyX = iBodyX
    newBox2DComponent.mBodyY = iBodyY
    newBox2DComponent.mBodyW = iBodyW
    newBox2DComponent.mBodyH = iBodyH

    newBox2DComponent.mBody     = love.physics.newBody( iWorld, newBox2DComponent.mBodyX + newBox2DComponent.mBodyW / 2, newBox2DComponent.mBodyY + newBox2DComponent.mBodyH / 2, iPhysicType )
    newBox2DComponent.mBody:setFixedRotation( iFixedRotation )
    newBox2DComponent.mBody:setGravityScale( iGravity )

    return  newBox2DComponent

end


function  BasicComponents:NewBox2DComponent( iWorld, iBodyX, iBodyY, iBodyW, iBodyH, iPhysicType, iFixedRotation, iGravity )

    local  newBox2DComponent = {}
    newBox2DComponent.mName = "box2d"

    newBox2DComponent.mBodyX = iBodyX
    newBox2DComponent.mBodyY = iBodyY
    newBox2DComponent.mBodyW = iBodyW
    newBox2DComponent.mBodyH = iBodyH

    newBox2DComponent.mBody     = love.physics.newBody( iWorld, newBox2DComponent.mBodyX + newBox2DComponent.mBodyW / 2, newBox2DComponent.mBodyY + newBox2DComponent.mBodyH / 2, iPhysicType )
    newBox2DComponent.mBody:setFixedRotation( iFixedRotation )
    newBox2DComponent.mBody:setGravityScale( iGravity )

    return  newBox2DComponent

end


function  BasicComponents:NewSimpleSprite( iFileName )

    local  newSimpleSprite = {}
    newSimpleSprite.mName = "sprite"

    newSimpleSprite.mImage = love.graphics.newImage( iFileName )

    return  newSimpleSprite

end


function  BasicComponents:NewAnimationsComponent( iAnimations )

    local  newAnimations = {}
    newAnimations.mName = "animations"
    newAnimations.mAnimations = iAnimations
    

    return  newAnimations

end


function  BasicComponents:NewStateComponent( iState )

    local  newState = {}
    newState.mName = "state"
    newState.mState = iState
    

    return  newState

end


function  BasicComponents:NewDirectionComponent( iDirectionH, iDirectionV )

    local  newDirection = {}
    newDirection.mName = "direction"
    newDirection.mDirectionH = iDirectionH
    newDirection.mDirectionV = iDirectionV
    
    return  newDirection
    
end


function  BasicComponents:NewColor( iR, iG, iB )

    local  newColor = {}
    newColor.mName = "color"

    newColor.mR = iR
    newColor.mG = iG
    newColor.mB = iB

    return  newColor

end


function  BasicComponents:NewUserInput()

    local  newUserInput = {}
    newUserInput.mName = "userinput"

    newUserInput.mActions = {}

    return  newUserInput

end


return  BasicComponents
