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
        local faction = self.mEntityGroup[ i ]:GetComponentByName( "faction" )
        local sprite =  self.mEntityGroup[ i ]:GetComponentByName( "sprite" )
        local selectable =  self.mEntityGroup[ i ]:GetComponentByName( "selectable" )
        
        if faction.mFaction ~= "communist" and faction.mFactionScore <=  40 then
            faction.mFaction = "communist"
            faction.mInfluenceSign = -1

            if sprite then
                sprite:LoadFile( faction:SpritePath() )
            end

            if gFaction == faction.mFaction then
                self.mEntityGroup[ i ]:AddComponent( SelectableComponent:New() )
            end
        end
        
        if faction.mFaction ~= "capitalist" and faction.mFactionScore >=  60 then
            faction.mFaction = "capitalist"
            faction.mInfluenceSign = 1
            if sprite then
                sprite:LoadFile( faction:SpritePath() )
            end

            if gFaction == faction.mFaction then
                self.mEntityGroup[ i ]:AddComponent( SelectableComponent:New() )
            end

        end

        if faction.mFaction ~= "neutral" and faction.mFactionScore <  60 and faction.mFactionScore >  40  then
            faction.mFaction = "neutral"
            faction.mInfluenceSign = 0
            if sprite then
                sprite:LoadFile( faction:SpritePath() )
            end

            if selectable then
                self.mEntityGroup[ i ]:RemoveComponentByName( "selectable" )
            end

        end
    end
end


function  FactionConversionSystem:Draw( iCamera )

end


-- ==========================================Type


function FactionConversionSystem:Type()
    return "FactionConversionSystem"
end


return  FactionConversionSystem
