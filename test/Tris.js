const { expect } = require('chai');

describe('Tris', function() {
  let tris, player1, player2;

  beforeEach(async () => {
    const Tris = await ethers.getContractFactory('Tris');
    tris = await Tris.deploy();
    [player1, player2] = await ethers.getSigners();
    await tris.waitForDeployment();
    console.log([player1, player2]);
  });

  it('check that player can play', async function() {
    console.log("aa");
  });

});