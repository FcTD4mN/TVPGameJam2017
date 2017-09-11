require( "src/Base/Utilities/Base" )
-- BODY

function  SaveBodyXML( iBody )

    xmlData = "<body "

    x1,y1 = iBody:getPosition()

    xmlData = xmlData .. "type='" .. iBody:getType() .. "' " ..
                        "x1='" .. x1 .. "' " ..
                        "y1='" .. y1 .. "' " ..
                        "gravity='" .. iBody:getGravityScale() .. "' " ..
                        "fixedrotation='" .. tostring( iBody:isFixedRotation() ) .. "' " ..
                        " >\n"

    fixtures = iBody:getFixtureList()

    for k,v in pairs( fixtures ) do
        xmlData = xmlData .. SaveFixtureXML( v )
    end

    xmlData = xmlData .. "</body>\n"

    return  xmlData

end


function  LoadBodyXML( iNode, iWorld, iObject )

    assert( iNode.name == "body" )

    local type          = iNode.attr[ 1 ].value
    local x1            = iNode.attr[ 2 ].value
    local y1            = iNode.attr[ 3 ].value
    local gravity       = iNode.attr[ 4 ].value
    local fixedrotation = iNode.attr[ 5 ].value

    body = love.physics.newBody( iWorld, x1, y1, type )
    body:setGravityScale( gravity )
    body:setFixedRotation( fixedrotation )

    for i = 1, #iNode.el do
        fixture = LoadFixtureXML( iNode.el[ i ], body, iObject )
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


function  LoadFixtureXML( iNode, iBody, iObject )

    assert( iNode.name == "fixture" )
    assert( #iNode.el == 1 ) -- Can only have one shape per fixture

    local fixture = nil
    local friction = iNode.attr[ 1 ].value
    local shape = LoadShapeXML( iNode.el[ 1 ] )

    fixture    = love.physics.newFixture( iBody, shape )
    fixture:setFriction( friction )
    fixture:setUserData( iObject )

    return  fixture

end


-- SHAPE


function  SaveShapeXML( iShape )

    xmlData = "<shape "

    if( iShape:getType() == "polygon" ) then

        xmlData = xmlData .. "type='polygon' "

        local points = Pack( iShape:getPoints() )
        for i = 1, #points, 2 do
            x = points[ i ]
            y = points[ i + 1 ]
            xmlData = xmlData .. "x" .. i .. "='" .. x .. "' " ..
                                "y" .. i .. "='" .. y .. "' "
        end

        xmlData = xmlData .. " />\n"

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

        local points = {}
        -- -1 because first attribute is type
        for i = 2, #iNode.attr do
            table.insert( points, iNode.attr[ i ].value )
        end
        shape    = love.physics.newPolygonShape( unpack( points ) )

    -- RECTANGLE
    elseif type == "rectangle" then

        shape    = love.physics.newRectangleShape( 0, 0 )

    end

    return  shape

end


