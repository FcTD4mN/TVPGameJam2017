local SystemBase = require( "src/ECS/Systems/SystemBase" )

local  FactionInfluenceSystem = {}
setmetatable( FactionInfluenceSystem, SystemBase )
SystemBase.__index = SystemBase


function  FactionInfluenceSystem:Initialize()

    self.mEntityGroup = {}

end


function FactionInfluenceSystem:IncomingEntity( iEntity )

    -- Here we decide if we are interested by iEntity or not
    -- =====================================================

    local position = iEntity:GetComponentByName( "position" )
    local radius = iEntity:GetComponentByName( "radius" )
    local faction = iEntity:GetComponentByName( "faction" )

    if position and radius and faction then
        table.insert( self.mEntityGroup, iEntity )
        table.insert( iEntity.mObserverSystems, self )
    end
end


function FactionInfluenceSystem:Update( iDT )

    for i = 1, #self.mEntityGroup do

        local position = self.mEntityGroup[ i ]:GetComponentByName( "position" )
        local radius = self.mEntityGroup[ i ]:GetComponentByName( "radius" )
        local faction = self.mEntityGroup[ i ]:GetComponentByName( "faction" )

        local size = self.mEntityGroup[ i ]:GetComponentByName( "size" )
        local infradius = self.mEntityGroup[ i ]:GetComponentByName( "influencableradius" )

        local rad = radius.mRadius * radius.mRadius * gTileSize *  gTileSize
        local infrad = 0
        if infradius then
            infrad = infradius.mRadius * infradius.mRadius * gTileSize *  gTileSize
        end


        local w,h = 0, 0
        if size then
            w,h = size.mW, size.mH
        end
        local x, y = position.mX + w/2, position.mY + h/2

        for j = i + 1, #self.mEntityGroup do

            local position2 = self.mEntityGroup[ j ]:GetComponentByName( "position" )
            local radius2 = self.mEntityGroup[ j ]:GetComponentByName( "radius" )
            local faction2 = self.mEntityGroup[ j ]:GetComponentByName( "faction" )

            local size2 = self.mEntityGroup[ j ]:GetComponentByName( "size" )
            local infradius2 = self.mEntityGroup[ j ]:GetComponentByName( "influencableradius" )
            
            local rad2 = radius2.mRadius * radius2.mRadius * gTileSize *  gTileSize
            local infrad2 = 0
            if infradius2 then
                infrad2 = infradius2.mRadius * infradius2.mRadius * gTileSize *  gTileSize
            end
            local w2,h2 = 0, 0
            if size2 then
                w2,h2 = size2.mW, size2.mH
            end
            local x2, y2 = position2.mX + w2/2, position2.mY + h2/2

            local dist = ( x - x2 ) * ( x - x2 ) + ( y - y2 ) * ( y - y2 )
            if dist < rad + infrad2 then
                faction2.mFactionScore = faction2.mFactionScore + faction.mInfluenceSign * faction.mInfluence * faction2.mResistance * iDT
                faction2.mFactionScore = math.max( faction2.mFactionScore, 0 )
                faction2.mFactionScore = math.min( faction2.mFactionScore, 100 )

                --print( "apply1 : "..j.."  score : "..faction2.mFactionScore.." sign : "..faction.mInfluenceSign.."   inf :"..faction.mInfluence.."   DT : "..iDT )
            end

            if dist < rad2 + infrad then
                
                faction.mFactionScore = faction.mFactionScore + faction2.mInfluenceSign * faction2.mInfluence * faction.mResistance * iDT
                faction.mFactionScore = math.max( faction.mFactionScore, 0 )
                faction.mFactionScore = math.min( faction.mFactionScore, 100 )
                --print( "apply2 : "..j.."  score : "..faction.mFactionScore.." sign : "..faction2.mInfluenceSign.."   inf :"..faction2.mInfluence.."   DT : "..iDT )
            end
        end
    end
end


function  FactionInfluenceSystem:Draw( iCamera )

end


-- ==========================================Type


function FactionInfluenceSystem:Type()
    return "FactionInfluenceSystem"
end


return  FactionInfluenceSystem
