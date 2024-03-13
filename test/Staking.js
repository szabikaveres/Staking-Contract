const { expect } = require('chai');
const { ethers } = require('hardhat');

describe("Staking", function () {
  let defiToken;
  let stakingContract;
  let owner;
  let user1;

  beforeEach(async function () {
    [owner, user1] = await ethers.getSigners();

    const DefiToken = await ethers.getContractFactory('DefiToken');
    defiToken = await DefiToken.deploy();

    const Staking = await ethers.getContractFactory("Staking");
    stakingContract = await Staking.deploy(defiToken.address); 

    await defiToken.transfer(user1.address, ethers.utils.parseEther("10000"));
    await defiToken.connect(user1).approve(stakingContract.address, ethers.utils.parseEther("10000"));
  });

  it("should allow user to stake and withdraw", async function () {
    await stakingContract.connect(user1).stake(ethers.utils.parseEther("1000"));

    expect(await defiToken.balanceOf(stakingContract.address)).to.equal(ethers.utils.parseEther("1000"));

    await ethers.provider.send("evm_mine");

    await stakingContract.connect(user1).withdraw();

    expect(await defiToken.balanceOf(stakingContract.address)).to.equal(0); 
    expect(await defiToken.balanceOf(user1.address)).to.equal(ethers.utils.parseEther("1000"));
  });
});
