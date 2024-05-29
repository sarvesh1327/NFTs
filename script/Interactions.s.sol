
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20 ;

import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "../lib/foundry-devops/src/DevOpsTools.sol";
import {SimpleNFT} from "../src/SimpleNFT.sol";
import {DynamicNFT} from "../src/DynamicNFT.sol";

contract MintSimpleNFT is Script {
        string public constant pug = "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json"; 
    function mintNFTOnContract(address mostRecentlyDeployed) public{
        vm.startBroadcast();
        SimpleNFT(mostRecentlyDeployed).mint(pug);
        vm.stopBroadcast();
    }

    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment("SimpleNFT", block.chainid);
        mintNFTOnContract(mostRecentlyDeployed);
    }
}

contract MintDynamicNFT is Script {
    function mintNFTOnContract(address mostRecentlyDeployed) public{
        vm.startBroadcast();
        DynamicNFT(mostRecentlyDeployed).mint();
        vm.stopBroadcast();
    }

    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment("DynamicNFT", block.chainid);
        mintNFTOnContract(mostRecentlyDeployed);
    }
}

contract FlipDynamicNFT is Script {

    function flipMoodOnContract(address mostRecentlyDeployed) public{
        vm.startBroadcast();
        DynamicNFT(mostRecentlyDeployed).flipMood(0);
        vm.stopBroadcast();
    }

    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment("DynamicNFT", block.chainid);
        flipMoodOnContract(mostRecentlyDeployed);
    }
}
