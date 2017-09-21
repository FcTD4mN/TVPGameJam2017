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

        x, y = self.mCamera:MapToScreen( iX, iY )
        handleNumber = v:GetHandleNumberAtPos( x, y, self.mCamera )
        if handleNumber > 0 then
            table.insert( self.mDraggingEdgeHUDs, v )
            table.insert( self.mDraggingHandleNumbers, handleNumber )
        end

    end

end


function TerrainHUD:MouseMoved( iX, iY )

    for k,v in pairs( self.mDraggingEdgeHUDs) do
        v:MoveHandleAtPos( self.mDraggingHandleNumbers[ k ], iX, iY )
    end

end


function TerrainHUD:MouseReleased( iX, iY, iButton, iIsTouch )

    ClearTable( self.mDraggingEdgeHUDs )
    ClearTable( self.mDraggingHandleNumbers )

end


return  TerrainHUD



