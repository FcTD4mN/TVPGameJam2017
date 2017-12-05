Component = require "src/ECS/Components/Component"

local SpriteComponent = {}
setmetatable( SpriteComponent, Object )
Object.__index = Component

ComponentRegistry.Register( "spritecomponent", SpriteComponent )


-- ==========================================Constructor/Destructor


function SpriteComponent:New( iFileName )
    local newSpriteComponent = {}
    setmetatable( newSpriteComponent, SpriteComponent )
    SpriteComponent.__index = SpriteComponent
    
    newSpriteComponent.mName = "sprite"

    newSpriteComponent.mFileName = iFileName
    newSpriteComponent.mImage = love.graphics.newImage( iFileName )

    return  newSpriteComponent

end


function SpriteComponent:NewFromXML( iNode, iWorld, iEntity )
    local newSpriteComponent = {}
    setmetatable( newSpriteComponent, SpriteComponent )
    SpriteComponent.__index = SpriteComponent

    newSpriteComponent.mName = "sprite"

    newSpriteComponent:LoadSpriteComponentXML( iNode, iWorld, iEntity )

    return newSpriteComponent
end


function  SpriteComponent:SaveXML()
    return  self:SaveSpriteComponentXML()
end


function  SpriteComponent:SaveSpriteComponentXML()
    
    xmlData = "<spritecomponent>"

    xmlData = xmlData .. self:SaveComponentXML()
    xmlData = xmlData .. "<attributes " ..
    xmlData = xmlData .. "filename='" .. iComponent.mFileName .. "' " ..
                         " >\n"

    xmlData = xmlData .. "<spritecomponent />\n"
    
    return  xmlData

end


function  SpriteComponent:LoadSpriteComponentXML( iNode, iWorld, iEntity )

    assert( iNode.name == "spritecomponent" )

    self:LoadComponentXML( iNode.el[1] )

    self.mFileName = iNode.el[2].attr[1].value
    self.mImage = love.graphics.newImage( self.mFileName )
end


return  SpriteComponent