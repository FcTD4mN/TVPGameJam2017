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


function  Shortcuts.Save( iFilePath )

    local filePath = iFilePath
    if filePath == nil then
        filePath = "Config/keybinds.ini"
    end

    local keybindsData = ""

    for k,v in pairs( Shortcuts.mShortcutTable ) do
        keybindsData = keybindsData .. k .. ":" .. v .. "\n"
    end

    local file = io.open( filePath, "w" )
    file:write( keybindsData )

end


function  Shortcuts.Load( iFilePath )

    local filePath = iFilePath
    if filePath == nil then
        filePath = "Config/keybinds.ini"
    end

    local shortcuts = io.open( filePath ):read( '*all' )
    local shortcutsSplit = SplitString( shortcuts, "\n" )

    for k,v in pairs( shortcutsSplit ) do

        local subSplit = SplitString( v, ":" )
        Shortcuts.Register( subSplit[ 1 ], subSplit[ 2 ] )
    end
end

function  Shortcuts.Register( action, key )
        Shortcuts.mShortcutTable[ action ] = key
end

function  Shortcuts.Unregister( action, key )
        Shortcuts.mShortcutTable[ action ] = nil
end

function  Shortcuts.Cleanse()
    for k,v in pairs( Shortcuts.mShortcutTable ) do
        Shortcuts.mShortcutTable[ k ] = nil
    end
end


return  Shortcuts
