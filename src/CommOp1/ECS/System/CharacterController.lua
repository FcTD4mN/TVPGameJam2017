local SystemBase = require( "src/ECS/Systems/SystemBase" )
local Shortcuts = require( "src/Application/Shortcuts" )
local  SoundEngine = require "src/CommOp1/SoundSystem/SoundMachine"
local Vector = require "src/Math/Vector"
VertexCover = require "src/Math/VertexCover/VertexCover"


local  CharacterController = {}
setmetatable( CharacterController, SystemBase )
SystemBase.__index = SystemBase


function  CharacterController:Initialize()

    self.mEntityGroup = {}

end


function CharacterController:IncomingEntity( iEntity )

    -- Here we decide if we are interested by iEntity or not
    -- =====================================================

    local userinput = iEntity:GetComponentByName( "userinput" )
    local position = iEntity:GetComponentByName( "position" )

    if userinput and position then
        table.insert( self.mEntityGroup, iEntity )
        table.insert( iEntity.mObserverSystems, self )
    end

end


function CharacterController:Update( iDT )

    for i = 1, #self.mEntityGroup do

        local entity        = self.mEntityGroup[ i ]
        local position      = entity:GetComponentByName( "position" )
        local destination   = entity:GetComponentByName( "destination" )
        local speed         = entity:GetComponentByName( "speed" )

        if #destination.mX > 0 then

            local vector = Vector:New( destination.mX[ 1 ] - position.mX, destination.mY[ 1 ] - position.mY )
            local vectorNorm = vector:Normalized() -- SQRT !!
            if( vector.x == 0 and vector.y == 0 ) then
                table.remove( destination.mX, 1 )
                table.remove( destination.mY, 1 )
                goto skip
            end

            local xspeed = vectorNorm.x * speed.mSpeed * gGameSpeed
            local yspeed = vectorNorm.y * speed.mSpeed * gGameSpeed

            if math.abs( xspeed ) > math.abs( vector.x ) and math.abs( yspeed ) > math.abs( vector.y ) then
                position.mX = destination.mX[ 1 ]
                position.mY = destination.mY[ 1 ]
                table.remove( destination.mX, 1 )
                table.remove( destination.mY, 1 )
            else
                position.mX = position.mX + xspeed
                position.mY = position.mY + yspeed

                if math.abs( xspeed ) > math.abs( vector.x ) then
                    position.mX = destination.mX[ 1 ]
                end
                if math.abs( yspeed ) > math.abs( vector.y ) then
                    position.mY = destination.mY[ 1 ]
                end
            end

        else

            local theta = math.random() * 2 * math.pi
            local range = 2
            destination.mX[ 1 ] = position.mX + math.cos( theta ) * range
            destination.mY[ 1 ] = position.mY + math.sin( theta ) * range
        end

        ::skip::

    end

end


function CharacterController:MouseReleased( iX, iY, iButton, iIsTouch )
    for i = 1, #self.mEntityGroup do

        local entity        = self.mEntityGroup[ i ]
        local position      = entity:GetComponentByName( "position" )
        local destination   = entity:GetComponentByName( "destination" )
        local sprite        = entity:GetComponentByName( "sprite" )
        local selectable    = entity:GetComponentByName( "selectable" )

        --Move to clickLocation
        if iButton == 2 and  selectable ~= nil and selectable.mSelected then

            local x,y = gCamera:MapToWorld( iX, iY )
            local w,h = sprite.mImage:getWidth(), sprite.mImage:getHeight()

            -- Clément: I was expecting to be able to read in a 2D array at the mouse coordinates but i can't seem to find such a thing in the data we retaine !
            -- my fallback solution is this: AABB collision check against all connections.
            -- It is really unealthy, we should have access to a 2D array at all time in order to do this kind of check, the ECS model is really inconvenient for an optimized tileengine.
            local charFound = false
            local mouseFound = false
            local connectionIndexChar = -1
            local connectionIndexMouse = -1
            for i=1, #gConnections do
                local connectionLineX1 = gConnections[i].mNodeA.mProperty.x
                local connectionLineX2 = gConnections[i].mNodeB.mProperty.x
                local connectionLineY1 = gConnections[i].mNodeA.mProperty.y
                local connectionLineY2 = gConnections[i].mNodeB.mProperty.y
                local halfShift = 200 -- somewhat arbitrary value
                local vector = gConnections[i].mVector:NormalCustom()
                local halfShiftVectorX = halfShift * vector.x
                local halfShiftVectorY = halfShift * vector.y
                local boxX1 = connectionLineX1 - halfShiftVectorX
                local boxX2 = connectionLineX2 + halfShiftVectorX
                local boxY1 = connectionLineY1 - halfShiftVectorY
                local boxY2 = connectionLineY2 + halfShiftVectorY

                if( x > boxX1 and x < boxX2 and y > boxY1 and y < boxY2 ) then
                    mouseFound = true
                    valid = true;
                    connectionIndexMouse = i
                end

                if( position.mX > boxX1 and position.mX < boxX2 and position.mY > boxY1 and position.mY < boxY2 ) then
                    charFound = true
                    connectionIndexChar = i
                end

                if( mouseFound and charFound ) then
                    break;
                end
            end

            -- if we are in this case there is nothing we can do, so if a unit wanders around too far from a connection it is basically lost forever
            if( not mouseFound or not charFound ) then
                goto continue
            end

            -- we're gonna check which node is closest to mouse and which node is closest to char/unit in order to process a path from gPrecomputedNodeSequence
            local nodeAMouse = gConnections[ connectionIndexMouse ].mNodeA
            local nodeBMouse = gConnections[ connectionIndexMouse ].mNodeB
            local nodeAChar = gConnections[ connectionIndexChar ].mNodeA
            local nodeBChar = gConnections[ connectionIndexChar ].mNodeB
            -- it doesn't involve SQRT thankfully
            local deltaMouseA = Vector:New( nodeAMouse.mProperty.x - x, nodeAMouse.mProperty.y - y )
            local deltaMouseB = Vector:New( nodeBMouse.mProperty.x - x, nodeBMouse.mProperty.y - y )
            local deltaCharA = Vector:New( nodeAChar.mProperty.x - position.mX, nodeAChar.mProperty.y - position.mY )
            local deltaCharB = Vector:New( nodeBChar.mProperty.x - position.mX, nodeBChar.mProperty.y - position.mY )
            local dstDeltaMouseA = deltaMouseA:LengthSquared()
            local dstDeltaMouseB = deltaMouseB:LengthSquared()
            local dstDeltaCharA = deltaCharA:LengthSquared()
            local dstDeltaCharB = deltaCharB:LengthSquared()

            local dstMouse = {}
            local dstChar  = {}

            -- select the closest
            local zeroCount = 4 -- How many distN are equal to zero
            local dist1 = 0
            local dist2 = 0
            local dist3 = 0
            local dist4 = 0
            if nodeAChar.mName ~= nodeAMouse.mName then
                dist1 = VertexCover:ComputePathWeight( gPrecomputedNodeSequences[ nodeAChar.mName.."-"..nodeAMouse.mName ] )
                zeroCount = zeroCount - 1
            end
            if nodeAChar.mName ~= nodeBMouse.mName then
                dist2 = VertexCover:ComputePathWeight( gPrecomputedNodeSequences[ nodeAChar.mName.."-"..nodeBMouse.mName ] )
                zeroCount = zeroCount - 1
            end
            if nodeBChar.mName ~= nodeAMouse.mName then
                dist3 = VertexCover:ComputePathWeight( gPrecomputedNodeSequences[ nodeBChar.mName.."-"..nodeAMouse.mName ] )
                zeroCount = zeroCount - 1
            end
            if nodeBChar.mName ~= nodeBMouse.mName then
                dist4 = VertexCover:ComputePathWeight( gPrecomputedNodeSequences[ nodeBChar.mName.."-"..nodeBMouse.mName ] )
                zeroCount = zeroCount - 1
            end

            if dist1 < dist2 and dist1 < dist3 and dist1 < dist4 then
                dstMouse = nodeAMouse
                dstChar = nodeAChar
            elseif dist2 < dist1 and dist2 < dist3 and dist2 < dist4 then
                dstMouse = nodeBMouse
                dstChar = nodeAChar
            elseif dist3 < dist1 and dist3 < dist2 and dist3 < dist4 then
                dstMouse = nodeAMouse
                dstChar = nodeBChar
            else
                dstMouse = nodeBMouse
                dstChar = nodeBChar
            end

            local stringKey, nodeSequence = nil,{}
            if dstChar == dstMouse then
                table.insert( nodeSequence, dstChar )
            else
                stringKey = VertexCover:StringKey( dstChar, dstMouse )
                nodeSequence = gPrecomputedNodeSequences[stringKey]
            end

            ClearTable( destination.mX )
            ClearTable( destination.mY )


            if( zeroCount > 1 ) then
                    table.insert( destination.mX, x - w/2 )
                    table.insert( destination.mY, y - h/2 )
            else
                table.insert( destination.mX, dstChar.mProperty.x - w/2 )
                table.insert( destination.mY, dstChar.mProperty.y - h/2 )
                for i = 1, #nodeSequence do
                    table.insert( destination.mX, nodeSequence[i].mProperty.x - w/2 )
                    table.insert( destination.mY, nodeSequence[i].mProperty.y - h/2 )
                end
                table.insert( destination.mX, x - w/2 )
                table.insert( destination.mY, y - h/2 )

            end

            if #gSelection > 1 then

                local ecart = 100
                local randomX = math.random( ecart ) - ecart/2
                local randomY = math.random( ecart ) - ecart/2

                for i=1, #destination.mX do

                    destination.mX[ i ] = destination.mX[ i ] + randomX
                    destination.mY[ i ] = destination.mY[ i ] + randomY

                end

            end
            SoundEngine:PlayOrder()

        end
        ::continue::
    end
end


function  CharacterController:Draw( iCamera )

end

-- ==========================================Type


function CharacterController:Type()
    return "CharacterController"
end


return  CharacterController
