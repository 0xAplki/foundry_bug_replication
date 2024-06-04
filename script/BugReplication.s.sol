// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

import "forge-std/Test.sol";
import {Script, console2} from "forge-std/Script.sol";
import {TokenArrays} from "./../src/util/TokenArrays.sol";
import {IComposableStablePoolFactory} from "./../src/interfaces/IComposableStablePoolFactory.sol";

contract BugReplication is Script, Test {
    // mainnet Balancer V2 Vault
    address constant VAULT = 0xBA12222222228d8Ba445958a75a0704d566BF2C8;
    // mainnet Balancer V2 CmposableStablePoolFactory
    address constant cstFactoryAddress =
        0x5B42eC6D40f7B7965BE5308c70e2603c0281C1E9;

    // first wallet from mnemonic "test test test test test test test test test test test junk"
    address constant ANVIL_PUB_KEY = 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266;
    uint256 constant ANVIL_PRIV_KEY =
        0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80;

    function run() public {
        _deployCSP(
            cstFactoryAddress,
            "USDT/USDC CSP",
            0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48, // USDC
            0xdAC17F958D2ee523a2206206994597C13D831ec7 // USDT
        );
    }

    function _deployCSP(
        address cstFactory,
        string memory _name,
        address _token0,
        address _token1
    ) private returns (address) {
        address[] memory tokens = TokenArrays.createTwoTokenArray(
            _token0,
            _token1,
            true
        );

        uint256[] memory tokenRateCacheDurations = new uint256[](2);
        tokenRateCacheDurations[0] = 10800;
        tokenRateCacheDurations[1] = 10800;

        vm.startBroadcast(
            // anvil's wallet #0 private key
            ANVIL_PRIV_KEY
        );

        bytes32 someBytes32 = keccak256(
            abi.encode(address(this), vm.getNonce(ANVIL_PUB_KEY))
        );
        console2.log("someBytes32: ");
        console2.logBytes32(someBytes32);

        address csp = IComposableStablePoolFactory(cstFactory).create(
            _name,
            _name,
            tokens,
            200,
            TokenArrays.createTwoTokenArray(address(0), address(0), true),
            TokenArrays.createValueList(10800, 10800),
            false,
            500000000000000,
            makeAddr("asdf"),
            someBytes32
        );
        vm.stopBroadcast();

        console2.log("pool address: ", csp);

        return csp;
    }
}
