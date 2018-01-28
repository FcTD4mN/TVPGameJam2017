local SystemBase = require( "src/ECS/Systems/SystemBase" )
local Shortcuts = require( "src/Application/Shortcuts" )

local  SkillBarLayoutSystem = {}
setmetatable( SkillBarLayoutSystem, SystemBase )
SystemBase.__index = SystemBase


function  SkillBarLayoutSystem:Initialize()

    self.mEntityGroup = {}

end


function SkillBarLayoutSystem:IncomingEntity( iEntity )

    -- Here we decide if we are interested by iEntity or not
    -- =====================================================

    local skilllist = iEntity:GetComponentByName( "skilllist" )
    local position = iEntity:GetComponentByName( "position" )

    if skilllist and position then
        table.insert( self.mEntityGroup, iEntity )
        table.insert( iEntity.mObserverSystems, self )
    end

end


function SkillBarLayoutSystem:Update( iDT )
    
    for i = 1, #self.mEntityGroup do

        local entity        = self.mEntityGroup[ i ]
        local sprite = entity:GetComponentByName( "sprite" )
        local skilllist = entity:GetComponentByName( "skilllist" )
        local position = entity:GetComponentByName( "position" )

        position.mX  = love.graphics.getWidth() / 2 - sprite.mW / 2
        position.mY = love.graphics.getHeight() - sprite.mH

        local spacing = 5
        local x = 5
        local y = 5
        for k,v in pairs( skilllist.mSkills ) do
            local skillposition = v:GetComponentByName( "position" )
            local skillclickbox = v:GetComponentByName( "clickbox" )
            skillposition.mX = position.mX + x
            skillposition.mY = position.mY + y
            skillclickbox.mX = skillposition.mX
            skillclickbox.mY = skillposition.mY
            
            x = x + skillclickbox.mW + spacing
        end
    end
    
end

function  SkillBarLayoutSystem:Draw( iCamera )
end


-- ==========================================Type


function SkillBarLayoutSystem:Type()
    return "SkillBarLayoutSystem"
end


return  SkillBarLayoutSystem
