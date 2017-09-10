
-- BODY

function  SaveBodyXML( iBody )

    xmlData = "<body "

    x1,y1 = iBody:getPosition()
    xmlData = xmlData .. "type='" .. iBody:getType() .. "' " ..
                        "x1='" .. x1 .. "' " ..
                        "y1='" .. y1 .. "' " ..
                        " >\n"

    fixtures = iBody:getFixtureList()

    for k,v in pairs( fixtures ) do
        xmlData = xmlData .. SaveFixtureXML( v )
    end

    xmlData = xmlData .. "</body>\n"

    return  xmlData

end


function  LoadBodyXML( iNode, iWorld )

    assert( iNode.name == "body" )

    local type  = iNode.attr[ 1 ].value
    local x1    = iNode.attr[ 2 ].value
    local y1    = iNode.attr[ 3 ].value
    print( type )
    print( x1 )
    print( y1 )

    body = love.physics.newBody( iWorld, x1, y1, type )

    for i = 1, #iNode.el do
        fixture = LoadFixtureXML( iNode.el[ i ], body )
    end

    return  body

end


-- FIXTURE


function  SaveFixtureXML( iFixture )

    xmlData = "<fixture "
    xmlData = xmlData .. "friction='" .. iFixture:getFriction() .. "' >\n"

    xmlData = xmlData .. SaveShapeXML( iFixture:getShape() )

    xmlData = xmlData .. "</fixture>\n"


    return  xmlData

end


function  LoadFixtureXML( iNode, iBody )

    assert( iNode.name == "fixture" )
    assert( #iNode.el == 1 ) -- Can only have one shape per fixture

    local fixture = nil
    local friction = iNode.attr[ 1 ].value
    local shape = LoadShapeXML( iNode.el[ 1 ] )

    fixture    = love.physics.newFixture( iBody, shape )
    fixture:setFriction( friction )

    return  fixture

end


-- SHAPE


function  SaveShapeXML( iShape )

    xmlData = "<shape "

    if( iShape:getType() == "polygon" ) then

        xmlData = xmlData .. "type='polygon' " ..
                            " />\n"

    elseif( iShape:getType() == "edge" ) then

        x1,y1, x2,y2 = iShape:getPoints()
        xmlData = xmlData .. "type='edge' " ..
                            "x1='" .. x1 .. "' " ..
                            "y1='" .. y1 .. "' " ..
                            "x2='" .. x2 .. "' " ..
                            "y2='" .. y2 .. "' " ..
                            " />\n"

    end

    return  xmlData

end


function  LoadShapeXML( iNode )

    assert( iNode.name == "shape" )

    type = iNode.attr[ 1 ].value
    local shape = nil

    -- EDGE
    if type == "edge" then

        x1 = iNode.attr[ 2 ].value
        y1 = iNode.attr[ 3 ].value
        x2 = iNode.attr[ 4 ].value
        y2 = iNode.attr[ 5 ].value

        shape    = love.physics.newEdgeShape( x1, y1, x2, y2 )

    -- POLYGON
    elseif type == "polygon" then

        shape    = love.physics.newPolygonShape( 0, 0, 1, 1, 2, 2 )

    -- RECTANGLE
    elseif type == "rectangle" then

        shape    = love.physics.newRectangleShape( 0, 0 )

    end

    return  shape

end


