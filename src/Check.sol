// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

contract Check {
    uint public amount;

    function Setter(uint _amount) public {
        amount += _amount;
    }

    function Getter() public view returns (uint) {
        return amount;
    }
}
