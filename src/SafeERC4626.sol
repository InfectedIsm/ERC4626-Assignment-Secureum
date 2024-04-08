///SPDX-License-Identifier: Unlicensed

pragma solidity 0.8.21;

import {ERC4626} from "../lib/solmate/src/tokens/ERC4626.sol";
import {ERC20} from "../lib/solmate/src/tokens/ERC20.sol";
import {ERC20Mock} from "./mocks/ERC20Mock.sol";

contract SafeVault is ERC4626 {

	ERC20 _asset = new ERC20Mock("Token", "TKN", uint8(18));
	string _name = "VaultToken";
	string _symbol = "VTKN";

    constructor() ERC4626(_asset, _name, _symbol) {}

    function totalAssets() public view override returns (uint256) {
		return asset.balanceOf(address(this));
	}

}