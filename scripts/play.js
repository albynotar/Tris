// scripts/play.js
const { ethers } = require("hardhat");

// script to emulate a game instance
async function main () {
    // deploy
    const Tris = await ethers.getContractFactory('Tris');
    tris = await Tris.deploy("0x70997970C51812dc3A010C7d01b50e0d17dc79C8", "0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC");
    accounts = await ethers.getSigners();
    [owner,player1, player2] = accounts;
    await tris.waitForDeployment();
    await tris.connect(player1).move(0);
    console.log(await tris.connect(player1).get_grid());
    await tris.connect(player2).move(1);
    console.log(await tris.connect(player2).get_grid());
    await tris.connect(player1).move(2);
    console.log(await tris.connect(player1).get_grid());
    await tris.connect(player2).move(3);
    console.log(await tris.connect(player2).get_grid());
    await tris.connect(player1).move(4);
    console.log(await tris.connect(player1).get_grid());
    await tris.connect(player2).move(5);
    console.log(await tris.connect(player1).get_grid());
    await tris.connect(player1).move(7);
    console.log(await tris.connect(player2).get_grid());
    await tris.connect(player2).move(8);
    console.log(await tris.connect(player1).get_grid());
    await tris.connect(player1).move(9);
    console.log(await tris.connect(player1).get_grid());
    console.log(await tris.connect(player1).get_move_count());
    const events = await tris.queryFilter("*");
    console.log(events);
  }
  
  main()
    .then(() => process.exit(0))
    .catch(error => {
      console.error(error);
      process.exit(1);
    });