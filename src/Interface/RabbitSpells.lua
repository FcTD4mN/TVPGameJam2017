local FixedImage    = require( "src/Image/FixedImage" )

RabbitSpells = {}


-- ==========================================Build/Destroy


function  RabbitSpells.Initialize()
    RabbitSpells.image = FixedImage:New( "resources/Images/Objects/cadran-lapin.png", 30, 55, 100, 100, 0, true )
end


-- ==========================================Type


function RabbitSpells.Type()
    return "RabbitSpells"
end


-- ==========================================Update/Draw


function RabbitSpells.Draw()
    RabbitSpells.image:Draw()
end


-- ==========================================RabbitSpells actions

-- Switch spells


return  RabbitSpells