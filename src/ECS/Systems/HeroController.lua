local SystemBase = require( "src/ECS/Systems/SystemBase" )
local Shortcuts = require( "src/Application/Shortcuts" )

local  HeroController = {}
setmetatable( HeroController, SystemBase )
SystemBase.__index = SystemBase


function  HeroController:Initialize()

    self.mEntityGroup = {}

end


function HeroController:IncomingEntity( iEntity )

    -- Here we decide if we are interested by iEntity or not
    -- =====================================================

    local userinput = iEntity:GetComponentByName( "userinput" )
    local box2d = iEntity:GetComponentByName( "box2d" )
    local direction = iEntity:GetComponentByName( "direction" )
    local animations = iEntity:GetComponentByName( "animations" )

    if box2d and userinput and direction and animations then
        table.insert( self.mEntityGroup, iEntity )
        table.insert( iEntity.mObserverSystems, self )
    end

end

--TODO: find a way to move some MakeCrouch and MakeNormal equivalent in Box2dComponent or something like this

function MakeCrouch( iEntity, iBox2d )
    local box2DComponent = Box2DComponent:New( iBox2d.mBody:getWorld(), iBox2d.mBody:getX() - iBox2d.mBodyW / 2, iBox2d.mBody:getY() - iBox2d.mBodyH / 2 + iBox2d.mBodyH / 2, 45, iBox2d.mBodyH / 2, "dynamic", true, 1, 19 )
    local stickyShape    = love.physics.newRectangleShape( box2DComponent.mBodyW, box2DComponent.mBodyH )
    local fixture  = love.physics.newFixture( box2DComponent.mBody, stickyShape )
    fixture:setFriction( 1.0 )
    fixture:setCategory( 2 ) --shape detecting collision with decor
    fixture:setUserData( iEntity )
    iEntity:RemoveComponentByName( "box2d" )
    iEntity:AddComponent( box2DComponent )
    iBox2d.mBody:destroy()

    return box2DComponent
end

function MakeNormal( iEntity, iBox2d )
    local box2DComponent = Box2DComponent:New( iBox2d.mBody:getWorld(), iBox2d.mBody:getX() - iBox2d.mBodyW / 2, iBox2d.mBody:getY() - iBox2d.mBodyH / 2 - iBox2d.mBodyH / 2, 45, iBox2d.mBodyH * 2, "dynamic", true, 1, 19 )
    local stickyShape    = love.physics.newRectangleShape( box2DComponent.mBodyW, box2DComponent.mBodyH )
    local fixture  = love.physics.newFixture( box2DComponent.mBody, stickyShape )
    fixture:setFriction( 1.0 )
    fixture:setCategory( 2 ) --shape detecting collision with decor
    fixture:setUserData( iEntity )
    iEntity:RemoveComponentByName( "box2d" )
    iEntity:AddComponent( box2DComponent )
    iBox2d.mBody:destroy()

    return box2DComponent
end

function HeroController:Update( iDT )

    for i = 1, #self.mEntityGroup do

        local entity = self.mEntityGroup[ i ]
        local userinput = entity:GetComponentByName( "userinput" )
        local direction = entity:GetComponentByName( "direction" )
        local box2d     = entity:GetComponentByName( "box2d" )
        local animations= entity:GetComponentByName( "animations" )

        local velX = 0.0
        local velY = 0.0
        vX, velY = box2d.mBody:getLinearVelocity()
        local crouchSpeed = 150;
        local normalSpeed = 300;
        local dashSpeed = 2000;

        velX = normalSpeed

        --crouch
        if( userinput.mActions[ "crouch" ] ~= nil ) then
            --Not allowing crouch if dashing or in air
            if entity:GetTagByName( "isDead" ) == "0" and entity:GetTagByName( "isInAir" ) == "0" and entity:GetTagByName( "isDashing" ) == "0" then
                if entity:GetTagByName( "isCrouch" ) == "0" then
                    entity:AddTag( "isCrouch" )
                    box2d = MakeCrouch( entity, box2d )
                end
                velX = crouchSpeed
            elseif entity:GetTagByName( "isCrouch" ) == "1" then
                entity:RemoveTag( "isCrouch" )
                box2d = MakeNormal( entity, box2d )
            end
        elseif entity:GetTagByName( "isCrouch" ) == "1" then
            entity:RemoveTag( "isCrouch" )
            box2d = MakeNormal( entity, box2d )
        end

        --dash
        if( userinput.mActions[ "dash" ] ~= nil or entity:GetTagByName( "isDashing" ) == "1" ) then
            if entity:GetTagByName( "isDead" ) == "0" and entity:GetTagByName( "isCrouch" ) == "0" and entity:GetTagByName( "didDash" ) == "0" then
                entity:AddTag( "isDashing" )
                velX = dashSpeed
                velY = 0.0
            end
        end

        --jump
        if( userinput.mActions[ "jump" ] ~= nil ) then
            if entity:GetTagByName( "isDead" ) == "0" and entity:GetTagByName( "isInAir" ) == "0" and entity:GetTagByName( "isCrouch" ) == "0" and entity:GetTagByName( "isDashing" ) == "0" then
                velY = -460
                entity:AddTag( "isInAir" )
            end
        end

        if( userinput.mActions[ "doublejump" ] ~= nil ) then
            if entity:GetTagByName( "isDead" ) == "0" and
               entity:GetTagByName( "isInAir" ) == "1" and
               entity:GetTagByName( "isCrouch" ) == "0" and
               entity:GetTagByName( "isDashing" ) == "0" and
               entity:GetTagByName( "didDoubleJump" ) == "0"
               then
                velY = -520
                entity:AddTag( "didDoubleJump" )
            end
        end

        if( userinput.mActions[ "triplejump" ] ~= nil ) then
            if entity:GetTagByName( "isDead" ) == "0" and
               entity:GetTagByName( "isInAir" ) == "1" and
               entity:GetTagByName( "isCrouch" ) == "0" and
               entity:GetTagByName( "isDashing" ) == "0" and
               entity:GetTagByName( "didDoubleJump" ) == "1" and
               entity:GetTagByName( "didTripleJump" ) == "0"
               then
                velY = -530
                entity:AddTag( "didTripleJump" )
            end
        end

        -- Left vs Right
        if( userinput.mActions[ "moveright" ] ~= nil or entity:GetTagByName( "isAutoRun" ) == "1" ) then
            direction.mDirectionH = "right";
            if entity:GetTagByName( "isDead" ) == "0" and entity:GetTagByName( "isDashing" ) == "0" then
                entity:AddTag( "isMoving" )
                direction.mDirectionH = "right";
            end
        elseif( userinput.mActions[ "moveleft" ] ~= nil ) then
            if entity:GetTagByName( "isDead" ) == "0" and entity:GetTagByName( "isDashing" ) == "0" then
                entity:AddTag( "isMoving" )
                direction.mDirectionH = "left";
            end
        else
            entity:RemoveTag( "isMoving" )
            if entity:GetTagByName( "isDashing" ) == "0" then
                velX = 0.0
            end
        end

        if direction.mDirectionH == "left" then
            velX = -velX
        end

        if( entity:GetTagByName( "isDead" ) == "1" ) then
            velX = 0.0
            velY = 0.0
        end

        box2d.mBody:setLinearVelocity( velX, velY )

        ---------------------------------------------------------------------------Animations

        if( entity:GetTagByName( "isDead" ) == "1" ) then
            animations:Play( "death" )
        elseif entity:GetTagByName( "isDashing" ) == "1" then
            animations:Play( "dash" )
        elseif entity:GetTagByName( "isInAir" ) == "1" then
            animations:Play( "fall" ) --TODO: use jump/fall/land )
        elseif entity:GetTagByName( "isCrouch" ) == "1" then
            if entity:GetTagByName( "isMoving" ) == "1" then
                animations:Play( "crawl" )
            else
                animations:Play( "crouch" )
            end
        elseif entity:GetTagByName( "isMoving" ) == "1" then
            animations:Play( "move" )
        else
            animations:Play( "idle" )
        end
    end
end


function  HeroController:Draw( iCamera )

end


-- ==========================================Type


function HeroController:Type()
    return "HeroController"
end


return  HeroController
