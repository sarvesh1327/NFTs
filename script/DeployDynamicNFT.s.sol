// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {DynamicNFT} from "../src/DynamicNFT.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract DeployDynamicNFT is Script {
    function run() external returns (DynamicNFT) {
        string memory happySvg = vm.readFile("./img/happy.svg");
        string memory sadSvg = vm.readFile("./img/sad.svg");
        vm.startBroadcast();
        DynamicNFT dynamicNFT = new DynamicNFT(
            svgToImageUrl(happySvg),
            svgToImageUrl(sadSvg)
        );
        vm.stopBroadcast();
        return dynamicNFT;
    }

    function svgToImageUrl(
        string memory svg
    ) public pure returns (string memory) {
        string memory baseURL = "data:image/svg+xml;base64,";
        string memory base64Encoded = Base64.encode(
            bytes(string(abi.encodePacked(svg)))
        );
        return string(abi.encodePacked(baseURL, base64Encoded));
    }
}
