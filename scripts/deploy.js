const { ethers } = require('hardhat');

async function main() {

  console.log('Deploying DefiToken...');
  const DefiToken = await ethers.getContractFactory('DefiToken');
  const defiToken = await DefiToken.deploy();
  console.log(`DefiToken deployed to: ${defiToken.address}\n`)

  console.log('Deploying Staking...');
  const Staking = await ethers.getContractFactory('Staking');
  const staking = await Staking.deploy(defiToken.address); // Pass the address of the DefiToken contract

  await staking.deployed();
  console.log(`Staking deployed to: ${staking.address}\n`)

  // Transfer initial token supply to the staking contract
  await defiToken.transfer(staking.address, ethers.utils.parseEther('1000000'));

  console.log('Deployment completed!');
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
