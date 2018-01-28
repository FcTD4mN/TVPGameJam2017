local Component = require "src/ECS/Components/Component"
local ComponentRegistry = require "src/ECS/Components/ComponentRegistry"

local SpriteComponent = {}
setmetatable( SpriteComponent, Component )
Component.__index = Component

ComponentRegistry.Register( "spritecomponent", SpriteComponent )


-- ==========================================Constructor/Destructor


function SpriteComponent:New( iFileName )
    local newSpriteComponent = {}
    setmetatable( newSpriteComponent, SpriteComponent )
    SpriteComponent.__index = SpriteComponent
    
    newSpriteComponent.mName = "sprite"
    newSpriteComponent:LoadImage( iFileName )

    return  newSpriteComponent

end


function SpriteComponent:LoadImage( iFileName )
    self.mFileName = iFileName
    self.mImage = ImageLoader.LoadSimpleImage( iFileName )
    self.mW = self.mImage:getWidth()
    self.mH = self.mImage:getHeight()
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
    
    xmlData = "<spritecomponent>\n"

    xmlData = xmlData .. self:SaveComponentXML()
    xmlData = xmlData .. "<attributes "
    xmlData = xmlData .. "filename='" .. self.mFileName .. "' " ..
                         " />\n"

    xmlData = xmlData .. "</spritecomponent>\n"
    
    return  xmlData

end


function  SpriteComponent:LoadSpriteComponentXML( iNode, iWorld, iEntity )

    assert( iNode.name == "spritecomponent" )

    self:LoadComponentXML( iNode.el[1] )

    self.mFileName = iNode.el[2].attr[1].value
    self.mImage = love.graphics.newImage( self.mFileName )
end


return  SpriteComponent