
BigImage = require("src/Image/BigImage")


ImageLoader = {
    mAnimationsBigImage = {}, -- Both tables needs to be synchrone : #mAnimationsBigImage == #mAnimationFileNames
    mAnimationFileNames = {}
}


function  ImageLoader.LoadAnimationFile( iFileName, iImageCount )

    assert( #mAnimationsBigImage == #mAnimationFileNames )

    for k,v in pairs( ImageLoader.mAnimationFileNames ) do
        if( v == iFileName ) then
            return  ImageLoader.mAnimationsBigImage[ k ]
        end
    end

    -- From here, we didn't find the required file in existing list, so we load it
    image = love.graphics.newImage( iFileName )
    table.insert ( ImageLoader.mAnimationsBigImage, BigImage:NewFromImage( image, image:getWidth(), iImageCount ) )
    table.insert ( ImageLoader.mAnimationFileNames, iFileName )

    return  love.graphics.newImage( ImageLoader.mAnimationsBigImage[ #ImageLoader.mAnimationsBigImage ] )

end


function  ImageLoader.Clear()

    for k in pairs( ImageLoader.mAnimationsBigImage ) do
        ImageLoader.mAnimationsBigImage[ k ]  =  nil
        ImageLoader.mAnimationFileNames[ k ]  =  nil
    end

end


return  ImageLoader

