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
Running 2 tests for test/Inflation.t.sol:VaultTest
[PASS] test_Inflation_Safe() (gas: 618954)
Logs:
  attacker shares: 1e0
  victim shares: 1e18
  attacker assets: 1e0
  victim assets: 1e0

[FAIL. Reason: panic: arithmetic underflow or overflow (0x11)] test_Inflation_Vulnerable() (gas: 660083)
Logs:
  attacker shares: 1e0
  victim shares: 0e0

Test result: FAILED. 1 passed; 1 failed; 0 skipped; finished in 3.76ms

Ran 1 test suites: 1 tests passed, 1 failed, 0 skipped (2 total tests)

Failing tests:
Encountered 1 failing test in test/Inflation.t.sol:VaultTest
[FAIL. Reason: panic: arithmetic underflow or overflow (0x11)] test_Inflation_Vulnerable() (gas: 660083)
```