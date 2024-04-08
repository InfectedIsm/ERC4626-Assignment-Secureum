///SPDX-License-Identifier: Unlicensed

pragma solidity 0.8.21;

import {ERC20} from "../../lib/solmate/src/tokens/ERC20.sol";

contract ERC20Mock is ERC20 {

    constructor(string memory _name, string memory _symbol, uint8 _decmimals) ERC20(_name, _symbol, _decmimals) {}


}