ECSIncludes  = require "src/ECS/ECSIncludes"

local SkillBar = {}
SkillBar.mId = 0


-- ==========================================Build/Destroy


function SkillBar:New( iX, iY )
    local entity = Entity:New( "SkillBar"..SkillBar.mId )
    SkillBar.mId = SkillBar.mId + 1

    -- Components
    entity:AddComponent( SpriteComponent:NewFromFile( "resources/CommOp1/Images/UI/BottomBar.png" ) )
    entity:AddComponent( PositionComponent:New( iX, iY ) )
    entity:AddComponent( SkillListComponent:New() )
    entity:AddTag( "camerafree" )
    entity:AddTag( "isGUI" )
    
    ECSWorld:AddEntity( entity )

    return  entity
end

return  SkillBar