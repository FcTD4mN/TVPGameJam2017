local  LevelBase       = require "src/CommOp1/Game/Level/LevelBase"


local Level1 = {}
setmetatable( Level1, LevelBase )
LevelBase.__index = LevelBase


-- ==========================================Build/Destroy

function  Level1:New()
    newLevel1 = {}
    setmetatable( newLevel1, Level1 )
    Level1.__index = Level1

    newLevel1:InitializeLevel1()

    return  newLevel1
end

function  Level1:InitializeLevel1()

    self:InitializeLevelBase( "resources/CommOp1/Maps/testmap.csv", "Level1" )

    if not Shortcuts.mLoaded then
        Shortcuts.Load();
    end
    Shortcuts.RegisterAllActions()

    TestsPerso();

end

-- ==========================================Type


function  Level1.Type()
    return "Level1"
end


-- ==========================================Update/Draw


function  Level1:Update( iDT )

    self:UpdateLevelBase( iDT )

end


function  Level1:Draw()

    self:DrawLevelBase()

end



-- ===========TEST============TEST============

function TestsPerso()

    LambdaCharacter:New( 10, 10 )

end


return  Level1