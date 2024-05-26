// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {SimpleNFT} from "../src/SimpleNFT.sol";

contract DeploySimpleNFT is Script {
    function run() external returns (SimpleNFT) {
        vm.startBroadcast();
        SimpleNFT simpleNFT = new SimpleNFT();
        vm.stopBroadcast();
        return simpleNFT;
    }
}
