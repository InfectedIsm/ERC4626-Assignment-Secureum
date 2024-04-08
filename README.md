## Description
This repo contains the solution to the DAy 5 Assignment Exercice 2 about ERC4626 Inflation Attack
- `src` contains 2 contracts: 
	- `SafeERC4626.sol` which **shouldn't be vulnerable** to inflation attack
	- `VulnerableERC4626.sol` which **should be vulnerable** to inflation attack

- `test` contains 1 contract:
	- `Inflation.t.sol` which will run 2 tests for each of these ERC4626 vaults

## Usage

First clone the repo:
```shell
git clone https://github.com/InfectedIsm/ERC4626-Assignment-Secureum.git
```

Then run the tests, dependecies will be installed automatically
```shell
forge test -vv
```

As required in the exercice, the vulnerable vault test should revert, as show by the output returned by the `forge test` command:

```shell
Ran 2 tests for test/Inflation.t.sol:VaultTest
[PASS] test_Inflation_Safe() (gas: 616009)

[FAIL. Reason: unexpected minted shares: 1000000000000000000 !~= 0 (max delta: 1, real delta: 1000000000000000000)] test_Inflation_Vulnerable() (gas: 624958)
Suite result: FAILED. 1 passed; 1 failed; 0 skipped; finished in 2.83ms (2.78ms CPU time)

Ran 1 test suite in 9.83ms (2.83ms CPU time): 1 tests passed, 1 failed, 0 skipped (2 total tests)

Failing tests:
Encountered 1 failing test in test/Inflation.t.sol:VaultTest
[FAIL. Reason: unexpected minted shares: 1000000000000000000 !~= 0 (max delta: 1, real delta: 1000000000000000000)] test_Inflation_Vulnerable() (gas: 624958)
```