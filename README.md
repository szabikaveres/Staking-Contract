# Solidity Interview Project

# 1. Write a staking contract which accepts DEFI as the staking token and gives out DEFI as the reward.
The staking contract is named Staking.
It accepts a defiToken address as a constructor parameter (constructor(address _defiToken)).
Users can stake defiTokens (stake(uint256 _amount)) and receive rewards in defiTokens (calculateRewards(address _user)).

# 2.The user should be rewarded a total of 1 defiToken per day for every 1000 defiToken staked.
The contract calculates rewards based on the number of DEFI tokens staked and the duration they have been staked.
The calculateRewards function calculates rewards based on the number of blocks since the last reward and the stake amount.

# 3.The rewards must be emitted to the user every block.
Rewards are calculated and emitted to the user every time they stake or withdraw tokens.

# 4. (Stretch Goal) The user should be able to stake multiple times.
The contract allows users to stake multiple times, as the stake amount is stored separately for each user.

# 5. The user should be able to withdraw at any time.
Users can withdraw their staked tokens and accrued rewards at any time using the withdraw function.

# 6. The user should be able to view their rewards at any given time.
Users can view their rewards at any time by calling the calculateRewards function.

# 7. Upon withdrawal, the entire stake amount and the rewards should be sent to the user.
When a user withdraws, the contract transfers the total amount of staked tokens and accrued rewards to the user's address.

# 8. There is no partial withdrawal of the stake amount.
The contract does not support partial withdrawal of the stake amount. Users must withdraw their entire stake.
Overall, the provided Staking contract satisfies all the requirements outlined in the tasks.

Overall, the provided Staking contract satisfies all the requirements outlined in the tasks.

All rights reserved,
Szabolcs Veres 2024
