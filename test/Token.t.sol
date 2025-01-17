// SPDX-License-Identifier:MIT
pragma solidity ^0.8.22;

import {Test} from "forge-std/Test.sol";
import {Token} from "../src/Token.sol";

contract TokenTest is Test {
    Token public token;

    constructor() {
        token = new Token();
    }
}
