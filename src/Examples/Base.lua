-- This is a base class for a an inheritance example

local Base = {}


-- ==========================================Build/Destroy


function Base:New( iA, iB )

    newBase = {}
    setmetatable( newBase, Base )
    Base.__index = Base

    newBase:BuildBase( iA, iB )

    return  newBase
end


function  Base:BuildBase( iA, iB )

    self.a     = iA
    self.b     = iB

end

-- ==========================================Type


function  Base:Type()
    return "Base"
end


-- ==========================================Update/Draw


function  Base:Update( iDT )
end


function  Base:Draw()
    love.graphics.print( self:Type(), self.a, self.b )
    love.graphics.print( self.a, self.a + 50, self.b )
    love.graphics.print( self.b, self.a + 100, self.b )
end



return  Base