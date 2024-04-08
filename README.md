## Description
This repo contains the solution to the DAy 5 Assignment Exercice 2 about ERC4626 Inflation Attack
- `src` contains 2 contracts: 
	- `SafeERC4626.sol` which **shouldn't be vulnerable** to inflation attack
	- `VulnerableERC4626.sol` which **should be vulnerable** to inflation attack

- `test` contains 2 contracts:
	- `Inflation.t.sol` which will run 2 tests for each of these ERC4626 vaults
	- `Inflation.fuzz.t.sol` which will run 2 fuzz tests for each of these ERC4626 vaults

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
[PASS] test_Inflation_Safe() (gas: 616012)
[FAIL. Reason: unexpected minted shares: 1000000000000000000 !~= 0 (max delta: 1, real delta: 1000000000000000000)] test_Inflation_Vulnerable() (gas: 624961)
Suite result: FAILED. 1 passed; 1 failed; 0 skipped; finished in 2.77ms (2.69ms CPU time)

Ran 2 tests for test/Inflation.fuzz.t.sol:VaultTestFuzz
[PASS] test_Inflation_Safe_Fuzz(uint256) (runs: 258, μ: 619204, ~: 619045)
[FAIL. Reason: unexpected minted shares: 2 !~= 0 (max delta: 1, real delta: 2); counterexample: calldata=0x7f6b0faa0000000000000000000000000000000100000000000000000000000000000000 args=[340282366920938463463374607431768211456 [3.402e38]]] test_Inflation_Vulnerable_Fuzz(uint256) (runs: 1, μ: 533910, ~: 533910)
Logs:
  Bound Result 2


Suite result: FAILED. 1 passed; 1 failed; 0 skipped; finished in 265.12ms (516.80ms CPU time)

Ran 2 test suites in 280.44ms (267.89ms CPU time): 2 tests passed, 2 failed, 0 skipped (4 total tests)

Failing tests:
Encountered 1 failing test in test/Inflation.fuzz.t.sol:VaultTestFuzz
[FAIL. Reason: unexpected minted shares: 2 !~= 0 (max delta: 1, real delta: 2); counterexample: calldata=0x7f6b0faa0000000000000000000000000000000100000000000000000000000000000000 args=[340282366920938463463374607431768211456 [3.402e38]]] test_Inflation_Vulnerable_Fuzz(uint256) (runs: 1, μ: 533910, ~: 533910)

Encountered 1 failing test in test/Inflation.t.sol:VaultTest
[FAIL. Reason: unexpected minted shares: 1000000000000000000 !~= 0 (max delta: 1, real delta: 1000000000000000000)] test_Inflation_Vulnerable() (gas: 624961)
```