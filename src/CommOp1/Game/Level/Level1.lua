local  LevelBase       = require "src/CommOp1/Game/Level/LevelBase"
local  ECSIncludes     = require "src/CommOp1/ECS/ECSIncludes"


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

function Level1:ActionPrint1()
    print( "Action 1 !" )
end

function Level1:ActionPrint2()
    print( "Action 2 !" )
end

function Level1:ActionPrint3()
    print( "Action 3 !" )
end

function Level1:ActionPrint4()
    print( "Action 4 !" )
end

function  Level1:InitializeLevel1()

    self:InitializeLevelBase( "resources/CommOp1/Maps/Level1Image.csv", "resources/CommOp1/Maps/Level1TileSet.png", "resources/CommOp1/Maps/Level1Type.csv" )

    if not Shortcuts.mLoaded then
        Shortcuts.Load();
    end
    Shortcuts.RegisterAllActions()

    TestsPerso();

    local skillbar = SkillBar:New()
    local skilllist = skillbar:GetComponentByName( "skilllist" )
    table.insert( skilllist.mSkills, Skill:New( "resources/CommOp1/Tiles/Level1/A1.png", self.ActionPrint1 ) )
    table.insert( skilllist.mSkills, Skill:New( "resources/CommOp1/Tiles/Level1/A3.png", self.ActionPrint2 ) )
    table.insert( skilllist.mSkills, Skill:New( "resources/CommOp1/Tiles/Level1/A7.png", self.ActionPrint3 ) )
    table.insert( skilllist.mSkills, Skill:New( "resources/CommOp1/Tiles/Level1/A9.png", self.ActionPrint4 ) )

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
    LambdaCharacter:New( 100, 100 )
    LambdaCharacter:New( 100, 110 )
    LambdaCharacter:New( 100, 120 )
    LambdaCharacter:New( 110, 110 )

end


return  Level1