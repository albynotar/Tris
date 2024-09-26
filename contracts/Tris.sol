// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0 <0.9.0;
import "hardhat/console.sol";

contract Tris {
    // win event
    event Win(
        address player
    );

    // enum of single cell
    enum Value {NaN, X, O}

    // struct of single Tris cell
    struct Cell { 
      Value value;
      bool assigned;
    }
    
    //struct of player
    struct Player { 
      address addr;
      Value symbol;
    }

    //struct Cell for each 8 cells of tris grid
    Player Player1;
    Player Player2;
    Cell A1;
    Cell A2;
    Cell A3;
    Cell B1;
    Cell B2;
    Cell B3;
    Cell C1;
    Cell C2;
    Cell C3;
    uint8 move_count;

    // map each cell to an unique identifier
    mapping (uint8 => Cell) public cells;


    // contract constructor
    constructor() {
    A1 = Cell(Value.NaN, false);
    A2 = Cell(Value.NaN, false);
    A3 = Cell(Value.NaN, false);
    B1 = Cell(Value.NaN, false);
    B2 = Cell(Value.NaN, false);
    B3 = Cell(Value.NaN, false);
    C1 = Cell(Value.NaN, false);
    C2 = Cell(Value.NaN, false);
    C3 = Cell(Value.NaN, false);
    move_count = 0;
    }
    
    
    function get_cell(uint8 cell_id) public view returns (Cell memory) {
        return cells[cell_id];
    }

    function set_cell_value(uint8 cell_id, Value user_input) public returns (Cell memory) {
        cells[cell_id].value = user_input;
        return cells[cell_id];
    }

    function get_cell_value(uint8 cell_id) public view returns (string memory) {
        Value strNumber = cells[cell_id].value;
        if (strNumber == Value.NaN) return "-";
        if (strNumber == Value.X) return "X";
        if (strNumber == Value.O) return "O";
        return "ERROR";
    }

    
    function get_grid() public view returns (string memory) {
        string memory grid = string.concat(" _____\n",
        "|",get_cell_value(0), " ", get_cell_value(1)," ", get_cell_value(2),"|\n",
        "|", get_cell_value(3)," ", get_cell_value(4)," ", get_cell_value(5),"|\n", 
        "|",get_cell_value(6)," ", get_cell_value(7)," ", get_cell_value(8),"|\n",
        " \u203E\u203E\u203E\u203E\u203E\n");
        return grid;
    }

    function reset_grid() public {
        for (uint8 i = 0; i <= 8; i++) {
            cells[i] = Cell(Value.NaN, false);
        }
    }
    
    
    function move(address player, uint8 cell_id, Value user_input) public returns (Cell memory) {
        require(cells[cell_id].assigned == false, 'Cell already assigned');
        //require(msg.sender.address == , 'Cell already assigned');
        cells[cell_id].value = user_input;
        cells[cell_id].assigned = true;
        move_count = move_count + 1;
        bool winner_state = check_win();
        console.log(winner_state);
        if (winner_state == true){
            win_state(player);
            }
        return cells[cell_id];
    }

    function win_state(address player) public {
        for (uint8 i = 0; i <= 8; i++) {
            cells[i].assigned = true;
        }
        get_grid();
        emit Win(player);
        console.log(player);
    }

    function check_win() public view returns (bool) {
        //rows
        if (cells[0].value == Value.X && cells[1].value == Value.X && cells[2].value == Value.X){
            return true;
        }
        if (cells[3].value == Value.X && cells[4].value == Value.X && cells[5].value == Value.X){
            return true;
        }
        if (cells[6].value == Value.X && cells[7].value == Value.X && cells[8].value == Value.X){
            return true;
        }

        //columns
        if (cells[0].value == Value.X && cells[3].value == Value.X && cells[6].value == Value.X){
            return true;
        }
        if (cells[1].value == Value.X && cells[4].value == Value.X && cells[7].value == Value.X){
            return true;
        }
        if (cells[2].value == Value.X && cells[5].value == Value.X && cells[8].value == Value.X){
            return true;
        }

        //diagonals
        if (cells[0].value == Value.X && cells[4].value == Value.X && cells[8].value == Value.X){
            return true;
        }
        if (cells[2].value == Value.X && cells[4].value == Value.X && cells[6].value == Value.X){
            return true;
        }
        
        return false;
    }
}