local Rectangle   =   require( "src/Math/Rectangle" )
local Terrain     =   require( "src/Objects/Terrain" )

local EdgeHUD     =   require( "src/HUD/Box2D/EdgeHUD" )



local TerrainHUD = {}


-- ==========================================Build/Destroy


function TerrainHUD:New( iTerrain, iCamera )
    newTHUD = {}
    setmetatable( newTHUD, TerrainHUD )
    TerrainHUD.__index = TerrainHUD

    newTHUD.mTerrain = iTerrain
    newTHUD.mCamera = iCamera
    newTHUD.mEdgeHUDs = {}

    -- Both these tables are sync'd
    newTHUD.mDraggingEdgeHUDs = {}
    newTHUD.mDraggingHandleNumbers = {}

    assert( newTHUD.mCamera )

    newTHUD:BuildInterface()

    return  newTHUD

end


function  TerrainHUD:BuildInterface()

    for k,v in pairs( self.mTerrain.body:getFixtureList() ) do

        if v:getShape():getType() == "edge" then
            table.insert( self.mEdgeHUDs, EdgeHUD:New( v ) )
        end

    end

end


-- ==========================================Type


function TerrainHUD:Type()
    return  "TerrainHUD"
end


-- ==========================================Draw


function TerrainHUD:Draw( iCamera )

    for k,v in pairs( self.mEdgeHUDs ) do

        v:Draw( iCamera )

    end

end


-- ==========================================TerrainHUD Functions



-- ==========================================User Inputs


function TerrainHUD:MousePressed( iX, iY, iButton, iIsTouch )

    local handleNumber
    for k,v in pairs( self.mEdgeHUDs ) do

        -- x, y = self.mCamera:MapToWorld( iX, iY )
        handleNumber = v:GetHandleNumberAtPos( iX, iY, self.mCamera ) -- Screen coords here and inside GetHandleNumberAtPos, so mousePos doesn't get affected by scale
        if handleNumber > 0 then
            table.insert( self.mDraggingEdgeHUDs, v )
            table.insert( self.mDraggingHandleNumbers, handleNumber )
        end

    end

end


function TerrainHUD:MouseMoved( iX, iY )

    for k,v in pairs( self.mDraggingEdgeHUDs) do

        x, y = self.mCamera:MapToWorld( iX, iY )
        v:MoveHandleAtPos( self.mDraggingHandleNumbers[ k ], x, y )
    end

end


function TerrainHUD:MouseReleased( iX, iY, iButton, iIsTouch )

    if love.keyboard.isDown( 'r' ) then

        for k,v in pairs( self.mDraggingEdgeHUDs) do
            v:Destroy()
            table.remove( self.mEdgeHUDs, GetObjectIndexInTable( self.mEdgeHUDs, v ) )
        end

    end

    ClearTable( self.mDraggingEdgeHUDs )
    ClearTable( self.mDraggingHandleNumbers )

end


return  TerrainHUD



