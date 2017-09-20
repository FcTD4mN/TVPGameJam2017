local Rectangle   =   require( "src/Math/Rectangle" )
local Terrain     =   require( "src/Objects/Terrain" )



local TerrainHUD = {}

function TerrainHUD:New( iTerrain )
    newTHUD = {}
    setmetatable( newTHUD, TerrainHUD )
    TerrainHUD.__index = TerrainHUD

    newTHUD.mTerrain = iTerrain
    newTHUD.mHandles = {}

    newTHUD:BuildInterface()

    return  newTHUD

end


function  TerrainHUD:BuildInterface()

    local body = self.mTerrain.body
    local handleSize = 10

    for k,v in pairs( body:getFixtureList() ) do

        if v:getShape():getType() == "edge" then
            x1, y1, x2, y2 = body:getWorldPoints( v:getShape():getPoints() )
            table.insert( self.mHandles, Rectangle:New( x1 - handleSize/2, y1 - handleSize/2, handleSize, handleSize ) )
            table.insert( self.mHandles, Rectangle:New( x2 - handleSize/2, y2 - handleSize/2, handleSize, handleSize ) )
        end

    end

end


function TerrainHUD:Type()
    return  "TerrainHUD"
end


function TerrainHUD:Draw( iCamera )

    for k,v in pairs( self.mHandles ) do

        love.graphics.rectangle( "line", iCamera:MapToScreenMultiple( v.x, v.y, v.w, v.h ) )

    end

end

return  TerrainHUD



