local SystemBase = require( "src/ECS/Systems/SystemBase" )
local Shortcuts = require( "src/Application/Shortcuts" )

local  HeroController = {}
setmetatable( HeroController, SystemBase )
SystemBase.__index = SystemBase


function  HeroController:Initialize()

    self.mEntityGroup = {}

end


function HeroController:Requirements()

    local requirements = {}
    table.insert( requirements, "userinput" )
    table.insert( requirements, "box2d" )

    return  unpack( requirements )

end


function HeroController:Update( iDT )

    for i = 1, #self.mEntityGroup do

        local entity = self.mEntityGroup[ i ]
        local userinput = entity:GetComponentByName( "userinput" )
        local box2d     = entity:GetComponentByName( "box2d" )

        local velX = 0.0
        local velY = 0.0

        vx, velY = box2d.mBody:getLinearVelocity()
        if( GetObjectIndexInTable( userinput.mActions, "moveright" ) > -1 ) then
            velX = velX + 300
        end

        if( GetObjectIndexInTable( userinput.mActions, "moveleft" ) > -1 ) then
            velX = velX - 300
        end

        if( GetObjectIndexInTable( userinput.mActions, "jump" ) > -1
            and entity:GetTagByName( "canJump" ) == 1
            and entity:GetTagByName( "isJumping" ) == 0 ) then

            entity:AddTag( "isJumping" )
            velY = velY - 400

        end

        box2d.mBody:setLinearVelocity( velX, velY )

    end


end


function  HeroController:Draw( iCamera )

end


-- ==========================================Type


function HeroController:Type()
    return "HeroController"
end


return  HeroController
