
local Camera = require "src/Camera/Camera"
local Object = require "src/Objects/Object"

local GrownTree = Object:New( 0, 0, 0, 0, 0, 0, 0, 0 )


-- ==========================================Constructor/Destructor


function GrownTree:New( iWorld, iX, iY )
    local newGrownTree = {}
    setmetatable( newGrownTree, self )
    self.__index = self

    newGrownTree.x = iX
    newGrownTree.y = iY
    newGrownTree.w = 912
    newGrownTree.h = 468

    --inherited values

    newGrownTree.body     = love.physics.newBody( iWorld, iX + newGrownTree.w/2, iY + newGrownTree.h/2, "static" )
    newGrownTree.body:setFixedRotation( true )
    newGrownTree.body:setGravityScale( 0.0 )

    newGrownTree.shape    = love.physics.newPolygonShape(   -newGrownTree.w/2 + 20, newGrownTree.h/2,
                                                            -newGrownTree.w/2 + 20, newGrownTree.h/2-150,
                                                            20, -newGrownTree.h/2 + 50,
                                                            newGrownTree.w/2 - 100, -newGrownTree.h/2 + 50 )

    newGrownTree.fixture  = love.physics.newFixture( newGrownTree.body, newGrownTree.shape )
    newGrownTree.fixture:setFriction( 1.0 )
    newGrownTree.fixture:setUserData( newGrownTree )

    newGrownTree.animations       = {}
    newGrownTree.currentAnimation = 0

    local img = love.graphics.newImage( "resources/Animation/FX/Grande-plante.png" )
    newGrownTree:AddAnimation( img, 16, 24, false, false )

    newGrownTree:PlayAnimation( 1, 1 )

    return newGrownTree
end


-- ==========================================Type


function GrownTree:Type()
    return  "GrownTree"
end


-- ==========================================Update/Draw


function GrownTree:Update( dt )
    self:UpdateObject( dt )
end


function GrownTree:Draw()
    self:DrawObject()
end

return GrownTree