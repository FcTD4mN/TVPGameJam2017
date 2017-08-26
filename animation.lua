Animation = {}


function Animation:new( filename, imagecount, fps, x, y, quadX, quadY, quadW, quadH )
    local newAnimation = {}
    setmetatable( newAnimation, self )
    self.__index = self

    newAnimation.image = love.graphics.newImage( filename )
    newAnimation.x = x
    newAnimation.y = y
    newAnimation.quadw = quadW
    newAnimation.quadh = quadH
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

function Animation:togglepause()
    if self.display then
        self.playing = not self.playing
    end
end

function Animation:stop()
    self.playing = false
    self.currentquad = 0
    self.time = 0
    self.display = false
end

function Animation:play()
    self.playing = true
    self.display = true
end

function Animation:update( dt, x, y )
    if self.playing then
        self.time = self.time + dt
        self.currentquad = math.floor( 1 + ( self.time * self.fps ) % ( self.imagecount ) )
    end
    self.x = x
    self.y = y
end

function Animation:draw()
    if self.display then
        love.graphics.draw( self.image, self.quads[self.currentquad], self.x, self.y )
    end
end