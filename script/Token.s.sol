// SPDX-License-Identifier:MIT
pragma solidity ^0.8.22;
import {Script} from "forge-std/Script.sol";
import {Token} from "../src/Token.sol";

contract TokenScript is Script {
    Token public token;

    function setUp() public {}

    function run() public returns (Token) {
        vm.startBroadcast();
        token = new Token();
        vm.stopBroadcast();
        return token;
    }
}
