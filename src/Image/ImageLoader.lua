
BigImage = require("src/Image/BigImage")


ImageLoader = {
    mBigImages              = {}, -- Both tables needs to be synchrone : #mBigImages == #mBigImageFileNames
    mBigImageFileNames      = {},

    mSimpleImages           = {}, -- Both tables needs to be synchrone : #mSimpleImages == #mSimpleImageFileNames
    mSimpleImageFileNames   = {}
}


-- This method is used to load a BigImage
function  ImageLoader.LoadBigImage( iFileName, iTileWidth )

    assert( #mBigImages == #mBigImageFileNames )

    for k,v in pairs( ImageLoader.mBigImageFileNames ) do
        if( v == iFileName ) then
            return  ImageLoader.mBigImages[ k ]
        end
    end

    -- From here, we didn't find the required file in existing list, so we load it
    table.insert ( ImageLoader.mBigImages,          BigImage:New( love.graphics.newImage( iFileName ), iTileWidth ) )
    table.insert ( ImageLoader.mBigImageFileNames,  iFileName )

    return  ImageLoader.mBigImages[ #ImageLoader.mBigImages ]

end


-- This method is used to load a simple love.graphics.newImage
function  ImageLoader.LoadSimpleImage( iFileName )

    assert( #ImageLoader.mSimpleImages == #ImageLoader.mSimpleImageFileNames )

    for k,v in pairs( ImageLoader.mSimpleImageFileNames ) do
        if( v == iFileName ) then
            return  ImageLoader.mSimpleImages[ k ]
        end
    end

    -- From here, we didn't find the required file in existing list, so we load it
    table.insert ( ImageLoader.mSimpleImages,           love.graphics.newImage( iFileName ) )
    table.insert ( ImageLoader.mSimpleImageFileNames,   iFileName )

    return  ImageLoader.mSimpleImages[ #ImageLoader.mSimpleImages ]

end


function  ImageLoader.Clear()

    for k in pairs( ImageLoader.mBigImages ) do
        ImageLoader.mBigImages[ k ]        = nil
        ImageLoader.mBigImageFileNames[ k ]    = nil
    end

    for k in pairs( ImageLoader.mSimpleImages ) do
        ImageLoader.mSimpleImages[ k ]          = nil
        ImageLoader.mSimpleImageFileNames[ k ]  = nil
    end

end


return  ImageLoader

