// SPDX-License-Identifier:MIT
pragma solidity ^0.8.22;
import {Script} from "forge-std/Script.sol";
import {FundMe} from "../src/FundMe.sol";
import {HelperConfig} from "./HelperConfig.s.sol";

contract FundmeDeploy is Script {
    FundMe public fundme;

    function run() external returns (FundMe) {
        HelperConfig helperconfig = new HelperConfig();
        address helper_addr = helperconfig.activeConfig();
        vm.startBroadcast();
        fundme = new FundMe(helper_addr);
        vm.stopBroadcast();
        return fundme;
    }
}
