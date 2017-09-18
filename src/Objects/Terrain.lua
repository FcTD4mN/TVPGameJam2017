require( "src/Base/Utilities/XML" )

local Terrain = {}


-- ==========================================Build/Destroy


function Terrain.Initialize( iWorld )

    Terrain.body = love.physics.newBody( iWorld, 0, 0, "static" )
    Terrain.body:setFixedRotation( true )
    Terrain.lastestEdgeX = nil
    Terrain.lastestEdgeY = nil

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
    fixture:setFriction( 1.0 )
    fixture:setUserData( Terrain )

    Terrain.lastestEdgeX = iX2
    Terrain.lastestEdgeY = iY2
end


function Terrain.AppendEdgeToPrevious( iX, iY, iRule )

    if( Terrain.lastestEdgeX == nil ) or Terrain.lastestEdgeY == nil then
        Terrain.lastestEdgeX = iX
        Terrain.lastestEdgeY = iY
        return
    end

    if iRule == "horizontal" then
        iY = Terrain.lastestEdgeY
    elseif iRule == "vertical" then
        iX = Terrain.lastestEdgeX
    end

    newShape = love.physics.newEdgeShape( Terrain.lastestEdgeX, Terrain.lastestEdgeY, iX, iY )
    fixture  = love.physics.newFixture( Terrain.body, newShape )
    fixture:setFriction( 1.0 )
    fixture:setUserData( Terrain )

    Terrain.lastestEdgeX = iX
    Terrain.lastestEdgeY = iY
end


function Terrain.CutEdgeAppending()

    Terrain.lastestEdgeX = nil
    Terrain.lastestEdgeY = nil

end


function Terrain.RemoveLastSegment()

    fixtures = Terrain.body:getFixtureList()

    if #fixtures >= 1 then
        fixtures[ 1 ]:destroy()
        Terrain.CutEdgeAppending()
    end

end


-- ==========================================Collide CB


function  Terrain.Collide( iCollider )
    -- do nothing
end


-- ==========================================XML IO


function  Terrain.SaveTerrainXML()

    xmlData = "<terrain>\n"

    xmlData = xmlData .. SaveBodyXML( Terrain.body )

    xmlData = xmlData .. "</terrain>\n"

    return  xmlData

end


function  Terrain.LoadTerrainXML( iNode, iWorld )

    assert( iNode.name == "terrain" )

    Terrain.body = LoadBodyXML( iNode.el[ 1 ], iWorld )
    Terrain.body:setFixedRotation( true )
    Terrain.lastestEdgeX = nil
    Terrain.lastestEdgeY = nil

end


return Terrain
