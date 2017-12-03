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
    table.insert( requirements, "direction" )
    table.insert( requirements, "box2d" )
    table.insert( requirements, "animations" )

    return  unpack( requirements )

end

function MakeCrouch( iEntity, iBox2d )
    local box2DComponent = BasicComponents:NewBox2DComponent( iBox2d.mBody:getWorld(), iBox2d.mBody:getX() - iBox2d.mBodyW / 2, iBox2d.mBody:getY() - iBox2d.mBodyH / 2 + iBox2d.mBodyH / 2, 45, iBox2d.mBodyH / 2, "dynamic", true, 1 )
    local stickyShape    = love.physics.newRectangleShape( box2DComponent.mBodyW, box2DComponent.mBodyH )
    local fixture  = love.physics.newFixture( box2DComponent.mBody, stickyShape )
    fixture:setFriction( 1.0 )
    fixture:setUserData( iEntity )
    iEntity:RemoveComponentByName( "box2d" )
    iEntity:AddComponent( box2DComponent )
    iBox2d.mBody:destroy()

    return box2DComponent
end

function MakeNormal( iEntity, iBox2d )
    local box2DComponent = BasicComponents:NewBox2DComponent( iBox2d.mBody:getWorld(), iBox2d.mBody:getX() - iBox2d.mBodyW / 2, iBox2d.mBody:getY() - iBox2d.mBodyH / 2 - iBox2d.mBodyH / 2, 45, iBox2d.mBodyH * 2, "dynamic", true, 1 )
    local stickyShape    = love.physics.newRectangleShape( box2DComponent.mBodyW, box2DComponent.mBodyH )
    local fixture  = love.physics.newFixture( box2DComponent.mBody, stickyShape )
    fixture:setFriction( 1.0 )
    fixture:setUserData( iEntity )
    iEntity:RemoveComponentByName( "box2d" )
    iEntity:AddComponent( box2DComponent )
    iBox2d.mBody:destroy()

    return box2DComponent
end

function SetAnimation( iAnimations, iIndex )
    if iAnimations.mCurrentAnimationIndex ~= iIndex then
        iAnimations.mCurrentAnimationIndex = iIndex
        iAnimations.mAnimations[ iAnimations.mCurrentAnimationIndex ].mTime = 0
        iAnimations.mAnimations[ iAnimations.mCurrentAnimationIndex ].mIsPaused = false
    end
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
        if( GetObjectIndexInTable( userinput.mActions, "crouch" ) > -1 ) then
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
        if( GetObjectIndexInTable( userinput.mActions, "dash" ) > -1 or entity:GetTagByName( "isDashing" ) == "1" ) then
            if entity:GetTagByName( "isDead" ) == "0" and entity:GetTagByName( "isCrouch" ) == "0" and entity:GetTagByName( "didDash" ) == "0" then
                entity:AddTag( "isDashing" )
                velX = dashSpeed
                velY = 0.0
            end
        end

        --jump
        if( GetObjectIndexInTable( userinput.mActions, "jump" ) > -1 ) then
            if entity:GetTagByName( "isDead" ) == "0" and entity:GetTagByName( "isInAir" ) == "0" and entity:GetTagByName( "isCrouch" ) == "0" and entity:GetTagByName( "isDashing" ) == "0" then
                velY = -550
                entity:AddTag( "isInAir" )
            end
        end

        if( GetObjectIndexInTable( userinput.mActions, "doublejump" ) > -1 ) then
            if entity:GetTagByName( "isDead" ) == "0" and
               entity:GetTagByName( "isInAir" ) == "1" and
               entity:GetTagByName( "isCrouch" ) == "0" and
               entity:GetTagByName( "isDashing" ) == "0" and
               entity:GetTagByName( "didDoubleJump" ) == "0"
               then
                velY = -400
                entity:AddTag( "didDoubleJump" )
            end
        end

        if( GetObjectIndexInTable( userinput.mActions, "triplejump" ) > -1 ) then
            if entity:GetTagByName( "isDead" ) == "0" and
               entity:GetTagByName( "isInAir" ) == "1" and
               entity:GetTagByName( "isCrouch" ) == "0" and
               entity:GetTagByName( "isDashing" ) == "0" and
               entity:GetTagByName( "didDoubleJump" ) == "1" and
               entity:GetTagByName( "didTripleJump" ) == "0"
               then
                velY = -400
                entity:AddTag( "didTripleJump" )
            end
        end

        -- Left vs Right
        if( GetObjectIndexInTable( userinput.mActions, "moveright" ) > -1 or entity:GetTagByName( "isAutoRun" ) == "1" ) then
            direction.mDirectionH = "right";
            if entity:GetTagByName( "isDead" ) == "0" and entity:GetTagByName( "isDashing" ) == "0" then
                entity:AddTag( "isMoving" )
                direction.mDirectionH = "right";
            end
        elseif( GetObjectIndexInTable( userinput.mActions, "moveleft" ) > -1 ) then
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
            SetAnimation( animations, "death" )
        elseif entity:GetTagByName( "isDashing" ) == "1" then
            SetAnimation( animations, "dash" )
        elseif entity:GetTagByName( "isInAir" ) == "1" then
            SetAnimation( animations, "fall" ) --TODO: use jump/fall/land )
        elseif entity:GetTagByName( "isCrouch" ) == "1" then
            if entity:GetTagByName( "isMoving" ) == "1" then
                SetAnimation( animations, "crawl" )
            else
                SetAnimation( animations, "crouch" )
            end
        elseif entity:GetTagByName( "isMoving" ) == "1" then
            SetAnimation( animations, "move" )
        else
            SetAnimation( animations, "idle" )
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
