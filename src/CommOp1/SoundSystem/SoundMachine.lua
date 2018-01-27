local SoundMachine = {
    mSelectionSounds = {},
    mOrderSounds = {}
}


function SoundMachine:Init()


    table.insert( SoundMachine.mSelectionSounds, love.audio.newSource( "resources/CommOp1/Audio/Repliques/Selection1.mp3", "static" ) )
    table.insert( SoundMachine.mSelectionSounds, love.audio.newSource( "resources/CommOp1/Audio/Repliques/Selection2.mp3", "static" ) )
    table.insert( SoundMachine.mSelectionSounds, love.audio.newSource( "resources/CommOp1/Audio/Repliques/Selection3.mp3", "static" ) )
    table.insert( SoundMachine.mSelectionSounds, love.audio.newSource( "resources/CommOp1/Audio/Repliques/Selection4.mp3", "static" ) )
    table.insert( SoundMachine.mSelectionSounds, love.audio.newSource( "resources/CommOp1/Audio/Repliques/Selection5.mp3", "static" ) )
    table.insert( SoundMachine.mSelectionSounds, love.audio.newSource( "resources/CommOp1/Audio/Repliques/Selection6.mp3", "static" ) )
    table.insert( SoundMachine.mSelectionSounds, love.audio.newSource( "resources/CommOp1/Audio/Repliques/Selection7.mp3", "static" ) )
    table.insert( SoundMachine.mOrderSounds, love.audio.newSource( "resources/CommOp1/Audio/Repliques/Order1.mp3", "static" ) )
    table.insert( SoundMachine.mOrderSounds, love.audio.newSource( "resources/CommOp1/Audio/Repliques/Order2.mp3", "static" ) )
    table.insert( SoundMachine.mOrderSounds, love.audio.newSource( "resources/CommOp1/Audio/Repliques/Order3.mp3", "static" ) )
    table.insert( SoundMachine.mOrderSounds, love.audio.newSource( "resources/CommOp1/Audio/Repliques/Order4.mp3", "static" ) )
    table.insert( SoundMachine.mOrderSounds, love.audio.newSource( "resources/CommOp1/Audio/Repliques/Order5.mp3", "static" ) )
    table.insert( SoundMachine.mOrderSounds, love.audio.newSource( "resources/CommOp1/Audio/Repliques/Order6.mp3", "static" ) )
    table.insert( SoundMachine.mOrderSounds, love.audio.newSource( "resources/CommOp1/Audio/Repliques/Order7.mp3", "static" ) )
    table.insert( SoundMachine.mOrderSounds, love.audio.newSource( "resources/CommOp1/Audio/Repliques/Order8.mp3", "static" ) )

end


function  SoundMachine:PlaySelection()

    love.audio.stop()
    local index = math.random( 7 )
    love.audio.play( SoundMachine.mSelectionSounds[ index ] )

end


function  SoundMachine:PlayOrder()

    love.audio.stop()
    local index = math.random( 8 )
    love.audio.play( SoundMachine.mOrderSounds[ index ] )

end



return  SoundMachine
