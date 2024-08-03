// SPDX-License-Identifier:MIT
pragma solidity ^0.8.22;
import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../src/FundMe.sol";
import {FundmeDeploy} from "../script/FundMe.s.sol";

//using test for every function other wise not testing in the foundry it is one style of writing

contract FundeMeTest is Test {
    FundMe public fundme;
    uint number = 5;
    address USER = makeAddr("user"); //create one address this is one of the cheatcode
    uint256 public constant GAS_PRICE = 1;

    uint public constant SEND_MONEY = 0.1 ether;
    uint public constant startBal = 10 ether;
    modifier fundup() {
        //this is one of the way to use modifier
        vm.prank(USER);
        fundme.fund{value: SEND_MONEY}();
        _;
    }

    function setUp() external {
        FundmeDeploy deploy = new FundmeDeploy();
        fundme = deploy.run();
        vm.deal(USER, startBal); //creating one address we add some money by using vm.deal cheat code
    }

    function test_usdNumber() public view {
        assertEq(fundme.MINIMUM_USD(), 5e18);
    }

    function test_Owner() public view {
        console.log("msg.sender:", msg.sender);
        console.log(fundme.i_owner());
        console.log("contract address:", address(this));
        assertEq(fundme.i_owner(), msg.sender);
    }

    function test_Number() public view {
        console.log(number);
        console.log("Hii-Hello");
        console.log("chain id:", block.chainid);
        assertEq(number, 5); //to check the condition the whether it is passed or not
    }

    function test_PriceFedd() public view {
        console.log("Owner:", fundme.getOwner());
    }

    function test_version() public view {
        uint256 check = fundme.getVersion();
        console.log("version:", check);
        assertEq(check, 4);
    }

    function test_fundme() public payable fundup {
        // vm.expectRevert(); // next line expecting  revert
        // uint256 nithin = 2;
        // vm.prank(USER);
        // fundme.fund{value: SEND_MONEY}();
        uint256 value = fundme.getAmountFundedtotheaddr(USER);
        uint256 _bal = fundme.getcontractBalance();
        console.log(_bal);
        console.log(value);
        assertEq(value, SEND_MONEY);
    }

    function test_index() public fundup {
        address _addr = fundme.getAddresstoFunded(0);
        assertEq(_addr, USER);
    }

    function test_withdraw() public fundup {
        uint256 startOwnerbalance = fundme.getOwner().balance;
        uint256 startContractbalance = address(fundme).balance;

        uint256 gasStart = gasleft();
        console.log("gasatart:", gasStart);
        vm.txGasPrice(GAS_PRICE); //it is used to set the gasprice of an blockchain,default the transaction fee is zero in anvil
        vm.prank(fundme.getOwner());
        fundme.withdraw();
        uint256 gasEnd = gasleft();
        console.log("gasEnd:", gasEnd);
        console.log(tx.gasprice);
        uint256 gasUsed = (gasStart - gasEnd) * tx.gasprice;
        console.log("gasUsed", gasUsed);

        uint256 endOwnerbalance = fundme.getOwner().balance;
        uint256 endContractbalance = address(fundme).balance;
        assertEq(endContractbalance, 0);
        assertEq(endOwnerbalance, startContractbalance + startOwnerbalance);
    }

    function test_getPrice() public view {
        uint256 _value = fundme.getPrice();
        // console.log("value of 10e18:", 10 ** 18);
        console.log("getPrice:", _value);
        console.log("using math:", ((_value * 1 ether) / 10 ** 18) / 10 ** 18);

        assertEq(_value, 2000 * 1 ether);
    }

    function test_CMultipleFunders() public {
        uint160 _nofoFunders = 10; //here uint160 is acceptable
        uint160 _startindex = 2;
        for (uint160 i = _startindex; i < _nofoFunders; i++) {
            hoax(address(i), SEND_MONEY);
            fundme.fund{value: SEND_MONEY}();
        }
        uint256 startOwnerbalance = fundme.getOwner().balance;
        uint256 endContractbalance = address(fundme).balance; //all the 10 accounts withdraw money 10*0.1ether
        console.log("before withdraw contract balance:", endContractbalance);
        console.log("before Ownerbalance:", startOwnerbalance);

        vm.startPrank(fundme.getOwner());
        fundme.cheaperwithdraw();
        vm.stopPrank();
        assertEq(address(fundme).balance, 0);
        assertEq(
            fundme.getOwner().balance,
            startOwnerbalance + endContractbalance
        );
        console.log("OwnerBalance:", fundme.getOwner().balance);
    }

    function test_MultipleFunders() public {
        uint160 _nofoFunders = 10; //here uint160 is acceptable
        uint160 _startindex = 2;
        for (uint160 i = _startindex; i < _nofoFunders; i++) {
            hoax(address(i), SEND_MONEY); //hoax is useful to test contract with different multiple senders
            fundme.fund{value: SEND_MONEY}();
        }
        uint256 startOwnerbalance = fundme.getOwner().balance;
        uint256 endContractbalance = address(fundme).balance; //all the 10 accounts withdraw money 10*0.1ether
        console.log("before withdraw contract balance:", endContractbalance);
        console.log("before Ownerbalance:", startOwnerbalance);

        vm.startPrank(fundme.getOwner());
        fundme.withdraw();
        vm.stopPrank();
        assertEq(address(fundme).balance, 0);
        assertEq(
            fundme.getOwner().balance,
            startOwnerbalance + endContractbalance
        );
        console.log("OwnerBalance:", fundme.getOwner().balance);
    }

    function test_cheatcods() public {
        console.log(block.number);
        vm.roll(1000);
        vm.fee(14 gwei);
        console.log(block.basefee);
        console.log(block.number);
        assertEq(vm.getBlockTimestamp(), 1);
        vm.warp(10);
        console.log(vm.getBlockTimestamp());
        assertEq(vm.getBlockTimestamp(), 10, "failed condition");
    }
}
