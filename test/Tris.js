// scripts/Tris.js
const { ethers } = require('hardhat');
const { expect } = require('chai');

describe('Tris', function() {
  beforeEach(async () => {
    const Tris = await ethers.getContractFactory('Tris');
    tris = await Tris.deploy("0x70997970C51812dc3A010C7d01b50e0d17dc79C8", "0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC");
    accounts = await ethers.getSigners();
    [owner,player1, player2] = accounts;
    await tris.waitForDeployment();
  });

  it('correctly execute a valid move', async function() {
      before_move = parseInt(await tris.connect(player1).get_cell(0)[0]);
      await tris.connect(player1).move(0);
      after_move = parseInt(await tris.connect(player1).get_cell(0)[0]);
      await expect(before_move == 0 && after_move == 1);
      await tris.connect(owner).reset_grid();
  });
  
  it('correctly revert a move given that the caller is not an autorized player', async function() {
    await expect(tris.connect(accounts[3]).move(0)).to.be.revertedWith('msg.sender is not an autorized player');
  });
  
  it('correctly revert a move given that the cell is already assigned', async function() {
    await tris.connect(player1).move(0);
    await expect(tris.connect(player2).move(0)).to.be.revertedWith('Cell is already assigned');
    await tris.connect(owner).reset_grid();
  });

  it('correctly revert an illegal move', async function() {
    await expect(tris.connect(player2).move(0)).to.be.revertedWith('Player 2 attempted a move outside of his turn');
    await tris.connect(player1).move(0);
    await expect(tris.connect(player1).move(1)).to.be.revertedWith('Player 1 attempted a move outside of his turn');
    await tris.connect(owner).reset_grid();
  });

});