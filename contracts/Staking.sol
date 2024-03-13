// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "./SafeMath.sol";

contract Staking {
    using SafeERC20 for IERC20;
    using SafeMath for uint256;

    IERC20 public defiToken;

    struct Stake {
        uint256 amount;
        uint256 startTime;
        uint256 lastRewardBlock;
        uint256 totalRewards;
    }

    mapping(address => Stake) public stakes;

    uint256 public constant rewardPerDayPer1000Defi = 1 ether;
    uint256 public constant blocksPerDay = 24 * 60 * 60 / 6; // Ethereum block time is around 6 seconds

    event Staked(address indexed user, uint256 amount);
    event Withdrawn(address indexed user, uint256 amount, uint256 rewards);

    constructor(address _defiToken) {
        defiToken = IERC20(_defiToken);
    }

    function stake(uint256 _amount) external {
        require(_amount > 0, "Cannot stake 0 tokens");
        require(defiToken.balanceOf(msg.sender) >= _amount, "Insufficient balance");
        
        if (stakes[msg.sender].amount > 0) {
            uint256 pendingRewards = calculateRewards(msg.sender);
            stakes[msg.sender].totalRewards = stakes[msg.sender].totalRewards.add(pendingRewards);
            stakes[msg.sender].lastRewardBlock = block.number;
            emit Withdrawn(msg.sender, stakes[msg.sender].amount, pendingRewards);
        }

        stakes[msg.sender].amount = stakes[msg.sender].amount.add(_amount);
        stakes[msg.sender].startTime = block.timestamp;
        stakes[msg.sender].lastRewardBlock = block.number;
        stakes[msg.sender].totalRewards = 0;

        defiToken.safeTransferFrom(msg.sender, address(this), _amount);

        emit Staked(msg.sender, _amount);
    }

    function withdraw() external {
        require(stakes[msg.sender].amount > 0, "No stake to withdraw");

        uint256 pendingRewards = calculateRewards(msg.sender);
        uint256 totalAmount = stakes[msg.sender].amount.add(pendingRewards);

        delete stakes[msg.sender];

        defiToken.safeTransfer(msg.sender, totalAmount);

        emit Withdrawn(msg.sender, totalAmount, pendingRewards);
    }

    function calculateRewards(address _user) public view returns (uint256) {
        uint256 blocksSinceLastReward = block.number.sub(stakes[_user].lastRewardBlock);
        uint256 rewardAmount = blocksSinceLastReward.mul(stakes[_user].amount).div(1000).mul(rewardPerDayPer1000Defi).div(blocksPerDay);
        return rewardAmount.add(stakes[_user].totalRewards);
    }
}
