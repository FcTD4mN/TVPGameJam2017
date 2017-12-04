-- The shortcut map thing

ShortcutsDisplay = {
    mAvailableShortcuts = {};
    mLast = 0;
    mFontL = love.graphics.newFont("resources/Fonts/ariblk.ttf", 16 );
    mFontR = love.graphics.newFont("resources/Fonts/arial.ttf", 16 );
    mPadding = 10;
    mSpace = 2;
    mLineHeight = 36;
    mKeyW = 20;
    mKeyH = 20;
    mLetterW = 16;
    mBorderRadius = 2;
    mInnerPadding = 5;
    mYShift = 2;
    mXShift = 5;
}

function ShortcutsDisplay.AddEntry( iAction, iKey )
    ShortcutsDisplay.mAvailableShortcuts[ShortcutsDisplay.mLast] = {}
    ShortcutsDisplay.mAvailableShortcuts[ShortcutsDisplay.mLast].mAction = string.upper( iAction )
    ShortcutsDisplay.mAvailableShortcuts[ShortcutsDisplay.mLast].mKey = string.upper( iKey )
    ShortcutsDisplay.mLast = ShortcutsDisplay.mLast + 1
    print( "entry registered in shortcutdisplay")
end

function ShortcutsDisplay.Draw()
    love.graphics.setColor( 255, 255, 255 , 255 )
    for i=0, ShortcutsDisplay.mLast-1, 1 do
        ShortcutsDisplay.DrawEntry( i )
    end
end

function ShortcutsDisplay.DrawEntry( iN )

    local action    = ShortcutsDisplay.mAvailableShortcuts[iN].mAction
    local key       = ShortcutsDisplay.mAvailableShortcuts[iN].mKey
    local keylen = string.len(key)
    local xs = ShortcutsDisplay.mPadding
    local ys = ShortcutsDisplay.mPadding + ( ShortcutsDisplay.mLineHeight +  ShortcutsDisplay.mSpace ) * iN
    local ws = keylen * ShortcutsDisplay.mLetterW + ShortcutsDisplay.mInnerPadding * 2
    local hs = ShortcutsDisplay.mKeyH + ShortcutsDisplay.mInnerPadding * 2
    love.graphics.rectangle( "line", xs, ys, ws, hs, ShortcutsDisplay.mBorderRadius, ShortcutsDisplay.mBorderRadius )
    love.graphics.setFont( ShortcutsDisplay.mFontL )
    local str = key
    xs = xs + ShortcutsDisplay.mInnerPadding + ShortcutsDisplay.mXShift 
    ys = ys + ShortcutsDisplay.mInnerPadding - ShortcutsDisplay.mYShift
    love.graphics.print( str, xs, ys  )
    love.graphics.setFont( ShortcutsDisplay.mFontR )
    xs = xs + ws     
    ys = ys + ShortcutsDisplay.mYShift * 2
    local str = action    
    love.graphics.print( " : " .. str, xs, ys  )
    
    
end

return  ShortcutsDisplay
