// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

interface IComposableStablePool {
    function getScalingFactors() external view returns (uint256[] memory);

    function getBptIndex() external view returns (uint256);

    function getPoolId() external view returns (bytes32);

    function getVault() external view returns (address);
}
