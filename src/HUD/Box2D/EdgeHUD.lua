
local Rectangle   =   require( "src/Math/Rectangle" )


local EdgeHUD = {}


function EdgeHUD:New( iFixture )
    newEdgeHUD = {}
    setmetatable( newEdgeHUD, EdgeHUD )
    EdgeHUD.__index = EdgeHUD

    newEdgeHUD.mBody = iFixture:getBody()
    newEdgeHUD.mFixture = iFixture
    newEdgeHUD.mShape = iFixture:getShape()
    assert( newEdgeHUD.mShape:getType() == "edge" )

    return  newEdgeHUD

end


function EdgeHUD:Destroy()

    self.mFixture:destroy()

end


function EdgeHUD:Type()
    return  "EdgeHUD"
end


function EdgeHUD:Draw( iCamera )

    local handleSize = 10
    x1, y1, x2, y2 = iCamera:MapToScreenMultiple( self.mBody:getWorldPoints( self.mShape:getPoints() ) )

    love.graphics.rectangle( "line", x1 - handleSize/2, y1 - handleSize/2, handleSize, handleSize )
    love.graphics.rectangle( "line", x2 - handleSize/2, y2 - handleSize/2, handleSize, handleSize )

end


-- ====================


function  EdgeHUD:GetHandleNumberAtPos( iX, iY, iCamera )

    local handleSize = 10
    x1, y1, x2, y2 = iCamera:MapToScreenMultiple( self.mBody:getWorldPoints( self.mShape:getPoints() ) )

    local rect1 = Rectangle:New( x1 - handleSize/2, y1 - handleSize/2, handleSize, handleSize )
    local rect2 = Rectangle:New( x2 - handleSize/2, y2 - handleSize/2, handleSize, handleSize )

    if rect1:ContainsPoint( iX, iY ) then
        return  1
    elseif rect2:ContainsPoint( iX, iY ) then
        return  2
    end

    return  0
end


function  EdgeHUD:MoveHandleAtPos( iHandleIndex, iDestX, iDestY )

    x1, y1, x2, y2 = self.mBody:getWorldPoints( self.mShape:getPoints() )

    if iHandleIndex == 1 then
        self.mShape = love.physics.newEdgeShape( iDestX, iDestY, x2, y2 )
    elseif iHandleIndex == 2 then
        self.mShape = love.physics.newEdgeShape( x1, y1, iDestX, iDestY )
    end

    self.mFixture:destroy()
    self.mFixture = love.physics.newFixture( self.mBody, self.mShape )

end


return  EdgeHUD



