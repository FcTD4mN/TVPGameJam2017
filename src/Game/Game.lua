local Background    = require "src/Objects/Background"
local Hero          = require "src/Game/Hero"
local BigImage      = require "src/Image/BigImage"
local AttackGenerator    = require "src/Game/AttackGenerator"
local ImageShapeComputer = require "src/Image/ImageShapeComputer"

local Game = {}

function Game:Initialize()
    AttackGenerator:Initialize()

    love.physics.setMeter( 100 )
    world = love.physics.newWorld( 0, 9.81 * love.physics.getMeter(), true ) --normal gravity

    hero1 =  Hero:New( world, 50, love.graphics.getHeight() - 100, 0 )
    hero2 = Hero:New( world, 50, 50, 1 )

    imageShapeComputer = ImageShapeComputer:New( "resources/Images/Backgrounds/Terrain.png", 10 )
    Game:BuildTerrainShape()

    backgrounds = {}
    foregrounds = {}
    table.insert( backgrounds, Background:New( "resources/Images/Backgrounds/Background3000x720.png", 0, 0, 0 ) )
    terrain = Background:New( "resources/Images/Backgrounds/Terrain.png", 0, 0, 0 )
    table.insert( foregrounds, Background:New( "resources/Images/Backgrounds/Foreground3000x720.png", 0, 0 , -1 ) )

    floor = {}
    floor.body = love.physics.newBody( world, love.graphics.getWidth() / 2, love.graphics.getHeight() - 10, "static" )
    floor.shape = love.physics.newRectangleShape( 3000, 10 )
    floor.fixture = love.physics.newFixture( floor.body, floor.shape )
    floor.fixture:setFriction( 0.0 )

    floor2 = {}
    floor2.body = love.physics.newBody( world, love.graphics.getWidth() / 2, love.graphics.getHeight() / 2 - 10, "static" )
    floor2.shape = love.physics.newRectangleShape( 3000, 10 )
    floor2.fixture = love.physics.newFixture( floor2.body, floor2.shape )
    floor2.fixture:setFriction( 0.0 )
end

function Game:Draw()
    for k,v in pairs( backgrounds ) do
        v:Draw()
    end

    terrain:Draw()

    hero1:Draw()
    hero2:Draw()
    -- local x, y, x2, y2 = floor2.shape:computeAABB( 0, 0, 0 )
    -- x, y, x2, y2 = floor2.body:getWorldPoints( x, y, x2, y2 )
    -- x, y = Camera.MapToScreen( x, y )
    -- x2, y2 = Camera.MapToScreen( x2, y2 )

    -- love.graphics.rectangle( "fill", x, y, x2-x, y2-y )

    -- x, y, x2, y2 = floor2.shape:computeAABB( 0, 0, 0 )
    -- x, y, x2, y2 = floor2.body:getWorldPoints( x, y, x2, y2 )
    -- x, y = Camera.MapToScreen( x, y )
    -- x2, y2 = Camera.MapToScreen( x2, y2 )

    -- love.graphics.rectangle( "fill", x, y, x2-x, y2-y )

    for k,v in pairs( foregrounds ) do
        v:Draw()
    end

    love.graphics.setColor( 255, 255, 255, 255 )
    count = imageShapeComputer.pointCount
    for i = 0, count-1, 1 do
        ---love.graphics.line( -Camera.x + imageShapeComputer.pointsMiddleTop[i].x, -Camera.y + imageShapeComputer.pointsFloor[i].y, -Camera.x + imageShapeComputer.pointsFloor[i+1].x, -Camera.y + imageShapeComputer.pointsFloor[i+1].y )
        --love.graphics.line( -Camera.x + imageShapeComputer.pointsFloor[i+1].x, -Camera.y + imageShapeComputer.pointsFloor[i+1].y, -Camera.x + 9999, -Camera.y + 9999 )
        --love.graphics.line( -Camera.x + imageShapeComputer.pointsFloor[i].x, -Camera.y + imageShapeComputer.pointsFloor[i].y, -Camera.x + 9999, -Camera.y + 9999 )
            love.graphics.polygon(                              "line",
                                                            -Camera.x + imageShapeComputer.pointsMiddleTop[i].x, 
                                                            -Camera.y + imageShapeComputer.pointsMiddleTop[i].y, 
                                                            -Camera.x + imageShapeComputer.pointsMiddleTop[i+1].x, 
                                                            -Camera.y + imageShapeComputer.pointsMiddleTop[i+1].y,
                                                            -Camera.x + imageShapeComputer.pointsMiddleBot[i+1].x, 
                                                            -Camera.y + imageShapeComputer.pointsMiddleBot[i+1].y, 
                                                            -Camera.x + imageShapeComputer.pointsMiddleBot[i].x, 
                                                            -Camera.y + imageShapeComputer.pointsMiddleBot[i].y ) 
        --love.graphics.line( -Camera.x + imageShapeComputer.pointsMiddleBot[i].x, -Camera.y + imageShapeComputer.pointsMiddleBot[i].y, -Camera.x + imageShapeComputer.pointsMiddleBot[i+1].x, -Camera.y + imageShapeComputer.pointsMiddleBot[i+1].y )
        --love.graphics.line( -Camera.x + imageShapeComputer.pointsMiddleTop[i].x, -Camera.y + imageShapeComputer.pointsMiddleTop[i].y, -Camera.x + imageShapeComputer.pointsMiddleTop[i+1].x, -Camera.y + imageShapeComputer.pointsMiddleTop[i+1].y )
        --love.graphics.line( -Camera.x + imageShapeComputer.pointsCeiling[i].x, -Camera.y + imageShapeComputer.pointsCeiling[i].y, -Camera.x + imageShapeComputer.pointsCeiling[i+1].x, -Camera.y + imageShapeComputer.pointsCeiling[i+1].y )

    end

end

function Game:Update( dt )

    for k,v in pairs( backgrounds ) do
        v:Update( dt )
    end
    terrain:Update()

    hero1:Update( dt )
    hero2:Update( dt )
    world:update( dt )

    for k,v in pairs( foregrounds ) do
        v:Update( dt )
    end
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

    edgesfloor = {}

    -- newImageShapeComputer.pointsMiddleTop = {}
    -- newImageShapeComputer.pointsMiddleBot = {}

    for i = 0, count-1, 1 do
        edgesfloor[i] = {}
        edgesfloor[i].body = love.physics.newBody( world, 0 , 0, "static" )
        edgesfloor[i].shape = love.physics.newPolygonShape( imageShapeComputer.pointsMiddleTop[i].x, 
                                                            imageShapeComputer.pointsMiddleTop[i].y, 
                                                            imageShapeComputer.pointsMiddleBot[i].x, 
                                                            imageShapeComputer.pointsMiddleBot[i].y,
                                                            imageShapeComputer.pointsMiddleBot[i+1].x, 
                                                            imageShapeComputer.pointsMiddleBot[i+1].y, 
                                                            imageShapeComputer.pointsMiddleTop[i+1].x, 
                                                            imageShapeComputer.pointsMiddleTop[i+1].y ) 
        edgesfloor[i].fixture = love.physics.newFixture( edgesfloor[i].body, edgesfloor[i].shape )
        edgesfloor[i].fixture:setFriction( 0 )
    end
end


return Game