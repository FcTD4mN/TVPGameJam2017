local SystemBase = require( "src/ECS/Systems/SystemBase" )

local  SystemTest2 = {}
setmetatable( SystemTest2, SystemBase )
SystemBase.__index = SystemBase


function  SystemTest2:Initialize()

    self.mEntityGroup = {}

end


function SystemTest2:Requirements()

    local requirements = {}
    table.insert( requirements, "box2d" )
    table.insert( requirements, "sprite" )

    return  unpack( requirements )

end


function SystemTest2:Update( iDT )
    --does nothing
end


function  SystemTest2:Draw( iCamera )

end


-- ==========================================Type


function SystemTest2:Type()
    return "SystemTest2"
end


return  SystemTest2
