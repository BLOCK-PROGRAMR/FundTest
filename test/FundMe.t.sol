// SPDX-License-Identifier:MIT
pragma solidity ^0.8.22;
import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../src/FundMe.sol";

contract FundeMeTest is Test {
    FundMe public fundme;
    uint number = 5;

    function setUp() external {
        // fundme = new FundMe(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        number = 6;
    }

    function TestingNumber() public view {
        console.log(number);
        console.log("Hii hello");
        assertEq(number, 6);
    }
}
