local ECSWorld = {
    mEntities = {},
    mSystems  = {}
}


function  ECSWorld:AddEntity( iEntity )

    table.insert( self.mEntities, iEntity )

    self:UpdateWorldForEntity( iEntity )

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


function  ECSWorld:UpdateWorldForEntity( iEntity )

    for i = 1, #self.mSystems do

        local system = self.mSystems[ i ]
        if iEntity:MatchComponentsName( system:Requirements() ) then

            table.insert( system.mEntityGroup, iEntity )
            table.insert( iEntity.mObserverSystems, system )

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


-- ==========================================XML IO


function  ECSWorld:SaveXML()
    return  self:SaveECSWorldXML()
end


function  ECSWorld:SaveECSWorldXML()

    xmlData = "<ecsworld>\n"
    for k,v in pairs( self.mEntities ) do
        xmlData = xmlData .. v:SaveXML()
    end
    xmlData = xmlData .. "</ecsworld>\n"

    return  xmlData

end


function  ECSWorld:LoadECSWorldXML( iNode, iWorld )

    assert( iNode.name == "ecsworld" )

    for i = 1, #iNode.el do
        self:AddEntity( Entity:NewFromXML( iNode.el[ i ], iWorld ) )
    end

    self:AddSystem( SpriteRenderer )
    self:AddSystem( InputConverter )
    self:AddSystem( AnimationRenderer )
    self:AddSystem( HeroController )
    self:AddSystem( WallDrawer )
    self:AddSystem( SpikeDrawer )
    self:AddSystem( MotionAI )
    self:AddSystem( HangingBallRenderer )
end

return  ECSWorld
