ECSIncludes  = require "src/ECS/ECSIncludes"

local Skill = {}
Skill.mId = 0


-- ==========================================Build/Destroy


function Skill:New( iIconFile, iAction )
    local entity = Entity:New( "Skill"..Skill.mId )
    Skill.mId = Skill.mId + 1

    -- Components
    entity:AddComponent( SpriteComponent:NewFromFile( iIconFile ) )
    entity:AddComponent( PositionComponent:New( 0, 0 ) )
    entity:AddComponent( ClickBoxComponent:New( 0, 0, 80, 80 ) )
    entity:AddComponent( ActionComponent:New( iAction ) )
    entity:AddTag( "camerafree" )
    ECSWorld:AddEntity( entity )

    return  entity
end

return  Skill