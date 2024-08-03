//SPDX-License-Identifier:MIT

pragma solidity ^0.8.22;
import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../../src/FundMe.sol";
import {FundmeDeploy} from "../../script/FundMe.s.sol";
import {FundFundme, withdrawFundme} from "../../script/Interactions.s.sol";

contract FundMefund is Test {
    FundMe fundme;
    address USER = makeAddr("user");
    uint public constant SEND_MONEY = 0.1 ether;
    uint public constant startBal = 10 ether;

    function setUp() external {
        FundmeDeploy _fundme = new FundmeDeploy();
        fundme = _fundme.run();
        vm.deal(USER, startBal);
    }

    function test_userCanAccounts() public {
        //this is called Integration testing means we can test multiple functions  in one function
        FundFundme _FundfundMe = new FundFundme();
        _FundfundMe.Fundme(address(fundme));
        uint256 _bal = address(fundme).balance;
        console.log("_bal:", _bal);
        withdrawFundme _withdraw = new withdrawFundme();

        _withdraw.withdrawFund(address(fundme));

        assertEq(address(fundme).balance, 0);
        console.log("OWNER BALANCE:", fundme.getOwner().balance);
        //     assertEq(fundme.getOwner().balance, _bal + beforeBalance);
        //
    }
}
