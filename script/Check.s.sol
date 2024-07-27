// SPDX-License-Identifier: MIT

pragma solidity ^0.8.22;

import {Script, console} from "forge-std/Script.sol";
import {Check} from "../src/Check.sol";

contract CheckDeploy is Script {
    Check public check;

    function setUp() public {}

    function run() public returns (Check) {
        vm.startBroadcast();
        check = new Check();
        vm.stopBroadcast();
        return check;
    }
}
