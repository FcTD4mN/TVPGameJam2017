ECSIncludes  = require "src/ECS/ECSIncludes"

local Ribbon = {}
Ribbon.mId = 0


-- ==========================================Build/Destroy


function Ribbon:New( iWorld, iX, iY, iPath )
    local entity = Entity:New( "Ribbon".. Ribbon.mId )
    Ribbon.mId = Ribbon.mId + 1

    -- Components
    local box2DComponent = BasicComponents:NewBox2DComponent( iWorld, iX, iY, 283, 521, "static", true, 1 )

    entity:AddComponent( BasicComponents:NewSimpleSprite( iPath ) )
    entity:AddComponent( box2DComponent )

    ECSWorld:AddEntity( entity )

    return  entity
end

return  Ribbon