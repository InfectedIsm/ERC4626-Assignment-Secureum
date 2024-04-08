///SPDX-License-Identifier: Unlicensed
pragma solidity 0.8.21;

import {Test, console, StdAssertions} from "forge-std/Test.sol";

import {ERC4626} from "../lib/solmate/src/tokens/ERC4626.sol";
import {ERC20} from "../lib/solmate/src/tokens/ERC20.sol";
import {ERC20} from "../lib/solmate/src/tokens/ERC20.sol";

import {SafeERC4626} from "../src/SafeERC4626.sol";
import {VulnerableERC4626} from "../src/VulnerableERC4626.sol";


contract VaultTestFuzz is Test {

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

	function test_Inflation_Safe_Fuzz(uint256 depositBalance) public {
		depositBalance = bound(depositBalance, 1, type(uint128).max -1);

		ERC4626 vault = safeVault;
		underlyingAsset = vault.asset();
		uint256 victimBalance = depositBalance;
		uint256 attackerBalance = 1 + depositBalance;

		uint expectedVictimShares = vault.previewDeposit(victimBalance);
		
		deal(address(underlyingAsset), victim, victimBalance);
		deal(address(underlyingAsset), attacker, attackerBalance);
		vm.prank(victim); underlyingAsset.approve(address(vault), type(uint256).max);
		vm.prank(attacker); underlyingAsset.approve(address(vault), type(uint256).max);
		
		//attacker deposit 1 wei to get 1 shares
		vm.prank(attacker); vault.deposit(1, attacker);
		attackerBalance = attackerBalance - 1;

		//then attacker donate 1e18 so that totalAssets in vault is 1 + 1e18
		vm.prank(attacker); underlyingAsset.transfer(address(vault), attackerBalance);

		//victim then deposit its balance
		vm.prank(victim); vault.deposit(victimBalance, victim);

		uint256 attackerShares =  vault.balanceOf(attacker);
		uint256 victimShares =  vault.balanceOf(victim);
		//victim should get the expected shares calculated before the inflation attack +-1 because of rounding
		assertApproxEqAbs(expectedVictimShares, victimShares, 1, "unexpected minted shares");

		//finally, attacker withdraw its shares
		vm.prank(attacker); vault.redeem(attackerShares, attacker, attacker);
		vm.prank(victim); vault.redeem(victimShares, victim, victim);

		uint256 finalVictimBalance = underlyingAsset.balanceOf(victim);
		assertApproxEqAbs(finalVictimBalance, victimBalance, 1, "unexpected withdrawn assets");
	}

	function test_Inflation_Vulnerable_Fuzz(uint256 depositBalance) public {
		depositBalance = bound(depositBalance, 1, type(uint128).max -1);
		
		ERC4626 vault = vulnerableVault;
		underlyingAsset = vault.asset();
		uint256 victimBalance = depositBalance;
		uint256 attackerBalance = 1 + depositBalance;

		uint expectedVictimShares = vault.previewDeposit(victimBalance);
		
		deal(address(underlyingAsset), victim, victimBalance);
		deal(address(underlyingAsset), attacker, attackerBalance);
		vm.prank(victim); underlyingAsset.approve(address(vault), type(uint256).max);
		vm.prank(attacker); underlyingAsset.approve(address(vault), type(uint256).max);
		
		//attacker deposit 1 wei to get 1 shares
		vm.prank(attacker); vault.deposit(1, attacker);
		attackerBalance = attackerBalance - 1;

		//then attacker donate 1e18 so that totalAssets in vault is 1 + 1e18
		vm.prank(attacker); underlyingAsset.transfer(address(vault), attackerBalance);

		//victim then deposit its balance
		vm.prank(victim); vault.deposit(victimBalance, victim);

		uint256 attackerShares =  vault.balanceOf(attacker);
		uint256 victimShares =  vault.balanceOf(victim);
		//victim should get the expected shares calculated before the inflation attack +-1 because of rounding
		assertApproxEqAbs(expectedVictimShares, victimShares, 1, "unexpected minted shares");

		//finally, attacker withdraw its shares
		vm.prank(attacker); vault.redeem(attackerShares, attacker, attacker);
		vm.prank(victim); vault.redeem(victimShares, victim, victim);

		uint256 finalVictimBalance = underlyingAsset.balanceOf(victim);
		assertApproxEqAbs(finalVictimBalance, victimBalance, 1, "unexpected withdrawn assets");
	}

}