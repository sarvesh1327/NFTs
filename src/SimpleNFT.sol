// SPDX-License-Identifier:MIT
pragma solidity ^0.8.20;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract SimpleNFT is ERC721 {

    uint256 private s_tokenCounter;
    mapping(uint256=>string) private s_tokeURIs;

    constructor() ERC721("DogNFT", "DFT"){
        s_tokenCounter=0;
    }

    function mint(string memory _tokenURI) public{
        s_tokeURIs[s_tokenCounter]= _tokenURI;
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenCounter++;
    }

    function tokenURI(uint256 tokenId) public view override returns(string memory){
        return s_tokeURIs[tokenId];
    }
}
