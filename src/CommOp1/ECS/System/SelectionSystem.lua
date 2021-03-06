local SystemBase    = require( "src/ECS/Systems/SystemBase" )
local Point         = require("src/Math/Point")
local  SoundEngine = require "src/CommOp1/SoundSystem/SoundMachine"

local  SelectionSystem = {}
setmetatable( SelectionSystem, SystemBase )
SystemBase.__index = SystemBase


function  SelectionSystem:Initialize()

    self.mEntityGroup = {}
    self.mStartPoint = nil
    self.mRectangle = nil
    self.mState = nil
    gSelection = {}

end


function SelectionSystem:IncomingEntity( iEntity )

    -- Here we decide if we are interested by iEntity or not
    -- =====================================================

    local selectable = iEntity:GetComponentByName( "selectable" )
    local position = iEntity:GetComponentByName( "position" )
    local size = iEntity:GetComponentByName( "size" )

    if selectable and position and size then

        table.insert( self.mEntityGroup, iEntity )
        table.insert( iEntity.mObserverSystems, self )
    end

end


function SelectionSystem:Update( iDT )

end


function  SelectionSystem:Draw( iCamera )

    if( self.mRectangle ) then
        love.graphics.setColor( 50, 255, 50, 100 )
        love.graphics.rectangle( "fill", self.mRectangle.x, self.mRectangle.y, self.mRectangle.w, self.mRectangle.h )
        love.graphics.setColor( 50, 255, 50 )
        love.graphics.rectangle( "line", self.mRectangle.x, self.mRectangle.y, self.mRectangle.w, self.mRectangle.h )
        love.graphics.setColor( 255, 255, 255, 255 )
    end

end


-- ==========================================Type


function SelectionSystem:Type()
    return "SelectionSystem"
end



-- =============================================EVENTS


function  SelectionSystem:MousePressed( iX, iY, iButton, iIsTouch )

    if iButton == 1 then
        self.mStartPoint = Point:New( iX, iY )
        self.mRectangle = Rectangle:New( iX, iY, 1, 1 )
        self.mState = "selecting"
        return  true
    end
    return  false
end


function SelectionSystem:MouseMoved( iX, iY )

    if self.mState == "selecting" then
        self.mRectangle:SetX( self.mStartPoint.mX )
        self.mRectangle:SetY( self.mStartPoint.mY )
        self.mRectangle:SetX2( iX )
        self.mRectangle:SetY2( iY )
        return  true
    end
    return  false
end


function SelectionSystem:MouseReleased( iX, iY, iButton, iIsTouch )

    if self.mState == "selecting" then

        for i = 1, #self.mEntityGroup do

            local entity = self.mEntityGroup[ i ]
            local selectable = entity:GetComponentByName( "selectable" )
            local position = entity:GetComponentByName( "position" )
            local size = entity:GetComponentByName( "size" )

            selectable.mSelected = false

            local index = GetObjectIndexInTable( gSelection, entity )
            if index > 0 then
                table.remove( gSelection, index )
            end

            local x,y = gCamera:MapToScreen( position.mX, position.mY )

            local rectangleSprite = Rectangle:New( x, y, 0, 0 )

            if size then
                rectangleSprite:SetW( size.mW * gCamera.mScale )
                rectangleSprite:SetH( size.mH * gCamera.mScale )
            end

            if (rectangleSprite:ContainsRectangleEntirely( self.mRectangle ))
                or (self.mRectangle:ContainsRectangleEntirely( rectangleSprite )) then

                    selectable.mSelected = true
                    if entity:GetTagByName( "character" ) ~= "0" then
                        SoundEngine:PlaySelection()
                    else
                        -- Building
                    end
                    table.insert( gSelection, entity )

            end

        end


        self.mRectangle     = nil
        self.mStartPoint    = nil
        self.mState         = nil
        return  true

    end

    return  false

end


return  SelectionSystem
