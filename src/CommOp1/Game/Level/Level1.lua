local  LevelBase       = require "src/CommOp1/Game/Level/LevelBase"
local  ECSIncludes     = require "src/CommOp1/ECS/ECSIncludes"
local  Node = require "src/Math/VertexCover/Node"
local  VertexCover = require "src/Math/VertexCover/VertexCover"
local  Vector = require "src/Math/Vector"

local  SoundEngine = require "src/CommOp1/SoundSystem/SoundMachine"

local Level1 = {}
setmetatable( Level1, LevelBase )
LevelBase.__index = LevelBase


-- ==========================================Build/Destroy

function  Level1:New( iMode )
    newLevel1 = {}
    setmetatable( newLevel1, Level1 )
    Level1.__index = Level1

    newLevel1:InitializeLevel1( iMode )

    return  newLevel1
end

function Level1:ActionGameSpeed1()
    gGameSpeed = 1
end

function Level1:ActionGameSpeed2()
    gGameSpeed = 2
end

function Level1:ActionGameSpeed3()
    gGameSpeed = 4
end

function Level1:ActionGameSpeed4()
    gGameSpeed = 8
end

function  Level1:InitializeLevel1( iMode )

    self:InitializeLevelBase( "resources/CommOp1/Maps/Level1Image.csv", "resources/CommOp1/Maps/Level1TileSet.png", "resources/CommOp1/Maps/Level1Type.csv" )

    SoundEngine.Init()
    --
    table.insert( gNodes, 0)

    gNodeA  = Node:New( "A",    Vector:New(     680,        600 ) )
    gNodeB  = Node:New( "B",    Vector:New(     680,        2440 ) )
    gNodeC  = Node:New( "C",    Vector:New(     4040,       2440 ) )
    gNodeD  = Node:New( "D",    Vector:New(     4040,       3640 ) )
    gNodeE  = Node:New( "E",    Vector:New(     6280,       2440 ) )
    gNodeF  = Node:New( "F",    Vector:New(     6280,       3640 ) )
    gNodeG  = Node:New( "G",    Vector:New(     5320,       3640 ) )
    gNodeH  = Node:New( "H",    Vector:New(     6280,       4760 ) )
    gNodeI  = Node:New( "I",    Vector:New(     5320,       4760 ) )
    gNodeJ  = Node:New( "J",    Vector:New(     6280,       5960 ) )
    gNodeK  = Node:New( "K",    Vector:New(     5320,       5960 ) )
    gNodeL  = Node:New( "L",    Vector:New(     6280,       7160 ) )
    gNodeM  = Node:New( "M",    Vector:New(     4040,       7160 ) )
    gNodeN  = Node:New( "N",    Vector:New(     8200,       2440 ) )
    gNodeO  = Node:New( "O",    Vector:New(     8200,       4760 ) )
    gNodeP  = Node:New( "P",    Vector:New(     8200,       6180 ) )
    gNodeQ  = Node:New( "Q",    Vector:New(     10440,      6180 ) )
    gNodeR  = Node:New( "R",    Vector:New(     9880,       2440 ) )
    gNodeS  = Node:New( "S",    Vector:New(     9880,       4760 ) )
    gNodeT  = Node:New( "T",    Vector:New(     11480,      680 ) )
    gNodeU  = Node:New( "U",    Vector:New(     11480,      2440 ) )
    gNodeV  = Node:New( "V",    Vector:New(     11480,      4760 ) )
    gNodeW  = Node:New( "W",    Vector:New(     11480,      6180 ) )
    gNodeX  = Node:New( "X",    Vector:New(     13240,      2440 ) )
    gNodeY  = Node:New( "Y",    Vector:New(     13240,      4760 ) )
    gNodeZ  = Node:New( "Z",    Vector:New(     13240,      6180 ) )
    gNodeAA = Node:New( "AA",   Vector:New(     13700,      680 ) )
    gNodeAB = Node:New( "AB",   Vector:New(     13700,      2440 ) )
    gNodeAC = Node:New( "AC",   Vector:New(     13700,      4760 ) )
    gNodeAD = Node:New( "AD",   Vector:New(     13700,      6180 ) )
    gNodeAE = Node:New( "AE",   Vector:New(     15080,      1560 ) )
    gNodeAF = Node:New( "AF",   Vector:New(     15080,      2440 ) )
    gNodeAG = Node:New( "AG",   Vector:New(     15080,      4760 ) )
    gNodeAH = Node:New( "AH",   Vector:New(     15080,      6180 ) )
    gNodeAI = Node:New( "AI",   Vector:New(     15080,      7160 ) )
    gNodeAJ = Node:New( "AJ",   Vector:New(     15080,      7620 ) )
    gNodeAK = Node:New( "AK",   Vector:New(     16340,      2440 ) )
    gNodeAL = Node:New( "AL",   Vector:New(     16340,      4760 ) )
    gNodeAM = Node:New( "AM",   Vector:New(     16340,      5480 ) )
    gNodeAN = Node:New( "AN",   Vector:New(     16340,      6180 ) )
    gNodeAO = Node:New( "AO",   Vector:New(     19880,      2440 ) )
    gNodeAP = Node:New( "AP",   Vector:New(     19880,      4750 ) )
    gNodeAQ = Node:New( "AQ",   Vector:New(     19880,      5480 ) )
    gNodeAR = Node:New( "AR",   Vector:New(     21960,      680 ) )
    gNodeAS = Node:New( "AS",   Vector:New(     21960,      1560 ) )
    gNodeAT = Node:New( "AT",   Vector:New(     21960,      7080 ) )
    gNodeAU = Node:New( "AU",   Vector:New(     23400,      680 ) )
    gNodeAV = Node:New( "AV",   Vector:New(     23400,      1560 ) )

    VertexCover:AddConnection( gNodeA, gNodeB,  VertexCover:Distance( gNodeA, gNodeB ) )
    VertexCover:AddConnection( gNodeB, gNodeC,  VertexCover:Distance( gNodeB, gNodeC ) )
    VertexCover:AddConnection( gNodeC, gNodeD,  VertexCover:Distance( gNodeC, gNodeD ) )
    VertexCover:AddConnection( gNodeC, gNodeE,  VertexCover:Distance( gNodeC, gNodeE ) )
    VertexCover:AddConnection( gNodeE, gNodeF,  VertexCover:Distance( gNodeE, gNodeF ) )
    VertexCover:AddConnection( gNodeE, gNodeN,  VertexCover:Distance( gNodeE, gNodeN ) )
    VertexCover:AddConnection( gNodeF, gNodeG,  VertexCover:Distance( gNodeF, gNodeG ) )
    VertexCover:AddConnection( gNodeF, gNodeH,  VertexCover:Distance( gNodeF, gNodeH ) )
    VertexCover:AddConnection( gNodeH, gNodeI,  VertexCover:Distance( gNodeH, gNodeI ) )
    VertexCover:AddConnection( gNodeH, gNodeJ,  VertexCover:Distance( gNodeH, gNodeJ ) )
    VertexCover:AddConnection( gNodeJ, gNodeK,  VertexCover:Distance( gNodeJ, gNodeK ) )
    VertexCover:AddConnection( gNodeJ, gNodeL,  VertexCover:Distance( gNodeJ, gNodeL ) )
    VertexCover:AddConnection( gNodeL, gNodeM,  VertexCover:Distance( gNodeL, gNodeM ) )
    VertexCover:AddConnection( gNodeL, gNodeAI, VertexCover:Distance( gNodeL, gNodeAI ) )
    VertexCover:AddConnection( gNodeN, gNodeO,  VertexCover:Distance( gNodeN, gNodeO ) )
    VertexCover:AddConnection( gNodeN, gNodeR,  VertexCover:Distance( gNodeN, gNodeR ) )
    VertexCover:AddConnection( gNodeO, gNodeS,  VertexCover:Distance( gNodeO, gNodeS ) )
    VertexCover:AddConnection( gNodeO, gNodeP,  VertexCover:Distance( gNodeO, gNodeP ) )
    VertexCover:AddConnection( gNodeP, gNodeQ,  VertexCover:Distance( gNodeP, gNodeQ ) )
    VertexCover:AddConnection( gNodeR, gNodeS,  VertexCover:Distance( gNodeR, gNodeS ) )
    VertexCover:AddConnection( gNodeR, gNodeU,  VertexCover:Distance( gNodeR, gNodeU ) )
    VertexCover:AddConnection( gNodeS, gNodeV,  VertexCover:Distance( gNodeS, gNodeV ) )
    VertexCover:AddConnection( gNodeT, gNodeAA,  VertexCover:Distance( gNodeT, gNodeAA ) )
    VertexCover:AddConnection( gNodeT, gNodeU,  VertexCover:Distance( gNodeT, gNodeU ) )
    VertexCover:AddConnection( gNodeU, gNodeX,  VertexCover:Distance( gNodeU, gNodeX ) )
    VertexCover:AddConnection( gNodeU, gNodeV,  VertexCover:Distance( gNodeU, gNodeV ) )
    VertexCover:AddConnection( gNodeV, gNodeW,  VertexCover:Distance( gNodeV, gNodeW ) )
    VertexCover:AddConnection( gNodeW, gNodeZ,  VertexCover:Distance( gNodeW, gNodeZ ) )
    VertexCover:AddConnection( gNodeX, gNodeAB,  VertexCover:Distance( gNodeX, gNodeAB ) )
    VertexCover:AddConnection( gNodeX, gNodeY,  VertexCover:Distance( gNodeX, gNodeY ) )
    VertexCover:AddConnection( gNodeY, gNodeAC,  VertexCover:Distance( gNodeY, gNodeAC ) )
    VertexCover:AddConnection( gNodeY, gNodeZ,  VertexCover:Distance( gNodeY, gNodeZ ) )
    VertexCover:AddConnection( gNodeZ, gNodeAD,  VertexCover:Distance( gNodeZ, gNodeAD ) )
    VertexCover:AddConnection( gNodeAA, gNodeAB,  VertexCover:Distance( gNodeAA, gNodeAB ) )
    VertexCover:AddConnection( gNodeAB, gNodeAF,  VertexCover:Distance( gNodeAB, gNodeAF ) )
    VertexCover:AddConnection( gNodeAB, gNodeAC,  VertexCover:Distance( gNodeAB, gNodeAC ) )
    VertexCover:AddConnection( gNodeAC, gNodeAG,  VertexCover:Distance( gNodeAC, gNodeAG ) )
    VertexCover:AddConnection( gNodeAC, gNodeAD,  VertexCover:Distance( gNodeAC, gNodeAD ) )
    VertexCover:AddConnection( gNodeAD, gNodeAH,  VertexCover:Distance( gNodeAD, gNodeAH ) )
    VertexCover:AddConnection( gNodeAE, gNodeAS,  VertexCover:Distance( gNodeAE, gNodeAS ) )
    VertexCover:AddConnection( gNodeAE, gNodeAF,  VertexCover:Distance( gNodeAE, gNodeAF ) )
    VertexCover:AddConnection( gNodeAF, gNodeAK,  VertexCover:Distance( gNodeAF, gNodeAK ) )
    VertexCover:AddConnection( gNodeAF, gNodeAG,  VertexCover:Distance( gNodeAF, gNodeAG ) )
    VertexCover:AddConnection( gNodeAG, gNodeAL,  VertexCover:Distance( gNodeAG, gNodeAL ) )
    VertexCover:AddConnection( gNodeAG, gNodeAH,  VertexCover:Distance( gNodeAG, gNodeAH ) )
    VertexCover:AddConnection( gNodeAH, gNodeAN,  VertexCover:Distance( gNodeAH, gNodeAN ) )
    VertexCover:AddConnection( gNodeAH, gNodeAI,  VertexCover:Distance( gNodeAH, gNodeAI ) )
    VertexCover:AddConnection( gNodeAI, gNodeAJ,  VertexCover:Distance( gNodeAI, gNodeAJ ) )
    VertexCover:AddConnection( gNodeAK, gNodeAO,  VertexCover:Distance( gNodeAK, gNodeAO ) )
    VertexCover:AddConnection( gNodeAK, gNodeAL,  VertexCover:Distance( gNodeAK, gNodeAL ) )
    VertexCover:AddConnection( gNodeAL, gNodeAP,  VertexCover:Distance( gNodeAL, gNodeAP ) )
    VertexCover:AddConnection( gNodeAL, gNodeAM,  VertexCover:Distance( gNodeAL, gNodeAM ) )
    VertexCover:AddConnection( gNodeAM, gNodeAQ,  VertexCover:Distance( gNodeAM, gNodeAQ ) )
    VertexCover:AddConnection( gNodeAM, gNodeAN,  VertexCover:Distance( gNodeAM, gNodeAN ) )
    VertexCover:AddConnection( gNodeAO, gNodeAP,  VertexCover:Distance( gNodeAO, gNodeAP ) )
    VertexCover:AddConnection( gNodeAP, gNodeAQ,  VertexCover:Distance( gNodeAP, gNodeAQ ) )
    VertexCover:AddConnection( gNodeAS, gNodeAR,  VertexCover:Distance( gNodeAS, gNodeAR ) )
    VertexCover:AddConnection( gNodeAS, gNodeAT,  VertexCover:Distance( gNodeAS, gNodeAT ) )
    VertexCover:AddConnection( gNodeAS, gNodeAV,  VertexCover:Distance( gNodeAS, gNodeAV ) )
    VertexCover:AddConnection( gNodeAR, gNodeAU,  VertexCover:Distance( gNodeAR, gNodeAU ) )
    VertexCover:AddConnection( gNodeAU, gNodeAV,  VertexCover:Distance( gNodeAU, gNodeAV ) )

    table.insert( gNodes, gNodeA )
    table.insert( gNodes, gNodeB  )
    table.insert( gNodes, gNodeC  )
    table.insert( gNodes, gNodeD  )
    table.insert( gNodes, gNodeE  )
    table.insert( gNodes, gNodeF  )
    table.insert( gNodes, gNodeG  )
    table.insert( gNodes, gNodeH  )
    table.insert( gNodes, gNodeI  )
    table.insert( gNodes, gNodeJ  )
    table.insert( gNodes, gNodeK  )
    table.insert( gNodes, gNodeL  )
    table.insert( gNodes, gNodeM  )
    table.insert( gNodes, gNodeN  )
    table.insert( gNodes, gNodeO  )
    table.insert( gNodes, gNodeP  )
    table.insert( gNodes, gNodeQ  )
    table.insert( gNodes, gNodeR  )
    table.insert( gNodes, gNodeS  )
    table.insert( gNodes, gNodeT  )
    table.insert( gNodes, gNodeU  )
    table.insert( gNodes, gNodeV  )
    table.insert( gNodes, gNodeW  )
    table.insert( gNodes, gNodeX  )
    table.insert( gNodes, gNodeY  )
    table.insert( gNodes, gNodeZ  )
    table.insert( gNodes, gNodeAA )
    table.insert( gNodes, gNodeAB )
    table.insert( gNodes, gNodeAC )
    table.insert( gNodes, gNodeAD )
    table.insert( gNodes, gNodeAE )
    table.insert( gNodes, gNodeAF )
    table.insert( gNodes, gNodeAG )
    table.insert( gNodes, gNodeAH )
    table.insert( gNodes, gNodeAI )
    table.insert( gNodes, gNodeAJ )
    table.insert( gNodes, gNodeAK )
    table.insert( gNodes, gNodeAL )
    table.insert( gNodes, gNodeAM )
    table.insert( gNodes, gNodeAN )
    table.insert( gNodes, gNodeAO )
    table.insert( gNodes, gNodeAP )
    table.insert( gNodes, gNodeAQ )
    table.insert( gNodes, gNodeAR )
    table.insert( gNodes, gNodeAS )
    table.insert( gNodes, gNodeAT )
    table.insert( gNodes, gNodeAU )
    table.insert( gNodes, gNodeAV )

    local result = VertexCover:FindPaths( gNodeA, gNodeAT )

    for i=1, #result do
        local sum = VertexCover:ComputePathWeight( result[ i ] )
    end

    if not Shortcuts.mLoaded then
        Shortcuts.Load();
    end
    Shortcuts.RegisterAllActions()

    local skillbar = SkillBar:New()
    local skilllist = skillbar:GetComponentByName( "skilllist" )
    table.insert( skilllist.mSkills, Skill:New( "resources/CommOp1/Tiles/Level1/A1.png", self.ActionGameSpeed1 ) )
    table.insert( skilllist.mSkills, Skill:New( "resources/CommOp1/Tiles/Level1/A3.png", self.ActionGameSpeed2 ) )
    table.insert( skilllist.mSkills, Skill:New( "resources/CommOp1/Tiles/Level1/A7.png", self.ActionGameSpeed3 ) )
    table.insert( skilllist.mSkills, Skill:New( "resources/CommOp1/Tiles/Level1/A9.png", self.ActionGameSpeed4 ) )

    --Add characters ( 5-90-5 )%
    self.mMode = iMode

    local nbpersos = 5000
    local capitalists = math.ceil( nbpersos * 0.05 )
    local communists = math.ceil( nbpersos * 0.05 )
    local neutrals = nbpersos - capitalists - communists
    self:AddCharacters( neutrals, "neutral" )
    self:AddCharacters( capitalists, "capitalist" )
    self:AddCharacters( communists, "communist" )
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


function Level1:AddCharacters( iCount, iType )

    math.randomseed( love.timer.getTime() )
    local ecartx = self.mMap.mW - 1
    local ecarty = self.mMap.mH - 1
    for i=0, iCount do
        local x = math.random( ecartx )
        local y = math.random( ecarty )
        Character:New( iType, x, y, self.mMode == iType )
    end

end


return  Level1