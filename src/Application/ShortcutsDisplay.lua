-- The shortcut map thing

ShortcutsDisplay = {
    mAvailableShortcuts = {};
    mLast = 0;
    mFont = love.graphics.newFont("resources/Fonts/tahoma.ttf", 15 );
    mPadding = 10;
    mSpace = 2;
    mLineHeight = 20;
}

function ShortcutsDisplay.AddEntry( iAction, iKey )
    ShortcutsDisplay.mAvailableShortcuts[ShortcutsDisplay.mLast] = {}
    ShortcutsDisplay.mAvailableShortcuts[ShortcutsDisplay.mLast].mAction = iAction
    ShortcutsDisplay.mAvailableShortcuts[ShortcutsDisplay.mLast].mKey = iKey
    ShortcutsDisplay.mLast = ShortcutsDisplay.mLast + 1
    print( "entry registered in shortcutdisplay")
end

function ShortcutsDisplay.Draw()
    love.graphics.setColor( 255, 255, 255 , 255 )
    love.graphics.setFont( ShortcutsDisplay.mFont )
    for i=0, ShortcutsDisplay.mLast-1, 1 do
        ShortcutsDisplay.DrawEntry( i )
    end
end

function ShortcutsDisplay.DrawEntry( iN )
    local action    = ShortcutsDisplay.mAvailableShortcuts[iN].mAction
    local key       = ShortcutsDisplay.mAvailableShortcuts[iN].mKey
    local str = key .. " : " .. action
    love.graphics.print( str, ShortcutsDisplay.mPadding,  ShortcutsDisplay.mPadding + ( ShortcutsDisplay.mLineHeight +  ShortcutsDisplay.mSpace ) * iN )
end

return  ShortcutsDisplay
