// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.6.12; // @todo check version
pragma experimental ABIEncoderV2;

import {Script, console} from "forge-std/Script.sol";
import {TokenArrays} from "./../src/util/TokenArrays.sol";
import {IComposableStablePoolFactory} from "./../src/interfaces/IComposableStablePoolFactory.sol";

contract BugReplication is Script {
    address constant adminAddress = 0x235A2ac113014F9dcb8aBA6577F20290832dDEFd;
    address constant VAULT = 0x31d6656262CbC8262F643b6e3b2644c528940D79;
    address constant cstFactoryAddress =
        0x398D4CFB5D29d18BaA149497656904F2e8814EFb;

    function run() public {
        vm.startBroadcast();
        console.log("hello");
        _deployCSP(
            cstFactoryAddress,
            "USDT/USDC CSP",
            0x499F0a05582685f8728fF2f61F5F20D8001b7D73,
            0x39A632989Ae533a2bc1b66f17f5642906AB3F6c5
        );
        vm.stopBroadcast();
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

        address csp = IComposableStablePoolFactory(cstFactory).create(
            _name,
            _name,
            tokens,
            200,
            TokenArrays.createTwoTokenArray(address(0), address(0), true),
            TokenArrays.createValueList(10800, 10800),
            false,
            500000000000000,
            adminAddress,
            // @TODO update
            0x5959d140743dcfe9f7e9a6b2ede1b84d8a1320f08c43029b4fcf26ecc33041d0 // @todo check salt
        );

        console.log("pool address: ", csp);

        return csp;
    }
}
