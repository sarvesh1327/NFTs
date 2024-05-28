// SPDX-License-Identifier:MIT

pragma solidity ^0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {DynamicNFT} from "../src/DynamicNFT.sol";
import {DeployDynamicNFT} from "../script/DeployDynamicNFT.s.sol";

contract DynamicNFTTest is Test {
    DynamicNFT public dynamicNFT;
    string private constant nameOfNFT = "Dynamic NFT";
    address public USER = makeAddr("USER");

    function setUp() external {
        DeployDynamicNFT deployDynamicNFT = new DeployDynamicNFT();
        dynamicNFT = deployDynamicNFT.run();
    }

    function testNameIsCorrect() public view {
        //Arrange/Act
        string memory name = dynamicNFT.name();
        bytes32 nameOfNFTHash = keccak256(abi.encodePacked(nameOfNFT));
        bytes32 nameHash = keccak256(abi.encodePacked(name));
        //assert
        assertEq(nameOfNFT, name);
        //or
        assert(nameHash == nameOfNFTHash);
    }


    function testViewTokenURI() public {
        // Arrange 
        uint256 tokenId = 0;

        //Act
        vm.prank(USER);
        dynamicNFT.mint();

        string memory tokenUri = dynamicNFT.tokenURI(tokenId);
        console.log(tokenUri);
        // assert

    }

    function testFlipMoodToSad() public {
        // Arrange 
        uint256 tokenId = 0;

        //Act
        vm.prank(USER);
        dynamicNFT.mint();
        string memory tokenUriHappy = dynamicNFT.tokenURI(tokenId);

         vm.prank(USER);
        dynamicNFT.flipMood(tokenId);

        string memory tokenUriSad = dynamicNFT.tokenURI(tokenId);
        // assert
        console.log(tokenUriHappy, tokenUriSad);
        assertNotEq(tokenUriHappy, tokenUriSad);
    }
}