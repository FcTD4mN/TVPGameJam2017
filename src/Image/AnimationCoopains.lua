BigImage        = require("src/Image/BigImage")
AnimationLoader = require("src/Image/AnimationLoader") --TODO: use it here
Camera          = require("src/Camera/Camera")

local Animation = {}


function Animation:New( image, x, y, w, h, angleInRadians, imagecount, fps, flipX, flipY )
    local newAnimation = {}
    setmetatable( newAnimation, self )
    self.__index = self

    --newAnimation.image = image
    newAnimation.x = x
    newAnimation.y = y

    local imageW, imageH = image:getDimensions()
    newAnimation.quadW = imageW / imagecount
    newAnimation.quadH = imageH
    newAnimation.w = w
    newAnimation.h = h
    newAnimation.angleInRad = angleInRadians -- in rad
    newAnimation.flipX = flipX
    newAnimation.flipY = flipY
    newAnimation.fps = fps
    newAnimation.currentquad = 1
    newAnimation.time = 0
    newAnimation.imagecount = imagecount
    newAnimation.playing = false
    newAnimation.pauseAtEnd = false
    newAnimation.display = false
    newAnimation.playCountToReach = 0
    newAnimation.playEndCB = nil
    newAnimation.playEndCBArguments = nil

    newAnimation.bigImage = BigImage:NewFromImage( image, imageW / imagecount )

    newAnimation.quads = {}
    for i=0,imagecount-1,1 do
        newAnimation.quads[i+1] = love.graphics.newQuad( newAnimation.quadW * i, 0, newAnimation.quadW, newAnimation.quadH, imageW, imageH )
    end

    return newAnimation
end


function  Animation:Type()
    return  "Animation"
end


function Animation:Pause()
    self.playing = false
end

function Animation:Stop()
    self.playing = false
    self.display = false
    self.currentquad = 1
    self.time = 0
    self.playEndCB = nil
    self.playEndCBArguments = nil
end

function Animation:Play( iNumberOfPlays, iPlayEndCB, ... ) -- 0 is not infinite --Can be called without playEndCB
    self.currentquad = 1
    self.playCountToReach = iNumberOfPlays --to avoid playing a unwanted frame at end
    self.playing = true
    self.display = true
    self.playEndCB = iPlayEndCB
    self.playEndCBArguments = ... --unpack( arg )
end

function Animation:Update( dt, x, y, w, h, angleInRad )

    if w then self.w = w end
    if h then self.h = h end
    if x then self.x = x end
    if y then self.y = y end
    if angleInRad then self.angleInRad = angleInRad end

    if self.playing then
        self.time = self.time + dt
        local playCount = math.floor( self.time * self.fps / self.imagecount )
        if self.playCountToReach > 0 and playCount >= self.playCountToReach then
            self.currentquad = math.max( 1, math.floor( 1 + ( self.time * self.fps - 1 ) % ( self.imagecount ) ) )
            self.playing = false
            if self.playEndCB then
                self.playEndCB( self.playEndCBArguments )
                self.playEndCB = nil
                self.playEndCBArguments = nil
            end
        else
            self.currentquad = math.floor( 1 + ( self.time * self.fps ) % ( self.imagecount ) )
        end
    end
end


function Animation:Draw( iCamera, iX, iY )
    if self.display then
        love.graphics.setColor( 255, 255, 255, 255 )
        --print( self.currentquad )

        local x = iX
        local y = iY
        -- local x = self.x
        -- local y = self.y
        local w = self.w * iCamera.mScale
        local h = self.h * iCamera.mScale
        local scaleX = math.min( w/self.quadW, h/self.quadH )
        local scaleY = scaleX
        if self.flipX then
            scaleX = -scaleX
        end
        if self.flipY then
            scaleY = -scaleY
        end
        x, y = iCamera:MapToScreen( x, y )
        local currentQuad = self.quads[ self.currentquad ]

        local quadInBigImage = self.bigImage:Image( currentQuad )
        local defaultQuad = love.graphics.newQuad( 0, 0, self.quadW, self.quadH, self.quadW, self.quadH )
        love.graphics.draw( quadInBigImage, defaultQuad, x + w / 2, y + h / 2, self.angleInRad, scaleX, scaleY, self.quadW / 2, self.quadH / 2 )
    end
end

return Animation