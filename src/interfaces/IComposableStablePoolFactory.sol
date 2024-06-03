pragma solidity 0.6.12;

import {IVault} from "./IVault.sol";

interface IComposableStablePoolFactory {
    function getVault() external view returns (IVault);

    function version() external view returns (string memory);

    function getPoolVersion() external view returns (string memory);

    function create(
        string memory name,
        string memory symbol,
        address[] memory tokens,
        uint256 amplificationParameter,
        address[] memory rateProviders,
        uint256[] memory tokenRateCacheDurations,
        bool exemptFromYieldProtocolFeeFlags,
        uint256 swapFeePercentage,
        address owner,
        bytes32 salt
    ) external returns (address);
}
