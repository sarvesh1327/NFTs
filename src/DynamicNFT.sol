// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract DynamicNFT is ERC721 {
    //errors
    error DynamicNFT__NotOwnerOrApproved();

    // storage
    uint256 private s_tokenCounter;
    string private s_happySvgImageUri;
    string private s_sadSvgImageUri;

    enum MOOD {
        SAD,
        HAPPY
    }

    mapping(uint256 => MOOD) private s_tokenIdToMood;

    constructor(
        string memory happySvgImageUri,
        string memory sadSvgImageUri
    ) ERC721("Dynamic NFT", "DNF") {
        s_tokenCounter = 0;
        s_happySvgImageUri = happySvgImageUri;
        s_sadSvgImageUri = sadSvgImageUri;
    }

    function mint() public returns(uint256){
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenIdToMood[s_tokenCounter] = MOOD.HAPPY;
        s_tokenCounter += 1;
        return s_tokenCounter-1;
    }

    function flipMood(uint256 tokenId) public {
        if (msg.sender != ownerOf(tokenId) && msg.sender!=getApproved(tokenId)) {
            revert DynamicNFT__NotOwnerOrApproved();
        }
        if (s_tokenIdToMood[tokenId] == MOOD.HAPPY) {
            s_tokenIdToMood[tokenId] = MOOD.SAD;
        } else {
            s_tokenIdToMood[tokenId] = MOOD.HAPPY;
        }
    }

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64, ";
    }

    function tokenURI(
        uint256 tokenId
    ) public view override returns (string memory) {
        string memory imageUri = s_tokenIdToMood[tokenId] == MOOD.HAPPY
            ? s_happySvgImageUri
            : s_sadSvgImageUri;
        bytes memory data = bytes(
            abi.encodePacked(
                '{"name": "',
                name(),
                '", "description": "An NFT that reflects owners mood.", "attributes": [{"trait_type": "moodiness", "value": "100"}], "image": "',
                imageUri,
                '"}'
            )
        );
        return string(abi.encodePacked(_baseURI(), Base64.encode(data)));
    }
}
