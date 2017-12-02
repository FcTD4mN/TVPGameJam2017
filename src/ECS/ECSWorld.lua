local ECSWorld = {
    mEntities = {},
    mSystems  = {}
}



function  ECSWorld:AddEntity( iEntity )

    table.insert( self.mEntities, iEntity )

    for i = 1, #self.mSystems do

        local system = self.mSystems[ i ]
        if iEntity:MatchComponentsName( system:Requirements() ) then

            table.insert( system.mEntityGroup, iEntity )
            table.insert( iEntity.mObserverSystems, system )

        end

    end

end


function  ECSWorld:RemoveEntity( iEntity )

    local index = GetObjectIndexInTable( iEntity, self.mEntities )
    table.remove( self.mEntities, index )

end


function  ECSWorld:AddSystem( iSystem )

    table.insert( self.mSystems, iSystem )
    iSystem:Initialize()

    for i = 1, #self.mEntities do

        local entity = self.mEntities[ i ]
        if entity:MatchComponentsName( iSystem:Requirements() ) then

            table.insert( iSystem.mEntityGroup, entity )
            table.insert( entity.mObserverSystems, iSystem )

        end

    end

end


function  ECSWorld:Update( iDT )

    for i = 1, #self.mEntities do

        local entity = self.mEntities[ i ]
        if entity.mDestroy then
            self:RemoveEntity( entity )
        end

    end

    for i = 1, #self.mSystems do

        local system = self.mSystems[ i ]
        system:Update( iDT )

    end

end


function  ECSWorld:Draw( iCamera )

    for i = 1, #self.mSystems do

        local system = self.mSystems[ i ]
        system:Draw( iCamera )

    end

end


-- EVENTS : =================================================================================


function ECSWorld:KeyPressed( iKey, iScancode, iIsRepeat )

    for i = 1, #self.mSystems do

        local system = self.mSystems[ i ]

        system:KeyPressed( iKey, iScancode, iIsRepeat )

    end

end


function ECSWorld:KeyReleased( iKey, iScancode )

    for i = 1, #self.mSystems do

        local system = self.mSystems[ i ]
        system:KeyReleased( iKey, iScancode )

    end

end



return  ECSWorld
