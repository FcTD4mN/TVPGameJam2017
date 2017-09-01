local Background            = require "src/Image/Background"
local Tree                  = require "src/Objects/Environnement/Tree"
local Singe                 = require "src/Objects/Heros/Singe"
local Lapin                 = require "src/Objects/Heros/Lapin"
local BigImage              = require "src/Image/BigImage"
local AttackGenerator       = require "src/Game/AttackGenerator"
local ImageShapeComputer    = require "src/Image/ImageShapeComputer"
local BabyTree              = require "src/Objects/Environnement/BabyTree"
local GrownTree             = require "src/Objects/Environnement/GrownTree"
local WaterPipe             = require "src/Objects/Environnement/WaterPipe"
local ObjectPool            = require "src/Objects/ObjectPool"
local CollidePool           = require "src/Objects/CollidePool"

local Terrain               = require "src/Objects/Terrain"



local Game = {}

function beginContact( a, b, coll )
    if not coll:isTouching() then
        return
    end

    if a:getUserData() == nil or b:getUserData() == nil then
        return
    end

    if a:getUserData().needDestroy or b:getUserData().needDestroy then
        return
    end

    CollidePool.AddCollision( a:getUserData(), b:getUserData() )
    CollidePool.AddCollision( b:getUserData(), a:getUserData() )
end

function endContact( a, b, coll )

end

function preSolve( a, b, coll )

end

function postSolve( a, b, coll, normalimpulse, tangentimpulse )

end

function Game:Initialize()
    AttackGenerator:Initialize()

    love.physics.setMeter( 100 )
    world = love.physics.newWorld( 0, 9.81 * love.physics.getMeter(), true ) --normal gravity
    world:setCallbacks( beginContact, endContact, preSolve, postSolve )

    music = love.audio.newSource( "resources/Audio/Music/Enjeuloop.mp3", "stream" )
    music:setLooping( true )

    hero1               =  Singe:New( world, 1000, 500 )
    hero2               =  Lapin:New( world, 800, 50 )
    local tree          =  Tree:New( world, 2400, 0 )
    local growingTree   =  BabyTree:New( world, 3700, 600 )
    local waterPipe     =  WaterPipe:New( world, 3600, 130 )

    ObjectPool.AddObject( tree )
    ObjectPool.AddObject( growingTree )
    ObjectPool.AddObject( hero1 )
    ObjectPool.AddObject( hero2 )


    -- TERRAIN
    -- imageShapeComputer = ImageShapeComputer:New( "resources/Images/Backgrounds/Final/TERRAIN.png", 20 )
    -- Game:BuildTerrainShape()
    Game:BuildTerrain()



    -- BACKGROUNDS
    colorBackground = BigImage:New( "resources/Images/Backgrounds/Final/GRADIENT.png", 500 )
    backgrounds = {}
    foregrounds = {}
    table.insert( backgrounds, Background:New( "resources/Images/Backgrounds/Background3000x720.png", 0, 0, 0 ) )
    terrain = Background:New( "resources/Images/Backgrounds/Final/TERRAIN.png", 0, 0, 0 )
    table.insert( foregrounds, Background:New( "resources/Images/Backgrounds/Foreground3000x720.png", 0, 0 , -1 ) )

    -- love.audio.play( music )
end


function  Game:BuildTerrain()
    Terrain.Initialize( world )

    -- Upper ground
    Terrain.AddEdge( 0, 325, 600, 325 )
    Terrain.AppendEdgeToPrevious( 1000, 300 )
    Terrain.AppendEdgeToPrevious( 1250, 300 )
    Terrain.AppendEdgeToPrevious( 1640, 375 )
    Terrain.AppendEdgeToPrevious( 1790, 320 )
    Terrain.AppendEdgeToPrevious( 1980, 320 )
    Terrain.AppendEdgeToPrevious( 2180, 365 )
    Terrain.AppendEdgeToPrevious( 2900, 365 )
    Terrain.AppendEdgeToPrevious( 3370, 330 )
    Terrain.AppendEdgeToPrevious( 3900, 330 )
    Terrain.AddEdge( 4400, 360, 4715, 310 )
    Terrain.AppendEdgeToPrevious( 5110, 360 )
    Terrain.AppendEdgeToPrevious( 6115, 360 )
    Terrain.AppendEdgeToPrevious( 6800, 330 )
    Terrain.AppendEdgeToPrevious( 7690, 310 )
    Terrain.AppendEdgeToPrevious( 8110, 390 )
    Terrain.AppendEdgeToPrevious( 9600, 345 )
    Terrain.AppendEdgeToPrevious( 9600, 0 )

    -- Lower ground
    Terrain.AddEdge( 0, 675, 500, 675 )
    Terrain.AppendEdgeToPrevious( 730, 650 )
    Terrain.AppendEdgeToPrevious( 1460, 700 )
    Terrain.AppendEdgeToPrevious( 2030, 700 )
    Terrain.AppendEdgeToPrevious( 5100, 700 )
    Terrain.AppendEdgeToPrevious( 5300, 715 )
    Terrain.AppendEdgeToPrevious( 5600, 660 )
    Terrain.AppendEdgeToPrevious( 5600, 700 )
    Terrain.AppendEdgeToPrevious( 7650, 680 )
    Terrain.AppendEdgeToPrevious( 7880, 700 )
    Terrain.AppendEdgeToPrevious( 9550, 680 )
    Terrain.AppendEdgeToPrevious( 9600, 350 )
end


function Game:Update( dt )

    for k,v in pairs( backgrounds ) do
        v:Update( dt )
    end
    terrain:Update()

    ObjectPool.Update( dt )
    world:update( dt )
    CollidePool.Update( dt )

    for k,v in pairs( foregrounds ) do
        v:Update( dt )
    end

    self:UpdateCamera()

    return 1
end


function Game:Draw()
    colorBackground:Draw( 0, 0 )

    for k,v in pairs( backgrounds ) do
        v:Draw()
    end

    terrain:Draw()

    ObjectPool.Draw()

    for k,v in pairs( foregrounds ) do
        v:Draw()
    end

    self:DEBUGWorldHITBOXESDraw( "all" )
end

function  Game:UpdateCamera()
    x = hero1:GetX();
    x2 = hero2:GetX();

    xAverage = ( x + x2 ) / 2

    Camera.x = xAverage - love.graphics.getWidth() / 2
    Camera.y = 0 --love.graphics.getHeight() / 2
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
        edgesMiddle[i].fixture:setUserData( nil )

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
        edgesFloor[i].fixture:setUserData( nil )

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
        edgesCeiling[i].fixture:setUserData( nil )
    end
end



function Game:DEBUGWorldHITBOXESDraw( iWhatToDraw )
    local red = 255
    local green = 0
    local blue = 0

    allBodies = world:getBodyList()

    for a, b in pairs( allBodies ) do
        red = 255
        green = 0
        blue = 0
        fixtures = b:getFixtureList()

        for k,v in pairs( fixtures ) do

            love.graphics.setColor( red, green, blue, 125 )

            -- POLYGONS
            if( v:getShape():getType() == "polygon" ) and ( iWhatToDraw == "all" or iWhatToDraw == "polygon"  ) then

                love.graphics.polygon( "fill", Camera.MapToScreenMultiple( b:getWorldPoints( v:getShape():getPoints() ) ) )

            -- CIRCLES
            elseif ( v:getShape():getType() == "circle" ) and ( iWhatToDraw == "all" or iWhatToDraw == "circle"  ) then

                radius  = v:getShape():getRadius()
                x, y    = v:getShape():getPoint()
                xBody, yBody = b:getPosition()

                -- x, y are coordinates from the center of body, so we offset to match center in screen coordinates
                x = x + xBody
                y = y + yBody
                x, y = Camera.MapToScreen( x, y )
                love.graphics.circle( "fill", x, y, radius )

            -- EDGES
            elseif ( v:getShape():getType() == "edge" ) and ( iWhatToDraw == "all" or iWhatToDraw == "edge"  ) then

                love.graphics.setColor( 255, 0, 0, 200 )
                love.graphics.line( Camera.MapToScreenMultiple( b:getWorldPoints( v:getShape():getPoints() ) ) )

            -- CHAINS
            elseif ( v:getShape():getType() == "chain" ) and ( iWhatToDraw == "all" or iWhatToDraw == "chain"  ) then

                --TODO
            end

            -- We cycle through colors
            red = red + 100
            green = green + math.floor( red / 255 ) * 100
            blue = blue + math.floor( blue / 255 ) * 100
            red = red % 256
            green = green % 256
            blue = blue % 256

        end

    end

end
return Game