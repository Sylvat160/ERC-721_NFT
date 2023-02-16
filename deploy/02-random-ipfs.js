const { network, ethers } = require("hardhat")
const { developmentChains, networkConfig } = require("../helper.config")
const { storeImages } = require("../utils/uploadToPinata")

const imagesLocation = '../images/randomNFT'

module.exports = async ({getNamedAccounts, deployments}) => {
    const {deploy, log} = deployments
    const {deployer} = await getNamedAccounts()
    const chainId = network.config.chainId

    let vrfCoordinatorV2Address, subscriptionId, tokenUris

    // pinata / nft.storage / ipfs
    if (process.env.UPLOAD_TO_PINATA = "true") {
        tokenUris = await handleTokenUris()
    }

    if (developmentChains.includes(network.name)) {
        const vrfCoordinatorV2Mock = await ethers.getContract("VRFCoordinatorV2Mock")
        vrfCoordinatorV2Address = vrfCoordinatorV2Mock.address
        const tx = await vrfCoordinatorV2Mock.createSubscription()
        const txReceipt = await tx.wait(1)
        subscriptionId = txReceipt.events[0].args.subId 
    }
    else {
        vrfCoordinatorV2Address = networkConfig[chainId].vrfCoordinatorV2
        subscriptionId = networkConfig[chainId].subscriptionId
    }
    log("___________---__________")
    await storeImages(imagesLocation)
    // const args = [
    //     vrfCoordinatorV2Address, 
    //     subscriptionId, 
    //     networkConfig[chainId].gasLane, 
    //     networkConfig[chainId].callbackGasLimit,
    //     //tokenUris
    //     networkConfig[chainId].minFee
    // ]
}

async function handleTokenUris() {
    tokenUris = []
    //Store the images to ipfs

    return tokenUris
}

module.exports.tags = ['all', 'randomipfs', 'main']