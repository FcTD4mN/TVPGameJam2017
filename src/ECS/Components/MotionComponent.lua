local Component = require "src/ECS/Components/Component"
local ComponentRegistry = require "src/ECS/Components/ComponentRegistry"
local Utilities = require "src/Base/Utilities/Base"

local MotionComponent = {}
setmetatable( MotionComponent, Component )
Component.__index = Component

ComponentRegistry.Register( "motioncomponent", MotionComponent )


-- ==========================================Constructor/Destructor


function MotionComponent:New( iLoop )
    local newMotionComponent = {}
    setmetatable( newMotionComponent, MotionComponent )
    MotionComponent.__index = MotionComponent
    
    newMotionComponent.mName = "motion"

    -- mPath contains points with there attributes
    -- mPath
    -- \-- .mPoints
    --      \-- [1]
    --          \-- mBody
    --          \-- mTime  --Time is the time in second at which the point is reached
    --      \-- ...
    --      \-- [n]
    newMotionComponent.mPath = {}
    newMotionComponent.mPath.mPoints= {}
    newMotionComponent.mLoop = iLoop -- Should the motion loop ( this does not mean the path goes in loop, only the motion )

    --runtime -- not saved
    newMotionComponent.mCurrentTime = 0
    newMotionComponent.mCurrentPoint = 0

    return  newMotionComponent

end


function MotionComponent:NewFromXML( iNode, iWorld, iEntity )
    local newMotionComponent = {}
    setmetatable( newMotionComponent, MotionComponent )
    MotionComponent.__index = MotionComponent

    newMotionComponent.mName = "motion"

    newMotionComponent:LoadMotionComponentXML( iNode, iWorld, iEntity )

    return newMotionComponent
end

function MotionComponent:AddPoint( iWorld, iX, iY, iTime )
    local i = #self.mPath.mPoints + 1
    self.mPath.mPoints[i] = {}
    self.mPath.mPoints[i].mBody = love.physics.newBody( iWorld, iX, iY, "static" )
    self.mPath.mPoints[i].mTime = iTime
end

function  MotionComponent:SaveXML()
    return  self:SaveMotionComponentXML()
end


function  MotionComponent:SaveMotionComponentXML()
    
    xmlData = "<motioncomponent>\n"

    xmlData = xmlData .. self:SaveComponentXML()

    xmlData = xmlData .. "<attributes "
    xmlData = xmlData .. "loop='" .. tostring(self.mLoop) .. "' " ..
                " >\n"

    xmlData =   xmlData .. "<Path>\n"
        xmlData =   xmlData .. "<Points>\n"
            for i = 0, #self.mPath.mPoints do
                xmlData =   xmlData ..  "<Point " ..
                                        "bodyx='" .. self.mPath.mPoints[i].mBody:getX() .. "' " ..
                                        "bodyy='" .. self.mPath.mPoints[i].mBody:getY() .. "' " ..
                                        "time='" .. self.mPath.mPoints[i].Time .. "' " ..
                                        " />\n"
            end
        xmlData = xmlData .. "</Points>\n"
    xmlData = xmlData .. "</Path>\n" --Path

    xmlData = xmlData .. "</attributes>\n"
    xmlData = xmlData .. "</motioncomponent>\n"
    
    return  xmlData

end


function  MotionComponent:LoadMotionComponentXML( iNode, iWorld, iEntity )

    assert( iNode.name == "motioncomponent" )

    self:LoadComponentXML( iNode.el[1] )

    self.mPath = {}
    self.mPath.mPoints = {}
    for i = 1, #iNode.el[2].el[1].el[1].el do --<attributes><path><points><i>
        self.mPath.mPoints[i] = {}
        self.mPath.mPoints[i].mBody = love.physics.newBody( iWorld, iNode.el[2].el[1].el[1].el[i].attr[1], iNode.el[2].el[1].el[1].el[i].attr[2], "static" )
        self.mPath.mPoints[i].mTime = iNode.el[2].el[1].el[1].el[i].attr[3]
    end
    self.mLoop = ToBoolean(iNode.el[2].attr[1])
end


return  MotionComponent