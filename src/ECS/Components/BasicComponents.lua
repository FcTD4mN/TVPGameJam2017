local BasicComponents = {}


function BasicComponents:NewFromXML( iNode, iWorld )
    return BasicComponents:LoadBasicComponentsXML( iNode, iWorld )
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


function  BasicComponents:NewUserInput()

    local  newUserInput = {}
    newUserInput.mName = "userinput"

    newUserInput.mActions = {}

    return  newUserInput

end


-- ==========================================XML IO


function  BasicComponents:SaveXML()
    return  self:SaveBasicComponentsXML()
end


function  BasicComponents:SaveBasicComponentsXML( iComponent )
    xmlData = "<component "
                
    if iComponent.mName == "box2d" then
        xmlData =   xmlData .. "name='" .. iComponent.mName .. "' " ..
                    "bodyx='" .. iComponent.mBodyX .. "' " ..
                    "bodyy='" .. iComponent.mBodyY .. "' " ..
                    "bodyw='" .. iComponent.mBodyW .. "' " ..
                    "bodyh='" .. iComponent.mBodyH .. "' " ..
                    "physictype='" .. iComponent.mBody:getType() .. "' " ..
                    "fixedrotation='" .. iComponent.mBody:getFixedRotation() .. "' " ..
                    "gravity='" .. iComponent.mBody:getGravity() .. "' " ..
                    " >\n"
        xmlData = xmlData .. "</component>\n"
    elseif iComponent.mName == "simplesprite" then
        xmlData =   xmlData .. "name='" .. iComponent.mName .. "' " ..
                    "filename='" .. iComponent.mName .. "' " ..
                    " >\n"
        xmlData = xmlData .. "</component>\n"
    elseif iComponent.mName == "animations" then
        local animations = {}
        xmlData = xmlData .. " >\n"
        xmlData = xmlData .. "<animations>\n"
        for i = 1, #iComponent.mAnimations do
            xmlData =   xmlData .. "<animation "
            xmlData =   xmlData .. "name='" .. iComponent.mAnimations[i].mName .. "' " ..
                        "filename='" .. iComponent.mAnimations[i].mName .. "' " ..
                        "imagecount='" .. iComponent.mAnimations[i].mImageCount .. "' " ..
                        "fps='" .. iComponent.mAnimations[i].mFPS .. "' " ..
                        "loop='" .. iComponent.mAnimations[i].mLoop .. "' " ..
                        "flipx='" .. iComponent.mAnimations[i].mFlipX .. "' " ..
                        "flipy='" .. iComponent.mAnimations[i].mFlipY .. "' " ..
                        " >\n"
            xmlData =   xmlData .. "</animation>\n"
        end
        xmlData = xmlData .. "</animations>\n"
        xmlData = xmlData .. "</component>\n"
    elseif iComponent.mName == "state" then
        xmlData =   xmlData .. "name='" .. iComponent.mName .. "' " ..
                    "state='" .. iComponent.mState .. "' " ..
                    " >\n"
        xmlData = xmlData .. "</component>\n"
    elseif iComponent.mName == "direction" then
        xmlData =   xmlData .. "name='" .. iComponent.mName .. "' " ..
                    "directionh='" .. iComponent.mDirectionH .. "' " ..
                    "directionv='" .. iComponent.mDirectionV .. "' " ..
                    " >\n"
        xmlData = xmlData .. "</component>\n"
    elseif iComponent.mName == "userinput" then
        xmlData =   xmlData .. "name='" .. iComponent.mName .. "' " ..
                    " >\n"
        xmlData = xmlData .. "</component>\n"
    end

    return  xmlData
end


function  BasicComponents:LoadBasicComponentsXML( iNode, iWorld )

    assert( iNode.name == "component" )

    local name = iNode.attr[1].value

    if name == "box2d" then
        return  NewBox2DComponent( iWorld, iNode.attr[2].value, iNode.attr[3].value, iNode.attr[4].value, iNode.attr[5].value, iNode.attr[6].value, iNode.attr[7].value, iNode.attr[8].value )        
    elseif name == "simplesprite" then
        return  NewSimpleSprite( iNode.attr[2].value )        
    elseif name == "animations" then
        local animations = {}
        for i = 1, #iNode.el[1].el do
            animations[i] = Animation:New( iNode.el[1].el[i].attr[1].value, iNode.el[1].el[i].attr[2].value, iNode.el[1].el[i].attr[3].value, iNode.el[1].el[i].attr[4].value, iNode.el[1].el[i].attr[5].value, iNode.el[1].el[i].attr[6].value )
        end
        return  NewAnimationsComponent( animations )        
    elseif name == "state" then
        return  NewStateComponent( iNode.attr[2].value )        
    elseif name == "direction" then
        return  NewDirectionComponent( iNode.attr[2].value, iNode.attr[3].value )
    elseif name == "userinput" then
        return  NewUserInput()       
    end
end


return  BasicComponents
