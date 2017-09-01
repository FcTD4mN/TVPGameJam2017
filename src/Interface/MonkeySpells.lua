local FixedImage    = require( "src/Image/FixedImage" )

MonkeySpells = {}


-- ==========================================Build/Destroy


function  MonkeySpells.Initialize()
    MonkeySpells.image = FixedImage:New( "resources/Images/Objects/cadran-singe.png", 30, 460, 100, 100, 0, true )
end


-- ==========================================Type


function MonkeySpells.Type()
    return "MonkeySpells"
end


-- ==========================================Update/Draw


function MonkeySpells.Draw()
    MonkeySpells.image:Draw()
end


-- ==========================================MonkeySpells actions

-- Switch spells


return  MonkeySpells