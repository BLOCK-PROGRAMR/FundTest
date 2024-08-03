// SPDX-License-Identifier:MIT
pragma solidity ^0.8.22;
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

library Priceconverter {
    function getPrice(
        AggregatorV3Interface priceFeed
    ) internal view returns (uint256) {
        (, int256 answer, , , ) = priceFeed.latestRoundData();
        require(answer > 0, "Invalid number");

        return uint256(answer * 10000000000);
    }

    function getConversionrate(
        uint256 ethAmount,
        AggregatorV3Interface priceFeed
    ) internal view returns (uint256) {
        uint256 ethPrice = getPrice(priceFeed);
        uint256 ethAmountInusd = (ethPrice * ethAmount) / (1000000000000000000);
        return ethAmountInusd;
    }
}
