// SPDX-License-Identifier:MIT
pragma solidity ^0.8.22;
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

import {Priceconverter} from "./Priceconverter.sol";
error NotOwner(); //used for gas optimization

contract FundMe {
    using Priceconverter for uint256; //using for library
    uint256 public constant MINIMUM_USD = 5 * 10 ** 18;
    address[] private s_funderaddress;
    AggregatorV3Interface public s_priceFeed;
    mapping(address => uint256) private s_addresstofunded;

    address public immutable i_owner; //for gas saving
    modifier Onlyowner() {
        if (msg.sender != i_owner) revert NotOwner();
        _;
    }

    constructor(address _priceFeed) {
        s_priceFeed = AggregatorV3Interface(_priceFeed);
        i_owner = msg.sender;
    }

    function fund() public payable {
        uint256 _data = (msg.value).getConversionrate(s_priceFeed);
        require(_data >= MINIMUM_USD, "Insufficient funds");
        s_funderaddress.push(msg.sender);
        s_addresstofunded[msg.sender] += msg.value;
    }

    function getPrice(uint256 _amount) public view returns (uint256) {
        (, int256 _data, , , ) = s_priceFeed.latestRoundData();
        uint256 _data1 = uint256(_data) * _amount;
        return _data1;
    }

    function withdraw() public Onlyowner returns (bool) {
        for (uint i = 0; i < s_funderaddress.length; i++) {
            address _addr = s_funderaddress[i];
            s_addresstofunded[_addr] = 0;
        }
        s_funderaddress = new address[](0);
        (bool success, ) = i_owner.call{value: address(this).balance}("");
        return success;
    }

    function cheaperwithdraw() public Onlyowner returns (bool) {
        address[] memory s_cfunderaddr = s_funderaddress;
        for (uint i = 0; i < s_cfunderaddr.length; i++) {
            address _addr = s_cfunderaddr[i];
            s_addresstofunded[_addr] = 0;
        }
        s_cfunderaddr = new address[](0);
        (bool success, ) = i_owner.call{value: address(this).balance}("");
        return success;
    }

    function getAddressToAmountFunded(
        address fundingAddress
    ) public view returns (uint256) {
        return s_addresstofunded[fundingAddress];
    }

    function getFunder(uint256 index) public view returns (address) {
        return s_funderaddress[index];
    }

    function getOwner() public view returns (address) {
        return i_owner;
    }

    function getPriceFeed() public view returns (AggregatorV3Interface) {
        return s_priceFeed;
    }
}
