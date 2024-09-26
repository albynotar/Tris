// scripts/functions.js
const { ethers } = require("hardhat");

async function main () {
    const X = await ethers.getContractFactory('Tris');
    const x = await X.deploy();
    await x.waitForDeployment();
    [player1, player2] = await ethers.getSigners();
    console.log([player1, player2]);
    //console.log((await x.get_player1()).toString());
    //console.log((await x.get_player2()).toString());
    //await x.set_cell_value(0,0);
    //console.log((await x.get_cell_value(0)).toString());
    //await x.set_cell_value(4,1);
    //console.log((await x.get_cell_value(4)).toString());
    //await x.set_cell_value(8,2);
    //console.log((await x.get_cell_value(8)).toString());
    //console.log((await x.get_grid()));
    //await x.reset_grid();
    //console.log((await x.get_cell(0)).toString());
    //console.log((await x.move("0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266",0,1)));
    //console.log((await x.get_grid()));
    //await x.set_cell_value(0,0);
    //await x.reset_grid();
    //console.log((await x.check_win()));
    //await x.move("0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266",0,1);
    //console.log((await x.check_win()));
    //await x.move("0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266",1,1);
    //console.log((await x.check_win()));
    //await x.move("0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266",2,1);
    //console.log((await x.check_win()));
    //await x.reset_grid();
    //console.log((await x.get_grid()));
    //await x.move("0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266",0,1);
    //console.log((await x.check_win()));
    //await x.move("0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266",1,2);
    //console.log((await x.check_win()));
    //await x.move("0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266",2,1);
    //console.log((await x.check_win()));
    //await x.move("0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266",3,1);
    //console.log((await x.check_win()));
    //await x.move("0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266",4,2);
    //console.log((await x.check_win()));
    //await x.move("0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266",5,1);
    //console.log((await x.check_win()));
    //await x.move("0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266",6,2);
    //console.log((await x.check_win()));
    //await x.move("0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266",7,1);
    //console.log((await x.check_win()));
    //await x.move("0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266",8,2);
    //console.log((await x.check_win()));
    await x.reset_grid();
    await x.move(player1,0,1);
    await x.move(player1,4,1);
    await x.move(player1,8,1);
    //console.log((await x.get_grid()));
    //await x.reset_grid();
    //console.log((await x.get_grid()));
  }
  
  main()
    .then(() => process.exit(0))
    .catch(error => {
      console.error(error);
      process.exit(1);
    });