Secureum Workshop Day 2: Graded Assignment

This graded assignment asks the user to answer specific questions with Simbolik's help. Questions are grouped by the target functions of WETH9 they concern. When we ask for the value of something, we expect KEVM terms. Where an explanation is requested, a short but informative answer would suffice. Each question is worth 1 point. Thus, a maximum of 39 points can be earned. The deadline for submissions is 2024-04-04 12:00 PM UTC (noon). Please submit your solution to raoul.schaffranek@runtimeverification.com.

----------------------------
# WETH9.deposit()

## Q1: How many paths revert?
1 path which is Branch 3

## Q2: How many paths succeed?
1 path, Branch 2

## Q3: For each reverting path, explain briefly the reason for the reversal
For Branch 3, the reason of the reversal is a panic error with return value of 0x11, meaning an arithmetic operation resulted in and underflow or overflow

## Q4: What's the value of the Calldata at the beginning of the function?
0xd0e30db0 which is the function signature of “deposit()”

## Q5: What's the value of the callvalue at the beginning of the function?
CALLVALUE_79cb2bc6:Int

## Q6: What's the value of the ETH balance of the WETH9 contract when the function succeeds?
DEBUGEE_BALANCE:Int

## Q7: What's the value of the ETH balance of the msg.sender when the function succeeds?
MSG_SENDER_BALANCE:Int

## Q8: What's the value of balanceOf[msg.sender] when the function succeeds?
I want to say chop `( #lookup ( DEBUGEE_STORAGE:Map , keccak ( #buf ( 32 , MSG_SENDER:Int ) +Bytes 0x0000000000000000000000000000000000000000000000000000000000000003 ) ) +Int CALLVALUE_79cb2bc6:Int )`, as I’m able to see that the 1st part is the formula to compute the storage slot of a the value in the mapping based on the parameter value (msg.sender) + position of the mapping itself (0x03) while the 2nd part of the expression is simply the symbolic representation of msg.value. So the value is the addition of both parts.

----------------------------
# WETH9.withdraw(uint256)

## Q9: How many paths revert?
2 paths, Branch2 and Branch4

## Q10: How many paths succeed?
1 path, Branch 3

## Q11: For each reverting path, explain briefly the reason for the reversal:
Branch 2: happening on L43; it seems its because `DEBUGEE_BALANCE:Int <Int VV0_wad_114b9705:Int`

## Q12: What is the value of Calldata at the beginning of the function?


## Q13: What is the value of ETH balance of the WETH9 contract when the function succeeds?


## Q14: What is the value of the ETH balance of the msg.sender when the function succeeds?


## Q15: What is the value of balance[msg.sender] when the function succeeds?

----------------------------
# WETH9.totalSupply()

## Q16: How many paths revert?


## Q17: How many paths succeed?


## Q18: What's the value of the Calldata at the beginning of the function?


## Q19: At which OPCode does the function pause initially?


## Q20: What's the value of the Return Data when the function succeeds?

----------------------------
# WETH9.approve(address,uint256)## 

## Q21: How many paths revert?


## Q22: How many paths succeed?


## Q23: What's the value of the Calldata at the beginning of the function?


## Q24: What is the value of allowance[msg.sender][guy] at the end of the function?

----------------------------
# WETH9.transfer(address,uint256)
## Q25: How many paths revert?


## Q26: How many paths succeed?

## Q27: What's the value of the Calldata at the beginning of the function?

## Q28: Is there any path that can reach line 65? How can you use the debugger to prove your answer?

## Q29: What's the WETH balance of msg.sender when the function succeeds (assuming msg.sender != dst)?

## Q30: What's the WETH balance of dst when the function succeeds (assuming msg.sender != dst)?

## Q31: What's the WETH balance of msg.sender when the function succeeds assuming msg.sender == dst?

----------------------------
# WETH9.transferFrom(address,address,uint256)

## Q32: How many paths revert?


## Q33: How many paths succeed?


## Q34: What's the value of the Calldata at the beginning of the function?


## Q35: How many paths pass through line 69?


## Q36: What is the value of the WETH balance of src when the function succeeds assuming src != dst?


## Q37: What is the value of the WETH balance of dst when the function succeeds assuming src != dst?


## Q38: What is the value of the WETH balance of src when the function succeeds assuming src == dst?


## Q39: What is the value of allowance[src][msg.sender] when the function succeeds assuming src != msg.sender?


