///SPDX-License-Identifier: Unlicensed

pragma solidity 0.8.21;

import {ERC20} from "../../lib/solmate/src/tokens/ERC20.sol";

contract ERC20Mock is ERC20 {


    string _name = "Token";
    string _symbol = "TKN";
    uint8 _decimals = uint8(18);
    constructor() ERC20(_name, _symbol, _decimals) {}

	function mint(address to, uint256 amount) external {
		_mint(to, amount);
	}

}