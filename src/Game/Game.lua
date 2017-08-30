local Background            = require "src/Image/Background"
local Tree                  = require "src/Objects/Environnement/Tree"
local Singe                 = require "src/Objects/Heros/Singe"
local Lapin                 = require "src/Objects/Heros/Lapin"
local BigImage              = require "src/Image/BigImage"
local AttackGenerator       = require "src/Game/AttackGenerator"
local ImageShapeComputer    = require "src/Image/ImageShapeComputer"
local BabyTree              = require "src/Objects/Environnement/BabyTree"
local GrownTree             = require "src/Objects/Environnement/GrownTree"
local ObjectPool            = require "src/Objects/ObjectPool"



local Game = {}

function beginContact( a, b, coll )
    if not coll:isTouching() then
        return
    end

    -- TODO: a:getUserData():Collision( b:getUserData() )    so that we can have behaviours defined in each classes instead of everything here

    if a:getUserData() == nil or b:getUserData() == nil then
        return
    end

    if a:getUserData():Type() == "BabyTree" and b:getUserData():Type() == "Fireball" then
        local baseTree = a:getUserData()
        baseTree:Destroy()
    end
    if b:getUserData():Type() == "BabyTree" and a:getUserData():Type() == "Fireball" then
        local baseTree = b:getUserData()
        baseTree:Destroy()
    end

    if a:getUserData():Type() == "Fireball" then
        local fireball = a:getUserData()
        fireball:Destroy()
    end
    if b:getUserData():Type() == "Fireball" then
        local fireball = b:getUserData()
        fireball:Destroy()
    end

    if a:getUserData():Type() == "Waterball" then
        local waterball = a:getUserData()
        waterball:Destroy()
    end
    if b:getUserData():Type() == "Waterball" then
        local waterball = b:getUserData()
        waterball:Destroy()
    end

    -- if a:getUserData():Type() == "Tree" and b:getUserData():Type() == "Fireball" then
    --     a:getUserData():Burn()
    --     --b:Destroy()
    --     hero1.attack:Destroy()
    --     hero1.attack = nil
    -- end
    -- if a:getUserData():Type() == "Fireball" and b:getUserData():Type() == "Tree" then
    --     b:getUserData():Burn()
    --     hero1.attack:Destroy()
    --     hero1.attack = nil
    -- end
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
    world:setCallbacks(beginContact, endContact, preSolve, postSolve)

    music = love.audio.newSource( "resources/Audio/Music/Enjeuloop.mp3", "stream" )
    music:setLooping( true )

    hero1               =  Singe:New( world, 1000, 200 )
    hero2               =  Lapin:New( world, 800, 50 )
    local tree          =  Tree:New( world, 1200, 50 )
    local growingTree   =  BabyTree:New( world, 600, 500 )

    ObjectPool.AddObject( hero1 )
    ObjectPool.AddObject( hero2 )
    ObjectPool.AddObject( tree )
    ObjectPool.AddObject( growingTree )

    imageShapeComputer = ImageShapeComputer:New( "resources/Images/Backgrounds/Final/TERRAIN.png", 20 )
    Game:BuildTerrainShape()

    colorBackground = BigImage:New( "resources/Images/Backgrounds/Final/GRADIENT.png", 500 )
    backgrounds = {}
    foregrounds = {}
    table.insert( backgrounds, Background:New( "resources/Images/Backgrounds/Background3000x720.png", 0, 0, 0 ) )
    terrain = Background:New( "resources/Images/Backgrounds/Final/TERRAIN.png", 0, 0, 0 )
    table.insert( foregrounds, Background:New( "resources/Images/Backgrounds/Foreground3000x720.png", 0, 0 , -1 ) )


    --The wall to not fall in infinity
    floor = {}
    floor.body = love.physics.newBody( world, 0, 0, "static" )
    floor.shape = love.physics.newRectangleShape( 10, 3000 )
    floor.fixture = love.physics.newFixture( floor.body, floor.shape )
    floor.fixture:setFriction( 1.0 )

    -- love.audio.play( music )
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

    self:DEBUGWorldHITBOXESDraw()

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

    ObjectPool.Update( dt )
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



function Game:DEBUGWorldHITBOXESDraw()
    love.graphics.setColor( 255, 0, 0, 125 )

    allBodies = world:getBodyList()

    for a, b in pairs( allBodies ) do

        fixtures = b:getFixtureList()
        for k,v in pairs( fixtures ) do

            if( v:getShape():getType() == "polygon" ) then
                love.graphics.polygon( "fill", Camera.MapToScreenMultiple( b:getWorldPoints( v:getShape():getPoints() ) ) )
            elseif ( v:getShape():getType() == "circle" ) then
                radius  = v:getShape():getRadius()
                x, y    = v:getShape():getPoint()
                xBody, yBody = b:getPosition()

                -- x, y are coordinates from the center of body, so we offset to match center in screen coordinates
                x = x + xBody
                y = y + yBody
                x, y = Camera.MapToScreen( x, y )
                love.graphics.circle( "fill", x, y, radius )
            elseif ( v:getShape():getType() == "edge" ) then
                --TODO
            elseif ( v:getShape():getType() == "chain" ) then
                --TODO
            end

        end

    end

end
return Game