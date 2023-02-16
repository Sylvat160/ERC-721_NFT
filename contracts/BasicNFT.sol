//SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

pragma solidity ^0.8.7;

contract BasicNFT is ERC721{
    //

    uint256 private s_tokenCounter;
    string public constant TOKEN_URI = "http://bafybeibrgyezr5muh6qekxsnt4st5ljzz4ed5slivop2vzivgsl2y3ocim.ipfs.localhost:8080/";

    constructor() ERC721 ("KAMITA", "KHMT") {
        s_tokenCounter = 0;
    }

    function mintNft() public returns(uint256) {
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenCounter++;
        return s_tokenCounter;
    }

    function tokenURI(uint256 /*tokenId8*/) public view override returns (string memory) {
        return TOKEN_URI;
    }

    function getTokenCounter() public view returns(uint256) {
        return s_tokenCounter;
    }

}