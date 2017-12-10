local ComponentRegistry = require "src/ECS/Components/ComponentRegistry"

local Entity = {}


function  Entity:New( iID )

    local newEntity = {}
    setmetatable( newEntity, Entity )
    Entity.__index = Entity

    newEntity.mID = iID
    newEntity.mComponents = {}
    newEntity.mTags = {}        -- Tags are "boolean" components, to avoid creating objects with no data. Gives a property such as lootable, or killable
    newEntity.mDestroy = false
    newEntity.mLoaded = false

    newEntity.mObserverSystems = {} -- Entity knows which systems are observing, when destroyed, an entity can remove itself from system directly -> fast

    return  newEntity

end


function Entity:NewFromXML( iNode, iWorld )
    local newEntity = {}
    setmetatable( newEntity, Entity )
    Entity.__index = Entity

    newEntity.mTags = {}
    newEntity.mComponents = {}
    newEntity.mObserverSystems = {}
    newEntity:LoadEntityXML( iNode, iWorld )
    newEntity.mLoaded = false -- This prevents initial stage when you build your entity, doing shit ton of addComponent, to update systems every time

    return newEntity
end


function  Entity:Destroy()

    self.mDestroy = true
    for i = 1, #self.mObserverSystems do
        self.mObserverSystems[ i ]:EntityLost( self )
        self.mObserverSystems[ i ] = nil
    end

    for k, v in pairs( self.mComponents ) do
        -- This is a very specific case, as box2d requires its own destruction method
        if k == "box2d" then
            v.mBody:destroy()
        end
        self.mComponents[ k ] = nil
    end

    for k, v in pairs( self.mTags ) do
        self.mTags[ k ] = nil
    end

end


-- ==========================================Type


function Entity:Type()
    return "Entity"
end


--COMPONENT MANAGEMENT----------------------------------------------------


function  Entity:AddComponent( iComponent )

    if( self.mComponents[ iComponent.mName ] ~= nil ) then
        return;
    end

    self.mComponents[ iComponent.mName ] = iComponent

    if self.mLoaded then

        self:QuitSystems()
        ECSWorld:UpdateWorldForEntity( self )

    end

end


function  Entity:RemoveComponentByName( iComponentName )

    if( self.mComponents[ iComponentName ] == nil ) then
        return;
    end

    self.mComponents[ iComponentName ] = nil

    if self.mLoaded then

        self:QuitSystems()
        ECSWorld:UpdateWorldForEntity( self )

    end

end


function  Entity:GetComponentByName( iComponentName )

    return  self.mComponents[ iComponentName ]

end


function  Entity:MatchAllComponentsName( ... )

    for i = 1, select( "#", ... ) do

        local componentName = select( i, ... )
        if self:GetComponentByName( componentName ) == nil and self:GetTagByName( componentName ) == "0" then
            return  false
        end
    end

    return  true

end


function  Entity:MatchAnyComponentsName( ... )

    for i = 1, select( "#", ... ) do

        local componentName = select( i, ... )
        if self:GetComponentByName( componentName ) ~= nil or self:GetTagByName( componentName ) == "1" then
            return  true
        end
    end

    return  false

end


--TAGS MANAGEMENT----------------------------------------------------


function  Entity:AddTag( iTag )

    if( self.mTags[ iTag ] == "1" ) then
        return;
    end

    self.mTags[ iTag ] = "1"

    if self.mLoaded then

        self:QuitSystems()
        ECSWorld:UpdateWorldForEntity( self )

    end

end


function  Entity:RemoveTag( iTag )

    if( self.mTags[ iTag ] == "0" or self.mTags[ iTag ] == nil ) then
        return;
    end

    self.mTags[ iTag ] = "0"

    if self.mLoaded then

        self:QuitSystems()
        ECSWorld:UpdateWorldForEntity( self )

    end

end


function  Entity:GetTagByName( iTagName )

    if not self.mTags[ iTagName ] then
        return  "0"
    end
    return  self.mTags[ iTagName ]

end


function  Entity:QuitSystems()

    for i = 1, #self.mObserverSystems  do

        -- Removes entity from systems
        local system = self.mObserverSystems[ 1 ]
        system:EntityLost( self )
        table.remove( self.mObserverSystems, 1 )

    end

end


-- ==========================================XML IO


function  Entity:SaveXML()
    return  self:SaveEntityXML()
end


function  Entity:SaveEntityXML()

    xmlData = "<entity "
    xmlData =   xmlData .. "id='" .. self.mID .. "' " ..
                " >\n"

    xmlData = xmlData .. "<tags>\n"
    for k,v in pairs( self.mTags ) do
        xmlData = xmlData .. "<tag "
        xmlData =   xmlData .. "name='" .. k .. "' " ..
                    "value='" .. v .. "' " ..
                    " />\n"
    end
    xmlData = xmlData .. "</tags>\n"

    xmlData = xmlData .. "<components>\n"
    for k,v in pairs( self.mComponents ) do
        xmlData = xmlData .. v:SaveXML()
    end
    xmlData = xmlData .. "</components>\n"
    xmlData = xmlData .. "</entity>\n"
    return  xmlData

end


function  Entity:LoadEntityXML( iNode, iWorld )

    assert( iNode.name == "entity" )

    self.mID = iNode.attr[1].value

    for i = 1, #iNode.el[1].el do --<tags><tag ...>
        self.mTags[ iNode.el[1].el[i].attr[ 1 ].value ] = iNode.el[1].el[i].attr[2].value
    end

    for i = 1, #iNode.el[2].el do --<components><XXXcomponent ...>
        local component = ComponentRegistry.CreateFromRegistry( iNode.el[2].el[i].name, iNode.el[2].el[i], iWorld, self )
        self.mComponents[component.mName] = component
    end

end


return  Entity
