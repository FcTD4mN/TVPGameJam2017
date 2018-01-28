local SystemBase = require( "src/ECS/Systems/SystemBase" )

local  GUITopBarDrawer = {}
setmetatable( GUITopBarDrawer, SystemBase )
SystemBase.__index = SystemBase


function  GUITopBarDrawer:Initialize()

    self.mEntityGroup = {}

end


function GUITopBarDrawer:IncomingEntity( iEntity )

    -- Here we decide if we are interested by iEntity or not
    -- =====================================================

end


function GUITopBarDrawer:Update( iDT )

end


function  GUITopBarDrawer:Draw( iCamera )

    
    love.graphics.push()
    love.graphics.origin()

    local barWidth = 500
    local barHeight = 20

    local x, y = love.graphics.getWidth()/2 - barWidth/2, 10

    local communistSize = barWidth * gCommunistCount / gTotalCount
    love.graphics.setColor( 255,10,10)
    love.graphics.rectangle( "fill", x, y, communistSize, barHeight )

    local neutralSize = barWidth * gNeutralCount / gTotalCount
    love.graphics.setColor( 200,200,200)
    love.graphics.rectangle( "fill", x+communistSize, y, neutralSize, barHeight )

    local capitalistSize = barWidth * gCapitalistCount / gTotalCount
    love.graphics.setColor( 50,50,255)
    love.graphics.rectangle( "fill", x+communistSize + neutralSize, y, capitalistSize, barHeight )


    local font = love.graphics.newFont( 14 )
    love.graphics.setFont(font)

    love.graphics.setColor( 0,0,0)
    love.graphics.print( gCommunistCount,     x,                  10 + barHeight )
    love.graphics.print( gNeutralCount,       x + barWidth/2 - 5, 10 + barHeight )
    love.graphics.print( gCapitalistCount,    x+barWidth - 20,    10 + barHeight )

    local font = love.graphics.newFont( 12 )
    love.graphics.setFont(font)
    love.graphics.setColor( 255,255,255)
    love.graphics.print( gCommunistCount,     x,                  10 + barHeight )
    love.graphics.print( gNeutralCount,       x + barWidth/2 - 5, 10 + barHeight )
    love.graphics.print( gCapitalistCount,    x+barWidth - 20,    10 + barHeight )

    love.graphics.pop()

end


-- ==========================================Type


function GUITopBarDrawer:Type()
    return "GUITopBarDrawer"
end


return  GUITopBarDrawer
