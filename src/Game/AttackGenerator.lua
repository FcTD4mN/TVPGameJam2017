local Fireball      = require "src/Objects/Projectiles/Fireball"
local Waterball     = require "src/Objects/Projectiles/Waterball"

-- Not local, this one is shared through the whole application
AttackGenerator = {
    uniqueProjectiles = {}
}

function AttackGenerator:Initialize( world )

    AttackGenerator.world = world;
    AttackGenerator.images = {};
    table.insert( AttackGenerator.images, love.graphics.newImage( "resources/Animation/FX/boule_feu_2.png" ) )
    table.insert( AttackGenerator.images, love.graphics.newImage( "resources/Animation/FX/boule_feu_suite.png" ) )
    table.insert( AttackGenerator.images, love.graphics.newImage( "resources/Animation/FX/jet_eau_debut.png" ) )
    table.insert( AttackGenerator.images, love.graphics.newImage( "resources/Animation/FX/jet_eau_suite.png" ) )
    table.insert( AttackGenerator.images, love.graphics.newImage( "resources/Animation/FX/boule_eau_2.png" ) )
end


function AttackGenerator:GenerateAttack( x, y, type, iVel, iDirection )

    if type == "Fireball"  and  AttackGenerator.AttackAlreadyExists( "Fireball") == false  then

        local fire =  Fireball:New( world, x, y , iVel )
        fire:AddAnimation( AttackGenerator.images[ 1 ] )
        fire:PlayAnimation( 1, 0 )
        table.insert( AttackGenerator.uniqueProjectiles, fire )

        return  fire

    elseif type == "Waterball"  and  AttackGenerator.AttackAlreadyExists( "Waterball") == false then

        local water =  Waterball:New( world, x, y , iVel, iDirection )
        water:AddAnimation( AttackGenerator.images[ 5 ] )
        water:PlayAnimation( 1, 0 )
        table.insert( AttackGenerator.uniqueProjectiles, water )

        return  water

    end

end


--TODO : add a queued attack


function  AttackGenerator.AttackAlreadyExists( iType )

    for k,v in pairs( AttackGenerator.uniqueProjectiles ) do
        if( v:Type() == iType ) then
            if(  v.mNeedDestroy == false ) then
                return  true
            else
                table.remove( AttackGenerator.uniqueProjectiles, k )
            end
        end
    end

    return  false

end


return AttackGenerator
