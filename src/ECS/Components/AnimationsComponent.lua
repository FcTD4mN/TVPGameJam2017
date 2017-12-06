local Component = require "src/ECS/Components/Component"
local ComponentRegistry = require "src/ECS/Components/ComponentRegistry"

local AnimationsComponent = {}
setmetatable( AnimationsComponent, Component )
Component.__index = Component

ComponentRegistry.Register( "animationscomponent", AnimationsComponent )


-- ==========================================Constructor/Destructor


function AnimationsComponent:New( iAnimations, iDefaultAnimationIndex )
    local newAnimationsComponent = {}
    setmetatable( newAnimationsComponent, AnimationsComponent )
    AnimationsComponent.__index = AnimationsComponent
    
    newAnimationsComponent.mName = "animations"

    newAnimationsComponent.mAnimations = iAnimations
    newAnimationsComponent.mDefaultAnimationIndex = iDefaultAnimationIndex
    newAnimationsComponent.mCurrentAnimationIndex = iDefaultAnimationIndex

    return  newAnimationsComponent

end


function AnimationsComponent:NewFromXML( iNode, iWorld, iEntity )
    local newAnimationsComponent = {}
    setmetatable( newAnimationsComponent, AnimationsComponent )
    AnimationsComponent.__index = AnimationsComponent

    newAnimationsComponent.mName = "animations"

    newAnimationsComponent:LoadAnimationsComponentXML( iNode, iWorld, iEntity )

    return newAnimationsComponent
end


function  AnimationsComponent:SaveXML()
    return  self:SaveAnimationsComponentXML()
end


function  AnimationsComponent:SaveAnimationsComponentXML()
    
    xmlData = "<animationscomponent>\n"

    xmlData = xmlData .. self:SaveComponentXML()

    local animations = {}
    xmlData = xmlData .. "<attributes default='" .. self.mDefaultAnimationIndex.."' >\n"
    xmlData = xmlData .. "<animations>\n"
    for i = 1, #self.mAnimations do
        xmlData =   xmlData .. "<animation "
        xmlData =   xmlData .. "name='" .. self.mAnimations[i].mName .. "' " ..
                    "filename='" .. self.mAnimations[i].mFileName .. "' " ..
                    "imagecount='" .. self.mAnimations[i].mImageCount .. "' " ..
                    "fps='" .. self.mAnimations[i].mFPS .. "' " ..
                    "loop='" .. tostring(self.mAnimations[i].mLoop) .. "' " ..
                    "flipx='" .. tostring(self.mAnimations[i].mFlipX) .. "' " ..
                    "flipy='" .. tostring(self.mAnimations[i].mFlipY) .. "' " ..
                    "maxtime='" .. self.mAnimations[i].mMaxTime .. "' " ..
                    " >\n"
        xmlData =   xmlData .. "</animation>\n"
    end
    xmlData = xmlData .. "</animations>\n"
    xmlData = xmlData .. "</attributes>\n"

    xmlData = xmlData .. "</animationscomponent>\n"
    
    return  xmlData

end


function  AnimationsComponent:LoadAnimationsComponentXML( iNode, iWorld, iEntity )

    assert( iNode.name == "animationscomponent" )

    self:LoadComponentXML( iNode.el[1] )

    self.mDefaultAnimationIndex = iNode.el[2].attr[1].value
    for i = 1, #iNode.el[2].el[1].el do
        self.mAnimations[i] = Animation:New( iNode.el[2].el[1].el[i].attr[1].value,
                                             iNode.el[2].el[1].el[i].attr[2].value,
                                             iNode.el[2].el[1].el[i].attr[3].value,
                                             ToBoolean(iNode.el[2].el[1].el[i].attr[4].value),
                                             ToBoolean(iNode.el[2].el[1].el[i].attr[5].value),
                                             ToBoolean(iNode.el[2].el[1].el[i].attr[6].value),
                                             iNode.el[2].el[1].el[i].attr[7].value )
    end
end


return  AnimationsComponent