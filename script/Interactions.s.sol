//SPDX-License-Identifier:MIT
pragma solidity ^0.8.22;

import {Script, console} from "forge-std/Script.sol";
import {DevOpsTools} from "../lib/foundry-devops/src/DevOpsTools.sol";
import {FundMe} from "../src/FundMe.sol";

contract FundFundme is Script {
    uint256 public SEND_MONEY = 0.1 ether;

    function Fundme(address mostrecentlyDeployed) public {
        vm.startBroadcast();
        FundMe(payable(mostrecentlyDeployed)).fund{value: SEND_MONEY}();
        vm.stopBroadcast();

        console.log("Fund me %s", SEND_MONEY);
    }

    function run() external {
        address recentdeployaddr = DevOpsTools.get_most_recent_deployment(
            "FundMe",
            block.chainid
        );
        Fundme(recentdeployaddr);
    }
}

contract withdrawFundme is Script {
    uint256 public SEND_MONEY = 0.1 ether;
    FundMe fundme;

    function withdrawFund(address mostrecentlyDeployed) public {
        vm.startBroadcast();

        FundMe(payable(mostrecentlyDeployed)).withdraw();
        vm.stopBroadcast();
    }

    function run() external {
        address recentdeployaddr = DevOpsTools.get_most_recent_deployment(
            "FundMe",
            block.chainid
        );
        // vm.startBroadcast();
        withdrawFund(recentdeployaddr);
        // vm.stopBroadcast();
    }
}
