// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract LBTC is ERC20, Ownable {
    uint8 private immutable _customDecimals;

    constructor(
        string memory name_,
        string memory symbol_,
        uint8 decimals_,
        address owner_,
        uint256 initialSupply // in *raw units* (i.e., includes decimals scaling)
    ) ERC20(name_, symbol_) Ownable(owner_) {
        _customDecimals = decimals_;
        if (initialSupply > 0) {
            _mint(owner_, initialSupply);
        }
    }

    function decimals() public view override returns (uint8) {
        return _customDecimals;
    }

    // Mint more (testnet-friendly). Restrict however you like.
    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }
}
