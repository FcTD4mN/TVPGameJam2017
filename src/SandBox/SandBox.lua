local SandBox = {}

function SandBox:Initialize()
end


function SandBox:Update( dt )

    return 2 -- kSandBox = 2

end


function SandBox:Draw()
    love.graphics.clear( 200, 200, 200, 255 )
end


function SandBox:KeyPressed( key, scancode, isrepeat )
end

function SandBox:KeyReleased( key, scancode )
end

function  SandBox:mousepressed( iX, iY, iButton, iIsTouch )
end

return SandBox