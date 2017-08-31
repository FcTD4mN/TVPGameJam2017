local Fireball  = require "src/Objects/Projectiles/Fireball"
local Waterball  = require "src/Objects/Projectiles/Waterball"

local AttackGenerator = {}

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
    if type == "fireball" then
        local fire =  Fireball:New( world, x, y , iVel )
        fire:AddAnimation( AttackGenerator.images[ 1 ] )
        fire:PlayAnimation( 1, 0 )
        return  fire
    elseif type == "waterball" then
        local water =  Waterball:New( world, x, y , iVel, iDirection )
        water:AddAnimation( AttackGenerator.images[ 5 ] )
        water:PlayAnimation( 1, 0 )
        return  water
    end
end

return AttackGenerator