// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20 ;

import {Test} from "forge-std/Test.sol";
import {DeployDynamicNFT} from "../script/DeployDynamicNFT.s.sol";

contract DeployDynamicNFTTest is Test {
    DeployDynamicNFT public deployDynamicNFT;

    function setUp() external{
        deployDynamicNFT = new DeployDynamicNFT();
    }

    function testSvgToImageUrl() public view {
        string memory expectedUri = "data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSI1MDAiIGhlaWdodD0iNTAwIj48dGV4dCB4PSIwIiB5PSIxMDAiIGZpbGw9IiNjNWJlYmUiPiBIZWxsbyBOZXcgY29tZXJzPC90ZXh0Pjs8L3N2Zz4=";

        string memory svg = '<svg xmlns="http://www.w3.org/2000/svg" width="500" height="500"><text x="0" y="100" fill="#c5bebe"> Hello New comers</text>;</svg>';

        assertEq(expectedUri, deployDynamicNFT.svgToImageUrl(svg));
    } 
}
