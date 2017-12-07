local ShortcutsDisplay = require( "src/Application/ShortcutsDisplay" )

-- The shortcut map thing

Shortcuts = {
    mShortcutTable = {};
    mShortcutMap = {}
}

function Shortcuts.Initialize()

    --Shortcuts.Load();
    Shortcuts.LoadShortcutMap();
    math.randomseed( os.time() )
end


function  Shortcuts.GetKeyForAction( iAction )

    if( Shortcuts.mShortcutTable[ iAction ] ~= nil ) then
        return  Shortcuts.mShortcutTable[ iAction ]
    end

    return  nil

end


function  Shortcuts.GetActionForKey( iKey )

    for k, v in pairs( Shortcuts.mShortcutTable ) do

        if v == iKey then
            return  k
        end

    end

    return  "none"

end


--function  Shortcuts.Save()
--    filePath = "Config/keybinds.ini"
--    local keybindsData = ""

--    for k,v in pairs( Shortcuts.mShortcutTable ) do
--        keybindsData = keybindsData .. k .. ":" .. v .. "\n"
--    end

--    local file = io.open( filePath, "w" )
--    file:write( keybindsData )
--end


function  Shortcuts.LoadShortcutMap()
    filePath = "Config/shortcutmap.ini"
    local shortcuts = io.open( filePath ):read( '*all' )
    local shortcutsSplit = SplitString( shortcuts, "\n" )
    local counter = 1

    for k,v in pairs( shortcutsSplit ) do
        Shortcuts.mShortcutMap[ counter ] = v
        counter = counter + 1
    end
end

function  Shortcuts.Register( action, key )
        Shortcuts.mShortcutTable[ action ] = key
        ShortcutsDisplay.AddEntry( action, key )
end

function  Shortcuts.Unregister( action, key )
        Shortcuts.mShortcutTable[ action ] = nil
end

function  Shortcuts.Cleanse()
    for k,v in pairs( Shortcuts.mShortcutTable ) do
        Shortcuts.mShortcutTable[ k ] = nil
    end
end

function  Shortcuts.SeekRandomKey()
    local size = #Shortcuts.mShortcutMap
    local key
    local isRegistered
    repeat
        local index = math.floor( love.math.random() * ( size - 1 ) ) + 1
        key = Shortcuts.mShortcutMap[ index ]
        isRegistered = Shortcuts.KeyIsRegistered( key )
    until isRegistered == false

    return key
end

function  Shortcuts.RegisterActionWithRandomKey( iAction )


    print("_")
    print("Function:RegisterActionWithRandomKey")
    if( Shortcuts.ActionIsRegistered( iAction ) == true ) then
        print("Alerady Registered")
        return
    end
    key = Shortcuts.SeekRandomKey()
    Shortcuts.Register( iAction, key )
    print("Registered: " .. iAction .. " | " .. key )
end

function  Shortcuts.KeyIsRegistered( iKey )
    for k,v in pairs( Shortcuts.mShortcutTable ) do
        if ( v == iKey  ) then
            return true
        end
    end
    return  false
end

function  Shortcuts.ActionIsRegistered( iAction )
    if ( Shortcuts.mShortcutTable[ iAction ] == nil ) then
        return  false;
    end
    return true
end

return  Shortcuts
