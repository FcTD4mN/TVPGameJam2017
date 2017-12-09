local Shortcuts = require( "src/Application/Shortcuts" )
local ShortcutsDisplay = require( "src/Application/ShortcutsDisplay" )

-- The shortcut map thing

KOPainShortcutsEngine = {
    mKeyPool = {}
}

function KOPainShortcutsEngine.Initialize()

    if not Shortcuts.mLoaded then
        Shortcuts.Load();
    end

    KOPainShortcutsEngine.LoadKeyPool();
    math.randomseed( os.time() )
end


function  KOPainShortcutsEngine.LoadKeyPool()

    filePath = "Config/shortcutmap.ini"
    local file = io.open( filePath )
    local shortcuts = file:read( '*all' )
    local shortcutsSplit = SplitString( shortcuts, "\n" )
    local counter = 1

    for k,v in pairs( shortcutsSplit ) do
        KOPainShortcutsEngine.mKeyPool[ counter ] = v
        counter = counter + 1
    end

    file:close()

end

function  KOPainShortcutsEngine.SeekRandomKey()
    local size = #KOPainShortcutsEngine.mKeyPool
    local key
    local isRegistered
    repeat
        local index = math.floor( love.math.random() * ( size - 1 ) ) + 1
        key = KOPainShortcutsEngine.mKeyPool[ index ]
        isRegistered = Shortcuts.IsKeyRegistered( key )
    until isRegistered == false

    return key
end


function  KOPainShortcutsEngine.RegisterActionWithRandomKey( iAction )

    print("_")
    print("Function:RegisterActionWithRandomKey")
    if Shortcuts.IsActionRegistered( iAction ) then
        print("Alerady Registered")
        return
    end
    key = KOPainShortcutsEngine.SeekRandomKey()
    Shortcuts.RegisterActionWithKey( iAction, key )
    ShortcutsDisplay.AddEntry( iAction, key )
    print("Registered: " .. iAction .. " | " .. key )
end

return  KOPainShortcutsEngine
