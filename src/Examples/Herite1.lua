Base = require( "src/Examples/Base" )



-- This is a way cleaner way of inheriting from a base
local Herite1 = {}
setmetatable( Herite1, Base )
Herite1.__index = Herite1


-- ==========================================Build/Destroy


function Herite1:New( iA, iB, iC )

    newHerite1 = {}
    setmetatable( newHerite1, Herite1 )
    Herite1.__index = Herite1

    newHerite1:BuildHerite1( iA, iB, iC )

    return  newHerite1
end


function  Herite1:BuildHerite1( iA, iB, iC )

    self:BuildBase( iA, iB ) -- tSuperClass style constructor call
    self.c = iC

end

-- ==========================================Type


function  Herite1:Type()
    return "Herite1"
end


-- ==========================================Update/Draw


function  Herite1:Update( iDT )
end


function  Herite1:Draw()
    love.graphics.print( self:Type(), self.a, self.b )
    love.graphics.print( self.a, self.a + 50, self.b )
    love.graphics.print( self.b, self.a + 100, self.b )
    love.graphics.print( self.c, self.a + 150, self.b )
end



return  Herite1