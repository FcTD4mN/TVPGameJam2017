-- The shortcut map thing

Shortcuts = {
    mShortcutTable = {},
    mActiveShortcuts = {},
    mLoaded = false
}

function Shortcuts.Initialize()

    Shortcuts.Load();
    Shortcuts.mLoaded = true

end


function  Shortcuts.GetKeyForAction( iAction )

    if( Shortcuts.mActiveShortcuts[ iAction ] ~= nil ) then
        return  Shortcuts.mActiveShortcuts[ iAction ]
    end
    return  nil

end


function  Shortcuts.GetActionForKey( iKey )

    for k, v in pairs( Shortcuts.mActiveShortcuts ) do
        if v == iKey then
            return  k
        end
    end
    return  "none"

end


--==============================================

function  Shortcuts.Save()
   filePath = "Config/keybinds.ini"
   local keybindsData = ""

   for k,v in pairs( Shortcuts.mShortcutTable ) do
       keybindsData = keybindsData .. k .. ":" .. v .. "\n"
   end

   local file = io.open( filePath, "w" )
   file:write( keybindsData )
   file:flush()
   file:close()
end


function  Shortcuts.Load()

    filePath = "Config/keybinds.ini"
    local file = io.open( filePath )
    local shortcuts = file:read( '*all' )
    local shortcutsSplit = SplitString( shortcuts, "\n" )

    for k,v in pairs( shortcutsSplit ) do

        local subSplit = SplitString( v, ":" )
        Shortcuts.mShortcutTable[ subSplit[ 1 ] ] = subSplit[ 2 ]

    end
    file:close()

end


--==============================================

function  Shortcuts.RegisterAllActions()
    for k,v in pairs( Shortcuts.mShortcutTable ) do
        Shortcuts.mActiveShortcuts[ k ] = v
    end
end

function  Shortcuts.UnregisterAllActions()
    for k,v in pairs( Shortcuts.mActiveShortcuts ) do
        Shortcuts.mActiveShortcuts[ k ] = nil
    end
end


--==============================================

function  Shortcuts.RegisterAction( iAction )
        Shortcuts.mActiveShortcuts[ iAction ] = Shortcuts.mShortcutTable[ iAction ]
end

function  Shortcuts.RegisterActionWithKey( iAction, iKey )
        Shortcuts.mActiveShortcuts[ iAction ] = iKey
end

function  Shortcuts.UnregisterAction( iAction )
        Shortcuts.mActiveShortcuts[ iAction ] = nil
end


--==============================================

function  Shortcuts.IsKeyRegistered( iKey )
    for k,v in pairs( Shortcuts.mActiveShortcuts ) do
        if ( v == iKey  ) then
            return true
        end
    end
    return  false
end

function  Shortcuts.IsActionRegistered( iAction )
    if ( Shortcuts.mActiveShortcuts[ iAction ] == nil ) then
        return  false;
    end
    return true
end

return  Shortcuts
