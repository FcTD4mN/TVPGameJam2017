
function  SaveBodyXML( iBody )

    xmlData = "<body "

    x1,y1 = iBody:getPosition()
    xmlData = xmlData .. "type='" .. iBody:getType() .. "' " ..
                        "x1='" .. x1 .. "' " ..
                        "y1='" .. y1 .. "' " ..
                        " >\n"

    fixtures = iBody:getFixtureList()

    for k,v in pairs( fixtures ) do
        xmlData = xmlData .. SaveShapeXML( v:getShape() )
    end

    xmlData = xmlData .. "</body>\n"

    return  xmlData

end


function  SaveShapeXML( iShape )

    xmlData = "<shape "

    if( iShape:getType() == "polygon" ) then

        xmlData = xmlData .. "type='polygon' " ..
                            "friction='" .. iShape:getFriction() .. "' >\n"

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


