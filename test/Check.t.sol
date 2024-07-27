// SPDX-License-Identifier: MIT

pragma solidity ^0.8.22;

import {Test, console} from "forge-std/Test.sol";
import {Check} from "../src/Check.sol";

contract CheckTest is Test {
    Check public check;

    function setUp() public {
        check = new Check();
        check.Setter(0);
    }

    function test1() public {
        check.Setter(1);
        assertEq(check.Getter(), 1);
    }

    function fuzz_Testing(uint x) public {
        setUp();
        uint intitial = check.Getter();
        check.Setter(x);
        assertEq(check.Getter(), x + intitial);
    }
}
