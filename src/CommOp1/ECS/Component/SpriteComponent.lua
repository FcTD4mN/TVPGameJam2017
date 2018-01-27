local Component = require "src/ECS/Components/Component"
local ComponentRegistry = require "src/ECS/Components/ComponentRegistry"

local SpriteComponent = {}
setmetatable( SpriteComponent, Component )
Component.__index = Component

ComponentRegistry.Register( "spritecomponent", SpriteComponent )


-- ==========================================Constructor/Destructor


function SpriteComponent:NewFromFile( iFileName, iQuad )
    local newSpriteComponent = {}
    setmetatable( newSpriteComponent, SpriteComponent )
    SpriteComponent.__index = SpriteComponent
    
    newSpriteComponent.mName = "sprite"
    newSpriteComponent.mImage = love.graphics.newImage( iFileName )
    newSpriteComponent.mQuad = iQuad
    if not newSpriteComponent.mQuad then
        newSpriteComponent.mQuad = love.graphics.newQuad( 0, 0, newSpriteComponent.mImage:getWidth(), newSpriteComponent.mImage:getHeight(), newSpriteComponent.mImage:getWidth(), newSpriteComponent.mImage:getHeight() )
    end

    return  newSpriteComponent

end


function SpriteComponent:NewFromImage( iImage, iQuad )

    local newSpriteComponent = {}
    setmetatable( newSpriteComponent, SpriteComponent )
    SpriteComponent.__index = SpriteComponent
    
    newSpriteComponent.mName = "sprite"
    newSpriteComponent.mImage = iImage
    newSpriteComponent.mQuad = iQuad
    if not newSpriteComponent.mQuad then
        newSpriteComponent.mQuad = love.graphics.newQuad( 0, 0, newSpriteComponent.mImage:getWidth(), newSpriteComponent.mImage:getHeight(), newSpriteComponent.mImage:getWidth(), newSpriteComponent.mImage:getHeight() )
    end

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