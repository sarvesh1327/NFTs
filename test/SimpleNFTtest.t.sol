// SPDX-License-Identifier:MIT

pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {SimpleNFT} from "../src/SimpleNFT.sol";
import {DeploySimpleNFT} from "../script/DeploySimpleNFT.s.sol";

contract SimpleNFTTest is Test {
    SimpleNFT public simpleNFT;
    string private constant nameOfNFT = "DogNFT";
    address public USER = makeAddr("USER");

    function setUp() external {
        DeploySimpleNFT deploySimpleNFT = new DeploySimpleNFT();
        simpleNFT = deploySimpleNFT.run();
    }

    function testNameIsCorrect() public view {
        //Arrange/Act
        string memory name = simpleNFT.name();
        bytes32 nameOfNFTHash = keccak256(abi.encodePacked(nameOfNFT));
        bytes32 nameHash = keccak256(abi.encodePacked(name));
        //assert
        assertEq(nameOfNFT, name);
        //or
        assert(nameHash == nameOfNFTHash);
    }

    function testCanMintANdHaveABalance() public {
        //Arrange
        string memory tokenURI = "https://bafybeid2v73os22vppshtyh6at2wt2budd7i5a4vdhwnzzdpuodwpls3ie.ipfs.w3s.link";
        uint256 tokenId = 0;

        //Act
        vm.prank(USER);
        simpleNFT.mint(tokenURI);

        //assert
        assertEq(tokenURI, simpleNFT.tokenURI(tokenId));
        assertEq(simpleNFT.balanceOf(USER), 1);

    }
}
