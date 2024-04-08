///SPDX-License-Identifier: Unlicensed

pragma solidity 0.8.21;

import {ERC4626, SafeTransferLib} from "../lib/solmate/src/tokens/ERC4626.sol";
import {ERC20} from "../lib/solmate/src/tokens/ERC20.sol";
import {ERC20Mock} from "./mocks/ERC20Mock.sol";

contract VulnerableERC4626 is ERC4626 {

    using SafeTransferLib for ERC20;

	ERC20 _asset = new ERC20Mock();
	string _name = "VaultToken";
	string _symbol = "VTKN";

    constructor() ERC4626(_asset, _name, _symbol) {}

    function totalAssets() public view override returns (uint256) {
		return asset.balanceOf(address(this));
	}

    function deposit(uint256 assets, address receiver) public override returns (uint256 shares) {
        // Check for rounding error since we round down in previewDeposit.
        // require((shares = previewDeposit(assets)) != 0, "ZERO_SHARES");
		shares = previewDeposit(assets);
        // Need to transfer before minting or ERC777s could reenter.
        asset.safeTransferFrom(msg.sender, address(this), assets);

        _mint(receiver, shares);

        emit Deposit(msg.sender, receiver, assets, shares);

        afterDeposit(assets, shares);
    }

	function redeem(
        uint256 shares,
        address receiver,
        address owner
    ) public override returns (uint256 assets) {
        if (msg.sender != owner) {
            uint256 allowed = allowance[owner][msg.sender]; // Saves gas for limited approvals.

            if (allowed != type(uint256).max) allowance[owner][msg.sender] = allowed - shares;
        }
        // Check for rounding error since we round down in previewRedeem.
        // require((assets = previewRedeem(shares)) != 0, "ZERO_ASSETS");
		assets = previewRedeem(shares);
        beforeWithdraw(assets, shares);

        _burn(owner, shares);

        emit Withdraw(msg.sender, receiver, owner, assets, shares);

        asset.safeTransfer(receiver, assets);
    }

}