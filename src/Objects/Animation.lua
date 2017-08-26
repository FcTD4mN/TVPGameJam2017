local Animation = {}


function Animation:New( filename, imagecount, fps, x, y, w, h, quadX, quadY, quadW, quadH, flipX, flipY )
    local newAnimation = {}
    setmetatable( newAnimation, self )
    self.__index = self

    newAnimation.image = love.graphics.newImage( filename )
    newAnimation.x = x
    newAnimation.y = y
    newAnimation.w = w
    newAnimation.h = h
    if flipX then
        newAnimation.x = x + w
        newAnimation.w = -w
    end
    if flipY then
        newAnimation.y = y + h
        newAnimation.h = -h
    end

    newAnimation.quadw = quadW
    newAnimation.quadh = quadH
    newAnimation.rotation = 0 -- in rad

    newAnimation.fps = fps
    newAnimation.currentquad = 0
    newAnimation.time = -1
    newAnimation.imagecount = imagecount
    newAnimation.playing = false
    newAnimation.display = false

    newAnimation.quads = {}
    for i=1,imagecount,1 do
        newAnimation.quads[i] = love.graphics.newQuad( quadX + quadW * ( i - 1 ), quadY, quadW, quadH, newAnimation.image:getDimensions() )
    end

    return newAnimation
end


function  Animation:Type()
    return  "Animation"
end


function Animation:TogglePause()
    if self.display then
        self.playing = not self.playing
    end
end


function Animation:Stop()
    self.playing = false
    self.currentquad = 0
    self.time = 0
    self.display = false
end


function Animation:Play()
    self.playing = true
    self.display = true
end


function Animation:Update( dt, x, y )
    if self.playing then
        self.time = self.time + dt
        self.currentquad = math.floor( 1 + ( self.time * self.fps ) % ( self.imagecount ) )
    end
    self.x = x
    self.y = y

    if self.w < 0 then --flipX
        self.x = self.x - self.w
    end
    if self.h < 0 then --flipY
        self.y = self.y - self.h
    end
end


function Animation:Draw()
    if self.display then
        love.graphics.setColor( 255, 255, 255, 255 )
        --print( self.currentquad )
        love.graphics.draw( self.image, self.quads[self.currentquad], self.x, self.y, self.rotation, self.w/self.quadw, self.h/self.quadh )
    end
end

return Animation