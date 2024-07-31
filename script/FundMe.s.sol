// SPDX-License-Identifier:MIT
pragma solidity ^0.8.22;
import {Script} from "forge-std/Script.sol";
import {FundMe} from "../src/FundMe.sol";

contract FundmeDeploy is Script {
    FundMe public fundme;

    function run() external returns (FundMe) {
        vm.startBroadcast();
        fundme = new FundMe(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        vm.stopBroadcast();
        return fundme;
    }
}
