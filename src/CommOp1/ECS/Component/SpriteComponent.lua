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
    newSpriteComponent:LoadFile( iFileName, iQuad )

    return  newSpriteComponent

end


function SpriteComponent:NewFromImage( iImage, iQuad )

    local newSpriteComponent = {}
    setmetatable( newSpriteComponent, SpriteComponent )
    SpriteComponent.__index = SpriteComponent
    
    newSpriteComponent.mName = "sprite"
    newSpriteComponent:LoadImage( iImage, iQuad )

    return  newSpriteComponent

end


function SpriteComponent:LoadFile( iFileName, iQuad )
    self.mImage = ImageLoader.LoadSimpleImage( iFileName )
    self.mW = self.mImage:getWidth()
    self.mH = self.mImage:getHeight()
    self.mQuad = iQuad

    if not self.mQuad then
        self.mQuad = love.graphics.newQuad( 0, 0, self.mImage:getWidth(), self.mImage:getHeight(), self.mImage:getWidth(), self.mImage:getHeight() )
    end
end


function SpriteComponent:LoadImage( iImage, iQuad )
    self.mImage = iImage
    self.mW = self.mImage:getWidth()
    self.mH = self.mImage:getHeight()
    self.mQuad = iQuad

    if not self.mQuad then
        self.mQuad = love.graphics.newQuad( 0, 0, self.mImage:getWidth(), self.mImage:getHeight(), self.mImage:getWidth(), self.mImage:getHeight() )
    end
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