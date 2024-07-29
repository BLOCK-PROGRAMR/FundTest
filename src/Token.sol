// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import "../lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import "../lib/openzeppelin-contracts/contracts/access/Ownable.sol";

contract Token is ERC20, Ownable {
    constructor() ERC20("SCATER", "STR") Ownable(msg.sender) {
        _mint(msg.sender, 1000000 * (10 ** uint256(decimals())));
    }

    function mint(
        address Acc,
        uint256 Amount
    ) external onlyOwner returns (bool) {
        require(
            address(this) != Acc && Amount != uint256(0),
            "something gonna wrong"
        );
        _mint(Acc, Amount);
        return true;
    }

    function burn(
        address Acc,
        uint256 Amount
    ) external onlyOwner returns (bool) {
        require(
            address(this) != Acc && Amount != uint256(0),
            "something gonna wrong"
        );
        _burn(Acc, Amount);
        return true;
    }

    function withdraw(uint256 Amount) external onlyOwner returns (uint256) {
        uint256 amount = Amount * 1000000;
        require(amount <= address(this).balance, "Insufficient funds");

        payable(_msgSender()).transfer(amount);
        return amount;
    }

    function BuyTokens() external payable returns (bool) {
        uint256 amount = msg.value * 1000000;
        require(
            msg.value <= msg.sender.balance && msg.value != 0 ether,
            "Insufficient funds"
        );
        _transfer(owner(), _msgSender(), amount);
        return true;
    }
}
