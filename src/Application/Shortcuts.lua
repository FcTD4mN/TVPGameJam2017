-- The shortcut map thing

Shortcuts = {

    mShortcutTable = {}
}


function Shortcuts.Initialize()

    Shortcuts.Load();

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


function  Shortcuts.Save()

    local keybindsData = ""

    for k,v in pairs( Shortcuts.mShortcutTable ) do
        keybindsData = keybindsData .. k .. ":" .. v .. "\n"
    end

    local file = io.open( "Config/keybinds.ini", "w" )
    file:write( keybindsData )

end


function  Shortcuts.Load()

    local shortcuts = io.open( 'Config/keybinds.ini' ):read( '*all' )
    local shortcutsSplit = SplitString( shortcuts, "\n" )

    for k,v in pairs( shortcutsSplit ) do

        local subSplit = SplitString( v, ":" )
        Shortcuts.mShortcutTable[ subSplit[ 1 ] ] = subSplit[ 2 ]

    end

end


return  Shortcuts
