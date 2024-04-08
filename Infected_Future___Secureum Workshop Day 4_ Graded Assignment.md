Secureum Workshop Day 4: Graded Assignment

# Question 1

```solidity
    function test_asset_doesNotRevert(address caller) public {
        _notBuiltinAddress(caller);
        vm.prank(caller); 
  		vault.asset();        
    }
```

# Question 2

```solidity
	function test_tokenDecimals_LessOrEqualVaultDecimals(address caller) public {
		//pre-conditions
        _notBuiltinAddress(caller);
        vm.prank(caller);

		uint8 tokenDecimals = asset.decimals();
		uint8 vaultDecimals = vault.decimals();
		
		//post-conditions
		assert(tokenDecimals <= vaultDecimals);
	}
```

# Question 3
```solidity
    function test_convertToShares_revertsWhenPaused_and_totalSupplyPositive(
		address from,
		uint256 amount,
		uint256 totalSupply		
		) public {
		//pre-conditions
        _notBuiltinAddress(from);
		vm.assume(totalSupply > 0);

		vm.store(
			address(vault), 
			bytes32(uint(2)), 
			bytes32(totalSupply)
		);

        vault.pause();

        vm.startPrank(from); 

		//post-conditions
        vm.expectRevert();
        vault.convertToShares(amount);
    }
```

# Question 4
```solidity
	function test_transfer(address from, address to, uint256 amount) public {
		//pre-conditions
        _notBuiltinAddress(from);
        _notBuiltinAddress(to);
		vm.assume(from != to);
		uint256 fromBalanceBefore = vault.balanceOf(from);
		uint256 toBalanceBefore = vault.balanceOf(to);
		vm.assume(amount <= fromBalanceBefore);
		unchecked{
			vm.assume(amount <= amount + toBalanceBefore);
		}
        vm.startPrank(from); 
		vault.transfer(to, amount);

		uint256 fromBalanceAfter = vault.balanceOf(from);
		uint256 toBalanceAfter = vault.balanceOf(to); 

		//post-conditions
		bool fromBalanceState = fromBalanceBefore >= fromBalanceAfter;
		bool toBalanceState = toBalanceAfter >= toBalanceBefore;
		assert(fromBalanceState);
		assert(toBalanceState);
	}
```


# Question 5
```solidity
    function test_mulWadUp(uint256 x, uint256 y) public {
        if (y == 0 || x <= type(uint256).max / y) {
			uint256 zSpec = (x * y) % WAD == 0 ? (x * y) / WAD : (x * y) / WAD + 1;
            uint256 zImpl = mulWadUp(x, y);
            assert(zImpl == zSpec);
        } else {
            vm.expectRevert();
            this.mulWadUp(x, y);
        }
    }
```