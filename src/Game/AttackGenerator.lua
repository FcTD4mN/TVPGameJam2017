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

function AttackGenerator:GenerateAttack( x, y, type, iVel )
    if type == "fireball" then
        fire =  Fireball:New( world, x, y , iVel )
        fire:AddAnimation( AttackGenerator.images[ 1 ] )
        fire:SetCurrentAnimation( 1 )
        return  fire
    elseif type == "waterball" then
        water =  Waterball:New( world, x, y , iVel )
        water:AddAnimation( AttackGenerator.images[ 5 ] )
        water:SetCurrentAnimation( 1 )
        return  water
    end
end

return AttackGenerator