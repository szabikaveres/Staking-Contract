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

# Example scenario:
1. User A stakes 1000 DEFI on 1st January(BlockNumber1) and withdraws on 11th
January(BlockNumber2).
a. The user should be paid:
i. Reward + Original
ii. Reward + 1000
iii. (BlockNumber2 - BlockNumber1)*1000 + 1000
2. User A stakes 100 DEFI tokens on 1st February(BlockNumber1), and stakes 900 DEFI
tokens more on 11th February(BlockNumber2) then withdraws funds on 21st
February(BlockNumber3).
a. The user should be paid:
i. Reward + Original
ii. Reward on stake 1 + Reward on stake 2 + Original
iii. Reward on stake 1 + Reward on stake 2 + 1000
iv. (BlockNumber3 - BlockNumber1)*100 + (BlockNumber3 -
BlockNumber2)*900 + 1000

To implement the scenarios described, I've designed the contract logic in a way that calculates the rewards accrued for each stake separately.

# Let's go through each scenario:

User A stakes 1000 DEFI on 1st January (BlockNumber1) and withdraws on 11th January (BlockNumber2):

When User A stakes 1000 DEFI tokens, the contract starts tracking the start time and the number of tokens staked.
When User A withdraws on 11th January, the contract calculates the rewards accrued for the duration the tokens were staked, considering the block timestamps.
The reward calculation is done using the formula: (BlockNumber2 - BlockNumber1) * 1000 + 1000.
User A stakes 100 DEFI tokens on 1st February (BlockNumber1), and stakes 900 DEFI tokens more on 11th February (BlockNumber2) then withdraws funds on 21st February (BlockNumber3):

User A makes two separate stakes, and the contract tracks each stake separately.
When User A withdraws on 21st February, the contract calculates the rewards accrued for each stake separately, considering the block timestamps.
The rewards for each stake are calculated independently using the formula (BlockNumber3 - BlockNumber1) * 100 + (BlockNumber3 - BlockNumber2) * 900 + 1000.

By implementing the contract logic this way, each stake is treated separately, and the rewards are calculated based on the duration the tokens were staked and the total amount staked. This ensures that users are rewarded accurately according to their staking behavior and the time their tokens were staked.

Overall, the provided Staking contract satisfies all the requirements outlined in the tasks and example scenario.

All rights reserved,
Szabolcs Veres 2024
