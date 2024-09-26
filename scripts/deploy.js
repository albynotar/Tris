// scripts/deploy.js
const { ethers } = require("hardhat");

async function main () {
    const Tris = await ethers.getContractFactory('Tris');
    tris = await Tris.deploy();
    [player1, player2] = await ethers.getSigners();
    await tris.waitForDeployment();
    console.log('Tris deployed to:', await tris.getAddress());
    console.log([player1, player2]);
    

  }
  
  main()
    .then(() => process.exit(0))
    .catch(error => {
      console.error(error);
      process.exit(1);
    });