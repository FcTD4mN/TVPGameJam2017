local Background    = require "src/Objects/Background"
local Tree          = require "src/Objects/Tree"
local Hero          = require "src/Game/Hero"
local BigImage      = require "src/Image/BigImage"
local AttackGenerator    = require "src/Game/AttackGenerator"
local ImageShapeComputer = require "src/Image/ImageShapeComputer"
local GrowingTree = require "src/Game/GrowingTree"

local Game = {}

function beginContact(a, b, coll)
    if not coll:isTouching() then
        return
    end

    if a:getUserData() == "GrowingTree" and b:getUserData() == "Fireball" then
        a:Grow()
    end
    if b:getUserData() == "GrowingTree" and a:getUserData() == "Fireball" then
        b:Grow()
    end
end
 
function endContact(a, b, coll)
    
end
 
function preSolve(a, b, coll)
 
end
 
function postSolve(a, b, coll, normalimpulse, tangentimpulse)
 
end

function Game:Initialize()
    AttackGenerator:Initialize()

    love.physics.setMeter( 100 )
    world = love.physics.newWorld( 0, 9.81 * love.physics.getMeter(), true ) --normal gravity
    world:setCallbacks(beginContact, endContact, preSolve, postSolve)

    hero1 =  Hero:New( world, 50, love.graphics.getHeight() - 100, 0 )
    hero2 = Hero:New( world, 50, 50, 1 )
    tree  = Tree:New( world, 500, 250 )

    imageShapeComputer = ImageShapeComputer:New( "resources/Images/Backgrounds/Final/TERRAIN.png", 20 )
    Game:BuildTerrainShape()

    colorBackground = BigImage:New( "resources/Images/Backgrounds/Final/GRADIENT.png", 500 )
    backgrounds = {}
    foregrounds = {}
    table.insert( backgrounds, Background:New( "resources/Images/Backgrounds/Background3000x720.png", 0, 0, 0 ) )
    terrain = Background:New( "resources/Images/Backgrounds/Final/TERRAIN.png", 0, 0, 0 )
    table.insert( foregrounds, Background:New( "resources/Images/Backgrounds/Foreground3000x720.png", 0, 0 , -1 ) )

    growingtree = GrowingTree:New( world, 800, love.graphics.getHeight() - 150 )
end

function Game:Draw()
    colorBackground:Draw( 0, 0 )

    for k,v in pairs( backgrounds ) do
        v:Draw()
    end

    terrain:Draw()

    hero1:Draw()
    hero2:Draw()
    tree:Draw()
    -- local x, y, x2, y2 = floor2.shape:computeAABB( 0, 0, 0 )
    -- x, y, x2, y2 = floor2.body:getWorldPoints( x, y, x2, y2 )
    growingtree:Draw()
    -- x, y = Camera.MapToScreen( x, y )
    -- x2, y2 = Camera.MapToScreen( x2, y2 )

    -- love.graphics.rectangle( "fill", x, y, x2-x, y2-y )

    -- x, y = Camera.MapToScreen( x, y )
    -- x2, y2 = Camera.MapToScreen( x2, y2 )

    -- love.graphics.rectangle( "fill", x, y, x2-x, y2-y )

    for k,v in pairs( foregrounds ) do
        v:Draw()
    end

    --self:DrawTerrainShape()
end

function Game:DrawTerrainShape()

    love.graphics.setColor( 255, 0, 0, 255 )
    count = imageShapeComputer.pointCount
    for i = 0, count-1, 1 do
        love.graphics.polygon(  "line",
                                -Camera.x + imageShapeComputer.pointsMiddleTop[i].x,
                                -Camera.y + imageShapeComputer.pointsMiddleTop[i].y,
                                -Camera.x + imageShapeComputer.pointsMiddleTop[i+1].x,
                                -Camera.y + imageShapeComputer.pointsMiddleTop[i+1].y,
                                -Camera.x + imageShapeComputer.pointsMiddleBot[i+1].x,
                                -Camera.y + imageShapeComputer.pointsMiddleBot[i+1].y,
                                -Camera.x + imageShapeComputer.pointsMiddleBot[i].x,
                                -Camera.y + imageShapeComputer.pointsMiddleBot[i].y )
        love.graphics.polygon(  "line",
                                -Camera.x + imageShapeComputer.pointsFloor[i].x,
                                -Camera.y + imageShapeComputer.pointsFloor[i].y,
                                -Camera.x + imageShapeComputer.pointsFloor[i].x,
                                -Camera.y + 720,
                                -Camera.x + imageShapeComputer.pointsFloor[i+1].x,
                                -Camera.y + 720,
                                -Camera.x + imageShapeComputer.pointsFloor[i+1].x,
                                -Camera.y + imageShapeComputer.pointsFloor[i+1].y )
        love.graphics.polygon(  "line",
                                -Camera.x + imageShapeComputer.pointsCeiling[i].x,
                                -Camera.y + imageShapeComputer.pointsCeiling[i].y,
                                -Camera.x + imageShapeComputer.pointsCeiling[i].x,
                                -Camera.y + 0,
                                -Camera.x + imageShapeComputer.pointsCeiling[i+1].x,
                                -Camera.y + 0,
                                -Camera.x + imageShapeComputer.pointsCeiling[i+1].x,
                                -Camera.y + imageShapeComputer.pointsCeiling[i+1].y )
    end
end

function Game:Update( dt )

    for k,v in pairs( backgrounds ) do
        v:Update( dt )
    end
    terrain:Update()

    hero1:Update( dt )
    hero2:Update( dt )
    tree:Update( dt )
    growingtree:Update( dt )
    world:update( dt )

    for k,v in pairs( foregrounds ) do
        v:Update( dt )
    end

    x, y, x2, y2 = hero1.shape:computeAABB( 0, 0, 0 )
    x, y, x2, y2 = hero1.body:getWorldPoints( x, y, x2, y2 )
    
    uerx, uery, uerx2, uery2 = hero2.shape:computeAABB( 0, 0, 0 )
    uerx, uery, uerx2, uery2 = hero2.body:getWorldPoints( uerx, uery, uerx2, uery2 )
    
    xza = ( x + uerx ) / 2
    
    Camera.x = xza - love.graphics.getWidth() / 2
    Camera.y = 0 --love.graphics.getHeight() / 2

    return 1
end

function Game:KeyPressed( key, scancode, isrepeat )
    hero1:KeyPressed( key, scancode, isrepeat )
    hero2:KeyPressed( key, scancode, isrepeat )
end

function Game:KeyReleased( key, scancode )
    hero1:KeyReleased( key, scancode )
    hero2:KeyReleased( key, scancode )
end

function  Game:mousepressed( iX, iY, iButton, iIsTouch )
    --
end

function  Game:BuildTerrainShape()
    count = imageShapeComputer.pointCount

    edgesFloor = {}
    edgesCeiling = {}
    edgesMiddle = {}

    for i = 0, count-1, 1 do
        edgesMiddle[i] = {}
        edgesMiddle[i].body = love.physics.newBody( world, 0 , 0, "static" )
        edgesMiddle[i].shape = love.physics.newPolygonShape( imageShapeComputer.pointsMiddleTop[i].x,
                                                            imageShapeComputer.pointsMiddleTop[i].y,
                                                            imageShapeComputer.pointsMiddleBot[i].x,
                                                            imageShapeComputer.pointsMiddleBot[i].y,
                                                            imageShapeComputer.pointsMiddleBot[i+1].x,
                                                            imageShapeComputer.pointsMiddleBot[i+1].y,
                                                            imageShapeComputer.pointsMiddleTop[i+1].x,
                                                            imageShapeComputer.pointsMiddleTop[i+1].y )
        edgesMiddle[i].fixture = love.physics.newFixture( edgesMiddle[i].body, edgesMiddle[i].shape )
        edgesMiddle[i].fixture:setFriction( 0.3 )
        edgesMiddle[i].fixture:setUserData( "edge" )

        edgesFloor[i] = {}
        edgesFloor[i].body = love.physics.newBody( world, 0 , 0, "static" )
        edgesFloor[i].shape = love.physics.newPolygonShape( imageShapeComputer.pointsFloor[i].x,
                                                            imageShapeComputer.pointsFloor[i].y,
                                                            imageShapeComputer.pointsFloor[i].x,
                                                            720,
                                                            imageShapeComputer.pointsFloor[i+1].x,
                                                            720,
                                                            imageShapeComputer.pointsFloor[i+1].x,
                                                            imageShapeComputer.pointsFloor[i+1].y )
        edgesFloor[i].fixture = love.physics.newFixture( edgesFloor[i].body, edgesFloor[i].shape )
        edgesFloor[i].fixture:setFriction( 0.3 )
        edgesFloor[i].fixture:setUserData( "edge" )

        edgesCeiling[i] = {}
        edgesCeiling[i].body = love.physics.newBody( world, 0 , 0, "static" )
        edgesCeiling[i].shape = love.physics.newPolygonShape( imageShapeComputer.pointsCeiling[i].x,
                                                            imageShapeComputer.pointsCeiling[i].y,
                                                            imageShapeComputer.pointsCeiling[i].x,
                                                            0,
                                                            imageShapeComputer.pointsCeiling[i+1].x,
                                                            0,
                                                            imageShapeComputer.pointsCeiling[i+1].x,
                                                            imageShapeComputer.pointsCeiling[i+1].y )
        edgesCeiling[i].fixture = love.physics.newFixture( edgesCeiling[i].body, edgesCeiling[i].shape )
        edgesCeiling[i].fixture:setFriction( 0.3 )
        edgesCeiling[i].fixture:setUserData( "edge" )
    end
end


return Game