// scripts/deploy.js
const { ethers } = require("hardhat");

// standard deploy script
async function main () {
  // deploy
  const Tris = await ethers.getContractFactory('Tris');
  tris = await Tris.deploy("0x70997970C51812dc3A010C7d01b50e0d17dc79C8", "0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC");
  accounts = await ethers.getSigners();
  [owner,player1, player2] = accounts;
  await tris.waitForDeployment();
  const events = await tris.queryFilter("*");
  console.log(events);
  };
  
  main()
    .then(() => process.exit(0))
    .catch(error => {
      console.error(error);
      process.exit(1);
    });