-- The shortcut map thing

Shortcuts = {

    mShortcutTable = {};
    mModelShortcutTable = {};
    mModelShortcutTableINDEXER = {};
    mIteration = 2;
    mMaxShortcut = 0
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
    local counter = 1

    for k,v in pairs( shortcutsSplit ) do

        local subSplit = SplitString( v, ":" )
        Shortcuts.Register( subSplit[ 1 ], subSplit[ 2 ], counter )
        counter = counter + 1
    end

    Shortcuts.mMaxShortcut = counter
end

function  Shortcuts.Register( action, key, iCounter )
        Shortcuts.mModelShortcutTable[ action ] = key
        Shortcuts.mModelShortcutTableINDEXER[ iCounter ] = action
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

    if( Shortcuts.mIteration >= Shortcuts.mMaxShortcut ) then
        return;
    end

    local newAction = Shortcuts.mModelShortcutTableINDEXER[ Shortcuts.mIteration ]
    Shortcuts.mShortcutTable[ newAction ] = Shortcuts.mModelShortcutTable[ newAction ]

    Shortcuts.mIteration = Shortcuts.mIteration + 1

end

function  Shortcuts.Sync()

    for iteration = 1, Shortcuts.mIteration do

        local newAction = Shortcuts.mModelShortcutTableINDEXER[ iteration ]
        Shortcuts.mShortcutTable[ newAction ] = Shortcuts.mModelShortcutTable[ newAction ]

    end
end



return  Shortcuts
