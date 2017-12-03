-- The shortcut map thing

Shortcuts = {

    mShortcutTable = {};
    mModelShortcutTable = {};
    mIteration = 1;
}


function Shortcuts.Initialize()

    Shortcuts.Load();
    Shortcuts.Sync();
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
        Shortcuts.mModelShortcutTable[ action ] = key
end

function  Shortcuts.Unregister( action, key )
        Shortcuts.mModelShortcutTable[ action ] = nil
end

function  Shortcuts.Cleanse()
    for k,v in pairs( Shortcuts.mShortcutTable ) do
        Shortcuts.mShortcutTable[ k ] = nil
    end
end

function  Shortcuts.Iterate()
    Shortcuts.mIteration = Shortcuts.mIteration + 1
    Shortcuts.Sync()
end

function  Shortcuts.Sync()
    local iteration = 1
    print(  Shortcuts.mIteration  )
    
    for k,v in pairs( Shortcuts.mModelShortcutTable ) do

        if iteration < Shortcuts.mIteration then
            Shortcuts.mShortcutTable[ k ] = Shortcuts.mModelShortcutTable[k]
        end
        
        iteration = iteration+1
    end
end


return  Shortcuts
