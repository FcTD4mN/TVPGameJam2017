local Component = require "src/ECS/Components/Component"
local ComponentRegistry = require "src/ECS/Components/ComponentRegistry"
local Utilities = require "src/Base/Utilities/Base"

local MotionComponent = {}
setmetatable( MotionComponent, Component )
Component.__index = Component

ComponentRegistry.Register( "motioncomponent", MotionComponent )


-- ==========================================Constructor/Destructor


function MotionComponent:New()
    local newMotionComponent = {}
    setmetatable( newMotionComponent, MotionComponent )
    MotionComponent.__index = MotionComponent
    
    newMotionComponent.mName = "motion"

    -- mPath contains points with there attributes
    -- mPath
    -- \-- ["points"]
    --      \-- [1]
    --          \-- ["x"] --in world ?
    --          \-- ["y"] --in world ?
    --          \-- ["time"]  --Time is the time in second at which the point is reached
    --      \-- ...
    --      \-- [n]
    newMotionComponent.mPath = iPath
    newMotionComponent.mLoop = iLoop -- Should the motion loop ( this does not mean the path goes in loop, only the motion )

    --runtime -- not saved
    newMotionComponent.mCurrentTime = 0

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
            for i = 0, #self.mPath["points"] do
                xmlData =   xmlData .. "<Point "
                xmlData =   xmlData ..  "x='" .. self.mPath["points"][i]["x"] .. "' " ..
                                        "y='" .. self.mPath["points"][i]["y"] .. "' " ..
                                        "time='" .. self.mPath["points"][i]["time"] .. "' " ..
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
    self.mPath[ "points" ] = {}
    for i = 1, #iNode.el[2].el[0].el[0].el do --<attributes><path><points><i>
        self.mPath[ "points" ][i] = {}
        self.mPath[ "points" ][i]["x"] = iNode.el[2].el[0].el[0].el[i].attr[1]
        self.mPath[ "points" ][i]["y"] = iNode.el[2].el[0].el[0].el[i].attr[2]
        self.mPath[ "points" ][i]["time"] = iNode.el[2].el[0].el[0].el[i].attr[3]
    end
    self.mLoop = ToBoolean(iNode.el[2].attr[1])
end


return  MotionComponent