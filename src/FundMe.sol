// SPDX-License-Identifier:MIT
pragma solidity ^0.8.22;
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

import {Priceconverter} from "./Priceconverter.sol";
error NotOwner(); //used for gas optimization

contract FundMe {
    using Priceconverter for uint256; //using  library
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

    function getPrice() public view returns (uint256) {
        (, int256 _data, , , ) = s_priceFeed.latestRoundData();

        return uint256(_data * 10000000000);
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
        address[] memory m_cfunderaddr = s_funderaddress;
        for (uint i = 0; i < m_cfunderaddr.length; i++) {
            address _addr = m_cfunderaddr[i];
            s_addresstofunded[_addr] = 0;
        }
        s_funderaddress = new address[](0);
        (bool success, ) = i_owner.call{value: address(this).balance}("");
        return success;
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

    function getVersion() public view returns (uint256) {
        return s_priceFeed.version();
    }

    function getAmountFundedtotheaddr(
        address _Addr
    ) external view returns (uint256) {
        return s_addresstofunded[_Addr];
    }

    function getAddresstoFunded(uint256 index) external view returns (address) {
        return s_funderaddress[index];
    }

    function getcontractBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
