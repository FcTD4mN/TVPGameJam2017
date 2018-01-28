local  LevelBase       = require "src/CommOp1/Game/Level/LevelBase"
local  ECSIncludes     = require "src/CommOp1/ECS/ECSIncludes"
local  Node = require "src/Math/VertexCover/Node"
local  VertexCover = require "src/Math/VertexCover/VertexCover"
local  Vector = require "src/Math/Vector"
local  Connection = require "src/Math/VertexCover/Connection"

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

function Level1:ActionGameSpeed0()
    gGameSpeed = 0
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

    gFaction = iMode
    SoundEngine.Init()
    --
    if not Shortcuts.mLoaded then
        Shortcuts.Load();
    end
    Shortcuts.RegisterAllActions()

    local skillbar = SkillBar:New()
    local skilllist = skillbar:GetComponentByName( "skilllist" )
    table.insert( skilllist.mSkills, Skill:New( "resources/CommOp1/Tiles/Level1/R1.png", self.ActionGameSpeed0 ) )
    table.insert( skilllist.mSkills, Skill:New( "resources/CommOp1/Tiles/Level1/A1.png", self.ActionGameSpeed1 ) )
    table.insert( skilllist.mSkills, Skill:New( "resources/CommOp1/Tiles/Level1/A3.png", self.ActionGameSpeed2 ) )
    table.insert( skilllist.mSkills, Skill:New( "resources/CommOp1/Tiles/Level1/A7.png", self.ActionGameSpeed3 ) )
    table.insert( skilllist.mSkills, Skill:New( "resources/CommOp1/Tiles/Level1/A9.png", self.ActionGameSpeed4 ) )

    self:InitializeNodePath()

    if not Shortcuts.mLoaded then
        Shortcuts.Load();
    end
    Shortcuts.RegisterAllActions()

    --Add characters ( 5-90-5 )%

    gTotalCount, gCommunistCount, gNeutralCount, gCapitalistCount = 0,0,0,0

    local totalCount = 1000
    local capitalistCount = math.ceil( totalCount * 0.05 )
    local communistCount = math.ceil( totalCount * 0.05 )
    local neutralCount = totalCount - capitalistCount - communistCount

    self:AddCharacters( neutralCount, "neutral" )
    self:AddCharacters( capitalistCount, "capitalist" )
    self:AddCharacters( communistCount, "communist" )

    WacDo:New( "neutral", 160, 400 )
    Library:New( "neutral", 7*80, 80 )
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
    local localCount = iCount / #gConnections
    local spread = 1
    local shift = 0
    for i=1, #gConnections do
        local normal = gConnections[i].mVector:NormalCustom()
        for j=0, localCount do
            local rnd1 = math.random()
            local rnd2 = math.random()
            local x = ( gConnections[i].mNodeA.mProperty.x + rnd1 * gConnections[i].mVector.x * gConnections[i].mNorm ) + ( rnd2 * normal.x * spread ) - shift
            local y = ( gConnections[i].mNodeA.mProperty.y + rnd1 * gConnections[i].mVector.y * gConnections[i].mNorm ) + ( rnd2 * normal.y * spread ) - shift
            Character:New( iType, x, y )
        end
    end
end

function Level1:InitializeNodePath()

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

    local dstAB     = VertexCover:Distance( gNodeA, gNodeB )
    local dstBC     = VertexCover:Distance( gNodeB, gNodeC )
    local dstCD     = VertexCover:Distance( gNodeC, gNodeD )
    local dstCE     = VertexCover:Distance( gNodeC, gNodeE )
    local dstEF     = VertexCover:Distance( gNodeE, gNodeF )
    local dstEN     = VertexCover:Distance( gNodeE, gNodeN )
    local dstFG     = VertexCover:Distance( gNodeF, gNodeG )
    local dstFH     = VertexCover:Distance( gNodeF, gNodeH )
    local dstHI     = VertexCover:Distance( gNodeH, gNodeI )
    local dstHJ     = VertexCover:Distance( gNodeH, gNodeJ )
    local dstJK     = VertexCover:Distance( gNodeJ, gNodeK )
    local dstJL     = VertexCover:Distance( gNodeJ, gNodeL )
    local dstLM     = VertexCover:Distance( gNodeL, gNodeM )
    local dstLAI    = VertexCover:Distance( gNodeL, gNodeAI )
    local dstNO     = VertexCover:Distance( gNodeN, gNodeO )
    local dstNR     = VertexCover:Distance( gNodeN, gNodeR )
    local dstOS     = VertexCover:Distance( gNodeO, gNodeS )
    local dstOP     = VertexCover:Distance( gNodeO, gNodeP )
    local dstPQ     = VertexCover:Distance( gNodeP, gNodeQ )
    local dstRS     = VertexCover:Distance( gNodeR, gNodeS )
    local dstRU     = VertexCover:Distance( gNodeR, gNodeU )
    local dstSV     = VertexCover:Distance( gNodeS, gNodeV )
    local dstTAA    = VertexCover:Distance( gNodeT, gNodeAA )
    local dstTU     = VertexCover:Distance( gNodeT, gNodeU )
    local dstUX     = VertexCover:Distance( gNodeU, gNodeX )
    local dstUV     = VertexCover:Distance( gNodeU, gNodeV )
    local dstVW     = VertexCover:Distance( gNodeV, gNodeW )
    local dstWZ     = VertexCover:Distance( gNodeW, gNodeZ )
    local dstXAB    = VertexCover:Distance( gNodeX, gNodeAB )
    local dstXY     = VertexCover:Distance( gNodeX, gNodeY )
    local dstYC     = VertexCover:Distance( gNodeY, gNodeAC )
    local dstYZ     = VertexCover:Distance( gNodeY, gNodeZ )
    local dstZAD    = VertexCover:Distance( gNodeZ, gNodeAD )
    local dstAAAB   = VertexCover:Distance( gNodeAA, gNodeAB )
    local dstABAF   = VertexCover:Distance( gNodeAB, gNodeAF )
    local dstABAC   = VertexCover:Distance( gNodeAB, gNodeAC )
    local dstACAG   = VertexCover:Distance( gNodeAC, gNodeAG )
    local dstACAD   = VertexCover:Distance( gNodeAC, gNodeAD )
    local dstADAH   = VertexCover:Distance( gNodeAD, gNodeAH )
    local dstAEAS   = VertexCover:Distance( gNodeAE, gNodeAS )
    local dstAEAF   = VertexCover:Distance( gNodeAE, gNodeAF )
    local dstAFAK   = VertexCover:Distance( gNodeAF, gNodeAK )
    local dstAFAG   = VertexCover:Distance( gNodeAF, gNodeAG )
    local dstAGAL   = VertexCover:Distance( gNodeAG, gNodeAL )
    local dstAGAH   = VertexCover:Distance( gNodeAG, gNodeAH )
    local dstAHAN   = VertexCover:Distance( gNodeAH, gNodeAN )
    local dstAHAI   = VertexCover:Distance( gNodeAH, gNodeAI )
    local dstAIAJ   = VertexCover:Distance( gNodeAI, gNodeAJ )
    local dstAKAO   = VertexCover:Distance( gNodeAK, gNodeAO )
    local dstAKAL   = VertexCover:Distance( gNodeAK, gNodeAL )
    local dstALAP   = VertexCover:Distance( gNodeAL, gNodeAP )
    local dstALAM   = VertexCover:Distance( gNodeAL, gNodeAM )
    local dstAMAQ   = VertexCover:Distance( gNodeAM, gNodeAQ )
    local dstAMAN   = VertexCover:Distance( gNodeAM, gNodeAN )
    local dstAOAP   = VertexCover:Distance( gNodeAO, gNodeAP )
    local dstAPAQ   = VertexCover:Distance( gNodeAP, gNodeAQ )
    local dstASAR   = VertexCover:Distance( gNodeAS, gNodeAR )
    local dstASAT   = VertexCover:Distance( gNodeAS, gNodeAT )
    local dstASAV   = VertexCover:Distance( gNodeAS, gNodeAV )
    local dstARAU   = VertexCover:Distance( gNodeAR, gNodeAU )
    local dstAUAV   = VertexCover:Distance( gNodeAU, gNodeAV )

    table.insert( gConnections,  Connection:New( gNodeA,      gNodeB,         dstAB      ) )
    table.insert( gConnections,  Connection:New( gNodeB,      gNodeC,         dstBC      ) )
    table.insert( gConnections,  Connection:New( gNodeC,      gNodeD,         dstCD      ) )
    table.insert( gConnections,  Connection:New( gNodeC,      gNodeE,         dstCE      ) )
    table.insert( gConnections,  Connection:New( gNodeE,      gNodeF,         dstEF      ) )
    table.insert( gConnections,  Connection:New( gNodeE,      gNodeN,         dstEN      ) )
    table.insert( gConnections,  Connection:New( gNodeG,      gNodeF,         dstFG      ) )
    table.insert( gConnections,  Connection:New( gNodeF,      gNodeH,         dstFH      ) )
    table.insert( gConnections,  Connection:New( gNodeI,      gNodeH,         dstHI      ) )
    table.insert( gConnections,  Connection:New( gNodeH,      gNodeJ,         dstHJ      ) )
    table.insert( gConnections,  Connection:New( gNodeK,      gNodeJ,         dstJK      ) )
    table.insert( gConnections,  Connection:New( gNodeJ,      gNodeL,         dstJL      ) )
    table.insert( gConnections,  Connection:New( gNodeM,      gNodeL,         dstLM      ) )
    table.insert( gConnections,  Connection:New( gNodeL,      gNodeAI,        dstLAI     ) )
    table.insert( gConnections,  Connection:New( gNodeN,      gNodeO,         dstNO      ) )
    table.insert( gConnections,  Connection:New( gNodeN,      gNodeR,         dstNR      ) )
    table.insert( gConnections,  Connection:New( gNodeO,      gNodeS,         dstOS      ) )
    table.insert( gConnections,  Connection:New( gNodeO,      gNodeP,         dstOP      ) )
    table.insert( gConnections,  Connection:New( gNodeP,      gNodeQ,         dstPQ      ) )
    table.insert( gConnections,  Connection:New( gNodeR,      gNodeS,         dstRS      ) )
    table.insert( gConnections,  Connection:New( gNodeR,      gNodeU,         dstRU      ) )
    table.insert( gConnections,  Connection:New( gNodeS,      gNodeV,         dstSV      ) )
    table.insert( gConnections,  Connection:New( gNodeT,      gNodeAA,        dstTAA     ) )
    table.insert( gConnections,  Connection:New( gNodeT,      gNodeU,         dstTU      ) )
    table.insert( gConnections,  Connection:New( gNodeU,      gNodeX,         dstUX      ) )
    table.insert( gConnections,  Connection:New( gNodeU,      gNodeV,         dstUV      ) )
    table.insert( gConnections,  Connection:New( gNodeV,      gNodeW,         dstVW      ) )
    table.insert( gConnections,  Connection:New( gNodeW,      gNodeZ,         dstWZ      ) )
    table.insert( gConnections,  Connection:New( gNodeX,      gNodeAB,        dstXAB     ) )
    table.insert( gConnections,  Connection:New( gNodeX,      gNodeY,         dstXY      ) )
    table.insert( gConnections,  Connection:New( gNodeY,      gNodeAC,        dstYC      ) )
    table.insert( gConnections,  Connection:New( gNodeY,      gNodeZ,         dstYZ      ) )
    table.insert( gConnections,  Connection:New( gNodeZ,      gNodeAD,        dstZAD     ) )
    table.insert( gConnections,  Connection:New( gNodeAA,     gNodeAB,        dstAAAB    ) )
    table.insert( gConnections,  Connection:New( gNodeAB,     gNodeAF,        dstABAF    ) )
    table.insert( gConnections,  Connection:New( gNodeAB,     gNodeAC,        dstABAC    ) )
    table.insert( gConnections,  Connection:New( gNodeAC,     gNodeAG,        dstACAG    ) )
    table.insert( gConnections,  Connection:New( gNodeAC,     gNodeAD,        dstACAD    ) )
    table.insert( gConnections,  Connection:New( gNodeAD,     gNodeAH,        dstADAH    ) )
    table.insert( gConnections,  Connection:New( gNodeAE,     gNodeAS,        dstAEAS    ) )
    table.insert( gConnections,  Connection:New( gNodeAE,     gNodeAF,        dstAEAF    ) )
    table.insert( gConnections,  Connection:New( gNodeAF,     gNodeAK,        dstAFAK    ) )
    table.insert( gConnections,  Connection:New( gNodeAF,     gNodeAG,        dstAFAG    ) )
    table.insert( gConnections,  Connection:New( gNodeAG,     gNodeAL,        dstAGAL    ) )
    table.insert( gConnections,  Connection:New( gNodeAG,     gNodeAH,        dstAGAH    ) )
    table.insert( gConnections,  Connection:New( gNodeAH,     gNodeAN,        dstAHAN    ) )
    table.insert( gConnections,  Connection:New( gNodeAH,     gNodeAI,        dstAHAI    ) )
    table.insert( gConnections,  Connection:New( gNodeAI,     gNodeAJ,        dstAIAJ    ) )
    table.insert( gConnections,  Connection:New( gNodeAK,     gNodeAO,        dstAKAO    ) )
    table.insert( gConnections,  Connection:New( gNodeAK,     gNodeAL,        dstAKAL    ) )
    table.insert( gConnections,  Connection:New( gNodeAL,     gNodeAP,        dstALAP    ) )
    table.insert( gConnections,  Connection:New( gNodeAL,     gNodeAM,        dstALAM    ) )
    table.insert( gConnections,  Connection:New( gNodeAM,     gNodeAQ,        dstAMAQ    ) )
    table.insert( gConnections,  Connection:New( gNodeAM,     gNodeAN,        dstAMAN    ) )
    table.insert( gConnections,  Connection:New( gNodeAO,     gNodeAP,        dstAOAP    ) )
    table.insert( gConnections,  Connection:New( gNodeAP,     gNodeAQ,        dstAPAQ    ) )
    table.insert( gConnections,  Connection:New( gNodeAS,     gNodeAR,        dstASAR    ) )
    table.insert( gConnections,  Connection:New( gNodeAS,     gNodeAT,        dstASAT    ) )
    table.insert( gConnections,  Connection:New( gNodeAS,     gNodeAV,        dstASAV    ) )
    table.insert( gConnections,  Connection:New( gNodeAR,     gNodeAU,        dstARAU    ) )
    table.insert( gConnections,  Connection:New( gNodeAU,     gNodeAV,        dstAUAV    ) )

    VertexCover:AddConnection( gNodeA,      gNodeB,         dstAB      )
    VertexCover:AddConnection( gNodeB,      gNodeC,         dstBC      )
    VertexCover:AddConnection( gNodeC,      gNodeD,         dstCD      )
    VertexCover:AddConnection( gNodeC,      gNodeE,         dstCE      )
    VertexCover:AddConnection( gNodeE,      gNodeF,         dstEF      )
    VertexCover:AddConnection( gNodeE,      gNodeN,         dstEN      )
    VertexCover:AddConnection( gNodeF,      gNodeG,         dstFG      )
    VertexCover:AddConnection( gNodeF,      gNodeH,         dstFH      )
    VertexCover:AddConnection( gNodeH,      gNodeI,         dstHI      )
    VertexCover:AddConnection( gNodeH,      gNodeJ,         dstHJ      )
    VertexCover:AddConnection( gNodeJ,      gNodeK,         dstJK      )
    VertexCover:AddConnection( gNodeJ,      gNodeL,         dstJL      )
    VertexCover:AddConnection( gNodeL,      gNodeM,         dstLM      )
    VertexCover:AddConnection( gNodeL,      gNodeAI,        dstLAI     )
    VertexCover:AddConnection( gNodeN,      gNodeO,         dstNO      )
    VertexCover:AddConnection( gNodeN,      gNodeR,         dstNR      )
    VertexCover:AddConnection( gNodeO,      gNodeS,         dstOS      )
    VertexCover:AddConnection( gNodeO,      gNodeP,         dstOP      )
    VertexCover:AddConnection( gNodeP,      gNodeQ,         dstPQ      )
    VertexCover:AddConnection( gNodeR,      gNodeS,         dstRS      )
    VertexCover:AddConnection( gNodeR,      gNodeU,         dstRU      )
    VertexCover:AddConnection( gNodeS,      gNodeV,         dstSV      )
    VertexCover:AddConnection( gNodeT,      gNodeAA,        dstTAA     )
    VertexCover:AddConnection( gNodeT,      gNodeU,         dstTU      )
    VertexCover:AddConnection( gNodeU,      gNodeX,         dstUX      )
    VertexCover:AddConnection( gNodeU,      gNodeV,         dstUV      )
    VertexCover:AddConnection( gNodeV,      gNodeW,         dstVW      )
    VertexCover:AddConnection( gNodeW,      gNodeZ,         dstWZ      )
    VertexCover:AddConnection( gNodeX,      gNodeAB,        dstXAB     )
    VertexCover:AddConnection( gNodeX,      gNodeY,         dstXY      )
    VertexCover:AddConnection( gNodeY,      gNodeAC,        dstYC      )
    VertexCover:AddConnection( gNodeY,      gNodeZ,         dstYZ      )
    VertexCover:AddConnection( gNodeZ,      gNodeAD,        dstZAD     )
    VertexCover:AddConnection( gNodeAA,     gNodeAB,        dstAAAB    )
    VertexCover:AddConnection( gNodeAB,     gNodeAF,        dstABAF    )
    VertexCover:AddConnection( gNodeAB,     gNodeAC,        dstABAC    )
    VertexCover:AddConnection( gNodeAC,     gNodeAG,        dstACAG    )
    VertexCover:AddConnection( gNodeAC,     gNodeAD,        dstACAD    )
    VertexCover:AddConnection( gNodeAD,     gNodeAH,        dstADAH    )
    VertexCover:AddConnection( gNodeAE,     gNodeAS,        dstAEAS    )
    VertexCover:AddConnection( gNodeAE,     gNodeAF,        dstAEAF    )
    VertexCover:AddConnection( gNodeAF,     gNodeAK,        dstAFAK    )
    VertexCover:AddConnection( gNodeAF,     gNodeAG,        dstAFAG    )
    VertexCover:AddConnection( gNodeAG,     gNodeAL,        dstAGAL    )
    VertexCover:AddConnection( gNodeAG,     gNodeAH,        dstAGAH    )
    VertexCover:AddConnection( gNodeAH,     gNodeAN,        dstAHAN    )
    VertexCover:AddConnection( gNodeAH,     gNodeAI,        dstAHAI    )
    VertexCover:AddConnection( gNodeAI,     gNodeAJ,        dstAIAJ    )
    VertexCover:AddConnection( gNodeAK,     gNodeAO,        dstAKAO    )
    VertexCover:AddConnection( gNodeAK,     gNodeAL,        dstAKAL    )
    VertexCover:AddConnection( gNodeAL,     gNodeAP,        dstALAP    )
    VertexCover:AddConnection( gNodeAL,     gNodeAM,        dstALAM    )
    VertexCover:AddConnection( gNodeAM,     gNodeAQ,        dstAMAQ    )
    VertexCover:AddConnection( gNodeAM,     gNodeAN,        dstAMAN    )
    VertexCover:AddConnection( gNodeAO,     gNodeAP,        dstAOAP    )
    VertexCover:AddConnection( gNodeAP,     gNodeAQ,        dstAPAQ    )
    VertexCover:AddConnection( gNodeAS,     gNodeAR,        dstASAR    )
    VertexCover:AddConnection( gNodeAS,     gNodeAT,        dstASAT    )
    VertexCover:AddConnection( gNodeAS,     gNodeAV,        dstASAV    )
    VertexCover:AddConnection( gNodeAR,     gNodeAU,        dstARAU    )
    VertexCover:AddConnection( gNodeAU,     gNodeAV,        dstAUAV    )

    table.insert( gNodeList, gNodeA )
    table.insert( gNodeList, gNodeB  )
    table.insert( gNodeList, gNodeC  )
    table.insert( gNodeList, gNodeD  )
    table.insert( gNodeList, gNodeE  )
    table.insert( gNodeList, gNodeF  )
    table.insert( gNodeList, gNodeG  )
    table.insert( gNodeList, gNodeH  )
    table.insert( gNodeList, gNodeI  )
    table.insert( gNodeList, gNodeJ  )
    table.insert( gNodeList, gNodeK  )
    table.insert( gNodeList, gNodeL  )
    table.insert( gNodeList, gNodeM  )
    table.insert( gNodeList, gNodeN  )
    table.insert( gNodeList, gNodeO  )
    table.insert( gNodeList, gNodeP  )
    table.insert( gNodeList, gNodeQ  )
    table.insert( gNodeList, gNodeR  )
    table.insert( gNodeList, gNodeS  )
    table.insert( gNodeList, gNodeT  )
    table.insert( gNodeList, gNodeU  )
    table.insert( gNodeList, gNodeV  )
    table.insert( gNodeList, gNodeW  )
    table.insert( gNodeList, gNodeX  )
    table.insert( gNodeList, gNodeY  )
    table.insert( gNodeList, gNodeZ  )
    table.insert( gNodeList, gNodeAA )
    table.insert( gNodeList, gNodeAB )
    table.insert( gNodeList, gNodeAC )
    table.insert( gNodeList, gNodeAD )
    table.insert( gNodeList, gNodeAE )
    table.insert( gNodeList, gNodeAF )
    table.insert( gNodeList, gNodeAG )
    table.insert( gNodeList, gNodeAH )
    table.insert( gNodeList, gNodeAI )
    table.insert( gNodeList, gNodeAJ )
    table.insert( gNodeList, gNodeAK )
    table.insert( gNodeList, gNodeAL )
    table.insert( gNodeList, gNodeAM )
    table.insert( gNodeList, gNodeAN )
    table.insert( gNodeList, gNodeAO )
    table.insert( gNodeList, gNodeAP )
    table.insert( gNodeList, gNodeAQ )
    table.insert( gNodeList, gNodeAR )
    table.insert( gNodeList, gNodeAS )
    table.insert( gNodeList, gNodeAT )
    table.insert( gNodeList, gNodeAU )
    table.insert( gNodeList, gNodeAV )

    -- BUILDING THE ARRAY, UNCOMMENT IF THE NODE CHANGED AND YOU WANT TO UPDATE THE FILE

    --for i=1, #gNodeList do
    --    local nodeA = gNodeList[i]
    --
    --    for j=1, #gNodeList do
--
    --        local nodeB = gNodeList[j]
    --        local stringKeyAB = VertexCover:StringKey( nodeA, nodeB )
    --        Base:log( stringKeyAB )
    --        if( gPrecomputedNodeSequences[ stringKeyAB ] == nil ) then
    --            local result = VertexCover:FindShortestPath( nodeA, nodeB )
    --            self:SubSplitResult( result )
    --        end
    --
    --    end
    --end
--
    --self:SavePrecomputedNodeSequences()

    self:LoadPrecomputedNodeSequences()
end



function Level1:SubSplitResult( iResult )

    --local startIndex = 1
    local endIndex   = #iResult

    for i=1, #iResult do

        local localResultTable = {}
        table.insert( localResultTable, iResult[i] )

        for j=i+1, #iResult do

            table.insert( localResultTable, iResult[j] )
            local stringKeyAB = VertexCover:StringKey( localResultTable[1], localResultTable[#localResultTable] )
            local stringKeyBA = VertexCover:StringKey( localResultTable[#localResultTable], localResultTable[1] )
            gPrecomputedNodeSequences[ stringKeyAB ] = {}
            gPrecomputedNodeSequences[ stringKeyBA ] = {}
            gPrecomputedNodeSequences[ stringKeyAB ] = shallowCopy( localResultTable )
            gPrecomputedNodeSequences[ stringKeyBA ] = ReverseTable( localResultTable )
        end
    end
end


function  Level1:SavePrecomputedNodeSequences()
   filePath = "Config/nodePattern.ini"
   local fileData = ""
        for k,v in pairs( gPrecomputedNodeSequences ) do

            fileData = fileData .. k .. ":"

            for j=1, #v do
                fileData = fileData .. v[j].mName .. ","
            end

            fileData = fileData .. "\n"

        end
   local file = io.open( filePath, "w" )
   file:write( fileData )
   file:flush()
   file:close()
end


function  Level1:LoadPrecomputedNodeSequences()

    filePath = "Config/nodePattern.ini"
    local file = io.open( filePath )
    local fileData = file:read( '*all' )
    local fileDataSplit = SplitString( fileData, "\n" )

    for k,v in pairs( fileDataSplit ) do

        local subSplitEntry = SplitString( v, ":" )
        local stringKey = subSplitEntry[ 1 ]
        local stringArray = subSplitEntry[ 2 ]
        local subSliptArray = SplitString( stringArray, "," )
        gPrecomputedNodeSequences[ stringKey ] = self:BuildNodeArrayFromStringArray( subSliptArray )
    end
    file:close()

end

function  Level1:BuildNodeArrayFromStringArray( iStringArray )

    local nodeArray = {}
    for i=1, #iStringArray do
        for j=1, #gNodeList do
            if( iStringArray[i] == gNodeList[j].mName ) then
                table.insert( nodeArray, gNodeList[j] )
            end
        end
    end
    return nodeArray
end

return  Level1