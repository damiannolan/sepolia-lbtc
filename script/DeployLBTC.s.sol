// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import {LBTC} from "../src/LBTC.sol";

contract DeployLBTC is Script {
    function run() external returns (LBTC token) {
        uint256 pk = vm.envUint("DEPLOYER_PK");
        address owner = vm.envAddress("OWNER");

        // Choose decimals (8 is common for BTC-like assets)
        uint8 decimals_ = uint8(vm.envUint("DECIMALS"));

        // Example: mint 1,000,000 LBTC to owner at deploy time
        // raw = 1_000_000 * 10^decimals
        uint256 initialSupply = vm.envUint("INITIAL_SUPPLY_RAW");

        vm.startBroadcast(pk);
        token = new LBTC(
            "Lombard BTC",
            "LBTC",
            decimals_,
            owner,
            initialSupply
        );
        vm.stopBroadcast();

        console2.log("LBTC deployed at:", address(token));
    }
}
