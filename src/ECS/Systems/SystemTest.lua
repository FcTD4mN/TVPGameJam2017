local SystemBase = require( "src/ECS/Systems/SystemBase" )

local  SystemTest = {}
setmetatable( SystemTest, SystemBase )
SystemBase.__index = SystemBase


function  SystemTest:Initialize()

    self.mEntityGroup = {}

end


function SystemTest:Requirements()

    local requirements = {}
    table.insert( requirements, "box2d" )
    table.insert( requirements, "sprite" )

    return  unpack( requirements )

end


function SystemTest:Update( iDT )
    --does nothing
end


function  SystemTest:Draw( iCamera )

end


-- ==========================================Type


function SystemTest:Type()
    return "SystemTest"
end


return  SystemTest
