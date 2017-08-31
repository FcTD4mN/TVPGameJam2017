
local Terrain = {}


-- ==========================================Build/Destroy


function Terrain.Initialize( iWorld )

    Terrain.body = love.physics.newBody( iWorld, 0, 0, "static" )
    Terrain.body:setFixedRotation( true )

end


function  Terrain.Finalize()
    Terrain.body.destroy()
end


-- ==========================================Type


function  Terrain.Type()
    return "Terrain"
end


-- ==========================================Terrain functions


function Terrain.AddEdge( iX, iY, iX2, iY2 )
    newShape = love.physics.newEdgeShape( iX, iY, iX2, iY2 )
    fixture  = love.physics.newFixture( Terrain.body, newShape )
    fixture:setFriction( 0.33 )
    fixture:setUserData( Terrain )
end


-- ==========================================Collide CB


function  Terrain.Collide( iCollider )
    -- do nothing
end

return Terrain