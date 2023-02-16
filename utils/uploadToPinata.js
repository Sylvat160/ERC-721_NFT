const pinataSDK = require('@pinata/sdk')
const fs = require('fs')
const path = require('path')

async function storeImages(imagePath) {
    const fullImagesPath = path.resolve(imagePath)
    const files = fs.readdirSync(fullImagesPath)
    console.log(files)
}

module.exports = {
    storeImages
}