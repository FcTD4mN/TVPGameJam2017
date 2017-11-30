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


function  BasicComponents:NewBox2DComponent( iWorld, iBodyX, iBodyY, iBodyW, iBodyH, iPhysicType, iDoesRotation, iGravity )

    local  newBox2DComponent = {}
    newBox2DComponent.mName = "box2d"

    newBox2DComponent.mBodyX = iBodyX
    newBox2DComponent.mBodyY = iBodyY
    newBox2DComponent.mBodyW = iBodyW
    newBox2DComponent.mBodyH = iBodyH

    newBox2DComponent.mBody     = love.physics.newBody( iWorld, newBox2DComponent.mBodyX + newBox2DComponent.mBodyW / 2, newBox2DComponent.mBodyY + newBox2DComponent.mBodyH / 2, iPhysicType )
    newBox2DComponent.mBody:setFixedRotation( iDoesRotation )
    newBox2DComponent.mBody:setGravityScale( iGravity )

    return  newBox2DComponent

end


function  BasicComponents:NewSimpleSprite( iFileName )

    local  newSimpleSprite = {}
    newSimpleSprite.mName = "sprite"

    newSimpleSprite.mImage = love.graphics.newImage( iFileName )

    return  newSimpleSprite

end


function  BasicComponents:NewColor( iR, iG, iB )

    local  newColor = {}
    newColor.mName = "color"

    newColor.mR = iR
    newColor.mG = iG
    newColor.mB = iB

    return  newColor

end


return  BasicComponents
