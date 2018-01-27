io.stdout:setvbuf('no')

require "src/Application/Global"

local  MenuScreen   = require( "src/CommOp1/Application/Screens/MenuScreen" )

Node = require "src/Math/VertexCover/Node"
VertexCover = require "src/Math/VertexCover/VertexCover"
Vector = require "src/Math/Vector"

nodeA = Node:New( "A", Vector:New( 0, 0 ) )
nodeB = Node:New( "B", Vector:New( 50, 50 ) )
nodeC = Node:New( "C", Vector:New( 80, 20 ) )
nodeO = Node:New( "O", Vector:New( -0, 2890 ) )
nodeD = Node:New( "D", Vector:New( 200, 70 ) )

VertexCover:AddConnection( nodeA, nodeB, VertexCover:Distance( nodeA, nodeB ) )
VertexCover:AddConnection( nodeA, nodeC, VertexCover:Distance( nodeA, nodeC ) )
VertexCover:AddConnection( nodeB, nodeO, VertexCover:Distance( nodeA, nodeO ) )
VertexCover:AddConnection( nodeO, nodeD, VertexCover:Distance( nodeO, nodeD ) )
VertexCover:AddConnection( nodeB, nodeD, VertexCover:Distance( nodeB, nodeD ) )
VertexCover:AddConnection( nodeC, nodeD, VertexCover:Distance( nodeC, nodeD ) )
local result = VertexCover:FindPaths( nodeA, nodeD )
Base:log(#result)
Base:separator()
for i=1, #result do
    Base:separator()
    Base:log( "solution n:" )
    Base:log( i )
    Base:log( "steps:" )
    Base:log( #result[i] )
    for j=1, #result[i] do
        Base:log( result[i][j].mName )
    end
    local sum = VertexCover:ComputePathWeight( result[ i ] )
    Base:log( "sum:" )
    Base:log( sum )
end


-- First setup of my game, called at launch
function love.load( args )

    Manager:PushScreen( MenuScreen:New() )
end


-- Updates the values of my game before drawing at screen
-- Called at each tick of the game before drawing
function love.update( dt )

    Manager:Update( dt )
end



-- The drawing function to draw the full game
function love.draw()

    Manager:Draw()

end


--USER INPUT============================================================================


function love.textinput( iText )
    Manager:TextInput( iText )
end


function love.keypressed( iKey, iScancode, iIsRepeat )
    Manager:KeyPressed( iKey, iScancode, iIsRepeat )
end

function love.keyreleased( iKey, iScancode )
    Manager:KeyReleased( iKey, iScancode )
end


function love.mousemoved( iX, iY )
    Manager:MouseMoved( iX, iY )
end


function  love.mousepressed( iX, iY, iButton, iIsTouch )
    Manager:MousePressed( iX, iY, iButton, iIsTouch )
end


function love.mousereleased( iX, iY, iButton )
    Manager:MouseReleased( iX, iY, iButton )
end


function love.wheelmoved( iX, iY )
    Manager:WheelMoved( iX, iY )
end
