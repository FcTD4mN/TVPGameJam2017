local AttackGenerator = {}

function AttackGenerator:Initialize( world )
    local newAttackGenerator = {}
    setmetatable( newAttackGenerator, self )
    self.__index = self

    newAttackGenerator.world = world;
    newAttackGenerator.images = {};
    table.insert( newAttackGenerator.images, love.graphics.newImage( "resources/Animation/FX/boule_feu_debut.png" ) )
    table.insert( newAttackGenerator.images, love.graphics.newImage( "resources/Animation/FX/boule_feu_suite.png" ) )
    table.insert( newAttackGenerator.images, love.graphics.newImage( "resources/Animation/FX/jet_eau_debut.png" ) )
    table.insert( newAttackGenerator.images, love.graphics.newImage( "resources/Animation/FX/jet_eau_suite.png" ) )
end

function AttackGenerator:GenerateAttack( x, y, type )
    if type == 0 then --fireball
        --todo : insert fire ball
    elseif type == 1 then --waterball
        --todo : insert water ball
    end
end

return AttackGenerator