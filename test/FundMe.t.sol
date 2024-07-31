// SPDX-License-Identifier:MIT
pragma solidity ^0.8.22;
import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../src/FundMe.sol";

//using test for every function other wise not testing in the foundry it is one style of writing

contract FundeMeTest is Test {
    FundMe public fundme;
    uint number = 5;

    function setUp() external {
        fundme = new FundMe();
    }

    function test_usdNumber() public view {
        assertEq(fundme.MINIMUM_USD(), 5e18);
    }

    function test_Owner() public view {
        console.log(msg.sender);
        assertEq(fundme.i_owner(), msg.sender);
    }

    function test_Number() public view {
        console.log(number);
        console.log("Hii-Hello");
        assertEq(number, 6); //to check the condition the whether it is passed or not
    }

    function test_PriceFedd() public view {
        console.log(fundme.getOwner());
    }
}
