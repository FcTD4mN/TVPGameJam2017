local SystemBase = require( "src/ECS/Systems/SystemBase" )

local  FactionConversionSystem = {}
setmetatable( FactionConversionSystem, SystemBase )
SystemBase.__index = SystemBase


function  FactionConversionSystem:Initialize()

    self.mEntityGroup = {}

end


function FactionConversionSystem:IncomingEntity( iEntity )

    -- Here we decide if we are interested by iEntity or not
    -- =====================================================

    local faction = iEntity:GetComponentByName( "faction" )

    if  faction  then
        table.insert( self.mEntityGroup, iEntity )
        table.insert( iEntity.mObserverSystems, self )
    end
end


function FactionConversionSystem:Update( iDT )

    for i = 1, #self.mEntityGroup do
        local entity = self.mEntityGroup[ i ]
        local faction = entity.mEntityGroup[ i ]:GetComponentByName( "faction" )
        local animations =  entity.mEntityGroup[ i ]:GetComponentByName( "animations" )
        local selectable =  entity.mEntityGroup[ i ]:GetComponentByName( "selectable" )

        if faction.mFaction ~= "communist" and faction.mFactionScore <=  40 then

            if entity:GetTagByName( "character" ) ~= "0" then
                self:DecreaseFactionCount( faction.mFaction )
                gCommunistCount = gCommunistCount + 1
            end

            faction.mFaction = "communist"
            faction.mInfluenceSign = -1

            if animation then
                animation.mAnimation["idle"] :LoadFile( faction:IdlePath() )
                animation.mAnimation["move"] :LoadFile( faction:MovePath() )
            end

            if gFaction == faction.mFaction then
                entity:AddComponent( SelectableComponent:New() )
            end
        end

        if faction.mFaction ~= "capitalist" and faction.mFactionScore >=  60 then

            if entity:GetTagByName( "character" ) ~= "0" then
                self:DecreaseFactionCount( faction.mFaction )
                gCapitalistCount = gCapitalistCount + 1
            end

            faction.mFaction = "capitalist"
            faction.mInfluenceSign = 1
            
            if animation then
                animation.mAnimation["idle"] :LoadFile( faction:IdlePath() )
                animation.mAnimation["move"] :LoadFile( faction:MovePath() )
            end

            if gFaction == faction.mFaction then
                entity:AddComponent( SelectableComponent:New() )
            end

        end

        if faction.mFaction ~= "neutral" and faction.mFactionScore <  60 and faction.mFactionScore >  40  then

            if entity:GetTagByName( "character" ) ~= "0" then
                self:DecreaseFactionCount( faction.mFaction )
                gNeutralCount = gNeutralCount + 1
            end

            faction.mFaction = "neutral"
            faction.mInfluenceSign = 0

            if animation then
                animation.mAnimation["idle"] :LoadFile( faction:IdlePath() )
                animation.mAnimation["move"] :LoadFile( faction:MovePath() )
            end

            if selectable then
                entity:RemoveComponentByName( "selectable" )
            end

        end
    end
end


function  FactionConversionSystem:Draw( iCamera )

end

function  FactionConversionSystem:DecreaseFactionCount( iFaction )

    if iFaction == "communist" then
        gCommunistCount = gCommunistCount - 1
    elseif iFaction == "capitalist" then
        gCapitalistCount = gCapitalistCount - 1
    elseif iFaction == "neutral" then
        gNeutralCount = gNeutralCount - 1
    end

end


-- ==========================================Type


function FactionConversionSystem:Type()
    return "FactionConversionSystem"
end


return  FactionConversionSystem
