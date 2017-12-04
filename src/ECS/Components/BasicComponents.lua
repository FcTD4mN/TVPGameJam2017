local BasicComponents = {}

function BasicComponents:NewFromXML( iNode, iWorld, iEntity )
    return  BasicComponents:LoadBasicComponentsXML( iNode, iWorld, iEntity )
end


function  BasicComponents:NewBox2DComponent( iWorld, iBodyX, iBodyY, iBodyW, iBodyH, iPhysicType, iFixedRotation, iGravity, iOffsetY )

    local  newBox2DComponent = {}
    newBox2DComponent.mName = "box2d"

    newBox2DComponent.mBodyW = iBodyW
    newBox2DComponent.mBodyH = iBodyH
    newBox2DComponent.mOffsetY = iOffsetY

    newBox2DComponent.mBody = love.physics.newBody( iWorld, iBodyX + iBodyW / 2, iBodyY + iBodyH / 2, iPhysicType )
    newBox2DComponent.mBody:setFixedRotation( iFixedRotation )
    newBox2DComponent.mBody:setGravityScale( iGravity )

    return  newBox2DComponent

end


function  BasicComponents:NewSimpleSprite( iFileName )

    local  newSimpleSprite = {}
    newSimpleSprite.mName = "sprite"

    newSimpleSprite.mFileName = iFileName
    newSimpleSprite.mImage = love.graphics.newImage( iFileName )

    return  newSimpleSprite

end


function  BasicComponents:NewAnimationsComponent( iAnimations, iDefaultAnimationIndex )

    local  newAnimations = {}
    newAnimations.mName = "animations"
    newAnimations.mAnimations = iAnimations
    newAnimations.mDefaultAnimationIndex = iDefaultAnimationIndex
    newAnimations.mCurrentAnimationIndex = iDefaultAnimationIndex

    return  newAnimations

end


function  BasicComponents:NewStateComponent( iState, iStateTransitions )

    local  newState = {}
    newState.mName = "state"
    newState.mState = iState
    newState.mAllowedTransitions = iStateTransitions

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


function  BasicComponents:NewKillable()

    local  newKillable = {}
    newKillable.mName = "killable"

    newKillable.mDeathCount = 0

    return  newKillable

end


function  BasicComponents:NewTeleporter( iX, iY )

    local  newTeleporter = {}
    newTeleporter.mName = "teleporter"

    newTeleporter.mTeleportPositionX = iX
    newTeleporter.mTeleportPositionY = iY

    return  newTeleporter

end


function  BasicComponents:NewActionGiver( iAction )

    local  newActionGiver = {}
    newActionGiver.mName = "actiongiver"

    newActionGiver.mAction = iAction

    return  newActionGiver

end


function  BasicComponents:NewMotionComponent( iPath, iLoop )

    local  newMotion = {}

    newMotion.mName = "motion"

    -- mPath contains points with there attributes
    -- mPath
    -- \-- ["points"]
    --      \-- [1]
    --          \-- ["x"] --in world ?
    --          \-- ["y"] --in world ?
    --          \-- ["time"]  --Time is the time in second at which the point is reached
    --      \-- ...
    --      \-- [n]
    newMotion.mPath = iPath
    newMotion.mLoop = iLoop -- Should the motion loop ( this does not mean the path goes in loop, only the motion )

    --runtime -- not saved
    newMotion.mCurrentTime = 0

    return  newMotion

end

-- ==========================================Dummy components


function  BasicComponents:NewWallComponent( iWall )

    local  newWall = {}
    newWall.mName = "wall"

    return  newWall

end


function  BasicComponents:NewSpikeComponent( iSpike )

    local  newSpike = {}
    newSpike.mName = "spike"

    return  newSpike

end


-- ==========================================XML IO


function  BasicComponents:SaveXML( iComponent )
    return  self:SaveBasicComponentsXML( iComponent )
end


function toboolean( iValue )
    return  iValue == "true"
end


function  BasicComponents:SaveBasicComponentsXML( iComponent )
    xmlData = "<component "

    if iComponent.mName == "box2d" then
        xmlData =   xmlData .. "name='" .. iComponent.mName .. "' " ..
                    "bodyx='" .. iComponent.mBody:getX() .. "' " ..
                    "bodyy='" .. iComponent.mBody:getY() .. "' " ..
                    "bodyw='" .. iComponent.mBodyW .. "' " ..
                    "bodyh='" .. iComponent.mBodyH .. "' " ..
                    "physictype='" .. iComponent.mBody:getType() .. "' " ..
                    "fixedrotation='" .. tostring(iComponent.mBody:isFixedRotation()) .. "' " ..
                    "gravity='" .. iComponent.mBody:getGravityScale() .. "' " ..
        " >\n"

        fixtures = iComponent.mBody:getFixtureList()
        for k,v in pairs( fixtures ) do
            xmlData = xmlData .. SaveFixtureXML( v )
        end

        xmlData = xmlData .. "</component>\n"
    elseif iComponent.mName == "sprite" then
        xmlData =   xmlData .. "name='" .. iComponent.mName .. "' " ..
                    "filename='" .. iComponent.mFileName .. "' " ..
                    " >\n"
        xmlData = xmlData .. "</component>\n"
    elseif iComponent.mName == "animations" then
        local animations = {}
        xmlData = xmlData .. " >\n"
        xmlData = xmlData .. "<animations default='"..iComponent.mDefaultAnimationIndex.."' >\n"
        for i = 1, #iComponent.mAnimations do
            xmlData =   xmlData .. "<animation "
            xmlData =   xmlData .. "name='" .. iComponent.mAnimations[i].mName .. "' " ..
                        "filename='" .. iComponent.mAnimations[i].mName .. "' " ..
                        "imagecount='" .. iComponent.mAnimations[i].mImageCount .. "' " ..
                        "fps='" .. iComponent.mAnimations[i].mFPS .. "' " ..
                        "loop='" .. tostring(iComponent.mAnimations[i].mLoop) .. "' " ..
                        "flipx='" .. tostring(iComponent.mAnimations[i].mFlipX) .. "' " ..
                        "flipy='" .. tostring(iComponent.mAnimations[i].mFlipY) .. "' " ..
                        "maxtime='" .. iComponent.mAnimations[i].mMaxTime .. "' " ..
                        " >\n"
            xmlData =   xmlData .. "</animation>\n"
        end
        xmlData = xmlData .. "</animations>\n"
        xmlData = xmlData .. "</component>\n"
    elseif iComponent.mName == "state" then
        xmlData =   xmlData .. "name='" .. iComponent.mName .. "' " ..
                    "state='" .. iComponent.mState .. "' " ..
                    " >\n"
        for k1,v1 in pairs(iComponent.mAllowedTransitions) do
            xmlData =   xmlData .. "<allowedtransitions '"
            xmlData =   xmlData .. "state='" .. k1 .. "' "
            for k2,v2 in pairs(iComponent.mAllowedTransitions[k1]) do
                xmlData =   xmlData .. "state" .. k2 .."='" .. v2 .. "' "
            end
            xmlData =   xmlData .. " />\n"
        end
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
    elseif iComponent.mName == "killable" then

        xmlData =   xmlData .. "name='" .. iComponent.mName .. "' " ..
                    "deathcount='" .. iComponent.mDeathCount .. "' " ..
                    " >\n"
        xmlData = xmlData .. "</component>\n"

    elseif iComponent.mName == "teleporter" then

        xmlData =   xmlData .. "name='" .. iComponent.mName .. "' " ..
                    "teleportpositionx='" .. iComponent.mTeleportPositionX .. "' " ..
                    "teleportpositiony='" .. iComponent.mTeleportPositionY .. "' " ..
                    " >\n"
        xmlData = xmlData .. "</component>\n"

    elseif iComponent.mName == "actiongiver" then

        xmlData =   xmlData .. "name='" .. iComponent.mName .. "' " ..
                    "action='" .. iComponent.mAction .. "' " ..
                    " >\n"
        xmlData = xmlData .. "</component>\n"
    elseif iComponent.mName == "path" then
        xmlData =   xmlData .. "name='" .. iComponent.mName .. "' " ..
                    "loop='" .. tostring(iComponent.mLoop) .. "' " ..
                    " >\n"
        xmlData =   xmlData .. "<Path>\n"
            xmlData =   xmlData .. "<Points>\n"
                for i = 0, #iComponent.mPath["points"] do
                    xmlData =   xmlData .. "<Point \n"
                    xmlData =   xmlData ..  "x='" .. iComponent.mPath["points"][i]["x"] .. "' " ..
                                            "y='" .. iComponent.mPath["points"][i]["y"] .. "' " ..
                                            "time='" .. iComponent.mPath["points"][i]["time"] .. "' " ..
                                            " />\n"
                end
            xmlData = xmlData .. "</Points>\n"
        xmlData = xmlData .. "<Path/>\n" --Path
        xmlData = xmlData .. "</component>\n"







    elseif iComponent.mName == "spike" then

        xmlData =   xmlData .. "name='" .. iComponent.mName .. "' " ..
                    " >\n"
        xmlData = xmlData .. "</component>\n"

    elseif iComponent.mName == "wall" then

        xmlData =   xmlData .. "name='" .. iComponent.mName .. "' " ..
                    " >\n"
        xmlData = xmlData .. "</component>\n"

    end

    return  xmlData
end


function  BasicComponents:LoadBasicComponentsXML( iNode, iWorld, iEntity )

    assert( iNode.name == "component" )

    local name = iNode.attr[1].value

    if name == "box2d" then
        local component = BasicComponents:NewBox2DComponent( iWorld, iNode.attr[2].value - iNode.attr[4].value / 2, iNode.attr[3].value - iNode.attr[5].value / 2, iNode.attr[4].value, iNode.attr[5].value, iNode.attr[6].value, iNode.attr[7].value == "true", iNode.attr[8].value )
        for i = 1, #iNode.el do
            fixture = LoadFixtureXML( iNode.el[ i ], component.mBody, iEntity )
        end
        return  component
    elseif name == "sprite" then
        return  BasicComponents:NewSimpleSprite( iNode.attr[2].value )
    elseif name == "animations" then
        local animations = {}
        local default = iNode.attr[1].value
        for i = 1, #iNode.el[1].el do
            animations[i] = Animation:New( iNode.el[1].el[i].attr[1].value, iNode.el[1].el[i].attr[2].value, iNode.el[1].el[i].attr[3].value, iNode.el[1].el[i].attr[4].value == "true", iNode.el[1].el[i].attr[5].value == "true", iNode.el[1].el[i].attr[6].value == "true", iNode.el[1].el[i].attr[7].value )
        end
        return  BasicComponents:NewAnimationsComponent( animations, default )
    elseif name == "state" then
        local allowedTransitions = {}
        for i = 1, #iNode.el do
            allowedTransitions[ iNode.el[i].attr[1] ] = {}
            for j = 2, #iNode.el[i].attr do
                allowedTransitions[ iNode.el[i].attr[1] ][j] = iNode.el[i].attr[j].value
            end
        end
        return  BasicComponents:NewStateComponent( iNode.attr[2].value, allowedTransitions )
    elseif name == "direction" then
        return  BasicComponents:NewDirectionComponent( iNode.attr[2].value, iNode.attr[3].value )
    elseif name == "userinput" then
        return  BasicComponents:NewUserInput()
    elseif name == "killable" then
        local  killable = BasicComponents:NewKillable()
        killable.mDeathCount = iNode.attr[2].value
        return  killable
    elseif name == "teleporter" then
        local  teleporter = BasicComponents:NewTeleporter()
        teleporter.mTeleportPositionX = iNode.attr[2].value
        teleporter.mTeleportPositionY = iNode.attr[3].value
        return  teleporter
    elseif name == "actiongiver" then
        local  actiongiver = BasicComponents:NewActionGiver()
        actiongiver.mAction = iNode.attr[2].value
        return  actiongiver
    elseif name == "path" then
        local path = {}
        path[ "points" ] = {}
        for i = 1, #iNode.el[0].el[0].el do --<path><points><i>
            path[ "points" ][i] = {}
            path[ "points" ][i]["x"] = iNode.el[0].el[0].el[i].attr[1]
            path[ "points" ][i]["y"] = iNode.el[0].el[0].el[i].attr[2]
            path[ "points" ][i]["time"] = iNode.el[0].el[0].el[i].attr[3]
        end
        return  BasicComponents:NewPathComponent( path, toboolean(iNode.attr[1]) )
    elseif name == "wall" then
        return  BasicComponents:NewWallComponent()
    elseif name == "spike" then
        return  BasicComponents:NewSpikeComponent()
    end
end


return  BasicComponents
