local Component = require "src/ECS/Components/Component"
local ComponentRegistry = require "src/ECS/Components/ComponentRegistry"

local SkillListComponent = {}
setmetatable( SkillListComponent, Component )
Component.__index = Component

ComponentRegistry.Register( "SkillListComponent", SkillListComponent )


-- ==========================================Constructor/Destructor


function SkillListComponent:New()
    local newSkillListComponent = {}
    setmetatable( newSkillListComponent, SkillListComponent )
    SkillListComponent.__index = SkillListComponent

    newSkillListComponent.mName = "skilllist"
    newSkillListComponent.mSkills = {}

    return  newSkillListComponent

end


return  SkillListComponent