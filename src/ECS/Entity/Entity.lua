local Entity = {}


function  Entity:New( iID )

    local newEntity = {}
    setmetatable( newEntity, Entity )
    Entity.__index = Entity

    newEntity.mID = iID
    newEntity.mComponents = {}
    newEntity.mTags = {}        -- Tags are "boolean" components, to avoid creating objects with no data. Gives a property such as lootable, or killable
    newEntity.mDestroy = false

    newEntity.mObserverSystems = {} -- Entity knows which systems are observing, when destroyed, an entity can remove itself from system directly -> fast

    return  newEntity

end


function  Entity:Destroy()

    self.mDestroy = true
    for i = 1, #self.mObserverSystems do
        self.mObserverSystems[ i ]:RemoveEntity( self )
    end

end


--COMPONENT MANAGEMENT----------------------------------------------------


function  Entity:AddComponent( iComponent )

    self.mComponents[ iComponent.mName ] = iComponent

end


function  Entity:RemoveComponentByName( iComponentName )

    self.mComponents[ iComponentName ] = nil

end


function  Entity:GetComponentByName( iComponentName )

    return  self.mComponents[ iComponentName ]

end


function  Entity:MatchComponentsName( ... )

    for i = 1, select( "#", ... ) do

        local componentName = select( i, ... )
        if self:GetComponentByName( componentName ) == nil then
            return  false
        end
    end

    return  true

end


--TAGS MANAGEMENT----------------------------------------------------


function  Entity:AddTag( iTag )

    self.mTags[ iTag ] = 1
    -- Update systems observers/ groups

end


function  Entity:RemoveTag( iTag )

    self.mTags[ iTag ] = 0

end


function  Entity:GetTagByName( iTagName )

    return  self.mTags[ iTagName ]

end


return  Entity
