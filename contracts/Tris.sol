// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0 <0.9.0;
import "hardhat/console.sol";

contract Tris {
    // win event
    event Win(
        address player,
        string name
    );

    // draw event
    event Draw(
        address player,
        string name
    );

    // move event
    event Move(
        address player,
        Value value,
        uint8 move_count
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
    Cell A1;
    Cell A2;
    Cell A3;
    Cell B1;
    Cell B2;
    Cell B3;
    Cell C1;
    Cell C2;
    Cell C3;

    // struct for two players
    Player Player1;
    Player Player2;

    // address of contract owner
    address public owner;

    // move state of game
    uint8 public move_count;
    
    /**
    * @dev set decorator for contract owner_only functions
    */
    modifier onlyOwner() {
    require(msg.sender == owner);
    _;
}

    // map each cell to an unique number
    mapping (uint8 => Cell) public cells;

    // contract constructor
    constructor(address p1, address p2) {

    // set up all 9 cells as empty cells
    A1 = Cell(Value.NaN, false);
    A2 = Cell(Value.NaN, false);
    A3 = Cell(Value.NaN, false);
    B1 = Cell(Value.NaN, false);
    B2 = Cell(Value.NaN, false);
    B3 = Cell(Value.NaN, false);
    C1 = Cell(Value.NaN, false);
    C2 = Cell(Value.NaN, false);
    C3 = Cell(Value.NaN, false);

    // owner is the first caller
    owner = msg.sender;

    // move count set as 0
    move_count = 0;

    // set players
    Player1 = Player(p1, Value.X);
    Player2 = Player(p2, Value.O);
    }

    /**
    * @dev function to get the move count
    */
    function get_move_count() public view returns (uint8) {
        return move_count;
    }
    
    /**
    * @dev returns state of requested Cell
    * @param cell_id id of the requested Cell
    */
    function get_cell(uint8 cell_id) public view returns (Cell memory) {
        return cells[cell_id];
    }

    /**
    * @dev returns human readable symbol of requested Cell
    * @param cell_id id of the requested Cell
    */
    function get_cell_value(uint8 cell_id) public view returns (string memory) {
        Value cell_symbol = cells[cell_id].value;
        if (cell_symbol == Value.NaN) return "-";
        if (cell_symbol == Value.X) return "X";
        if (cell_symbol == Value.O) return "O";
    }

    /**
    * @dev returns human readable Tris grid with the state of the game
    */
    function get_grid() public view returns (string memory) {
        string memory grid = string.concat(" _____\n",
        "|",get_cell_value(0), " ", get_cell_value(1)," ", get_cell_value(2),"|\n",
        "|", get_cell_value(3)," ", get_cell_value(4)," ", get_cell_value(5),"|\n", 
        "|",get_cell_value(6)," ", get_cell_value(7)," ", get_cell_value(8),"|\n",
        " \u203E\u203E\u203E\u203E\u203E\n");
        return grid;
    }

    /**
    * @dev reset the Tris grid
    */
    function reset_grid() public onlyOwner {
        for (uint8 i = 0; i <= 8; i++) {
            cells[i] = Cell(Value.NaN, false);
        }
        move_count = 0;
    }
    
    /**
    * @dev function that let a player make a move
    * emit a move event for each move and a win event if win condition
    * is achieved
    * @param cell_id id of the requested Cell
    */
    function move(uint8 cell_id) public returns (bool) {
        // check that msg.sender is player
        require(msg.sender == Player1.addr || msg.sender == Player2.addr, 'msg.sender is not an autorized player');
        // check that cell is not already assigned
        require(cells[cell_id].assigned == false, 'Cell is already assigned');
        // check which player has his turn and block illegal moves
        if (msg.sender == Player1.addr){
            require(move_count % 2 == 0, 'Player 1 attempted a move outside of his turn');
            cells[cell_id].value = Player1.symbol;
            }
        if (msg.sender == Player2.addr){
            require(move_count % 2 != 0, 'Player 2 attempted a move outside of his turn');
            cells[cell_id].value = Player2.symbol;
            }
        // assign new value to cell with id cell_id
        cells[cell_id].assigned = true;
        // emit move event
        emit Move(msg.sender, cells[cell_id].value, cells[cell_id].ass, move_count);
        // check win state
        bool winner_state = check_win();
        // console.log(winner_state);
        // if win condition is found emit win event
        if (winner_state == true){
            end_state();
            // emit win event for winner player
            if (move_count % 2 == 0){
                emit Win(Player1.addr, "Player1 Win");}
            else{
                emit Win(Player2.addr, "Player2 Win");}
            }
        // else increase move_count and change turn
        else{
            if (move_count == 8){
                // emit draw event if no more moves are available
                emit Draw(Player1.addr, "Draw");}
            else{
                move_count = move_count + 1;}
            }
        // return true if player has win or false if not
        return winner_state;
    }


    /**
    * @dev function for declaring th end of the game
    */
    function end_state() internal {
        // block all remaining cells
        for (uint8 i = 0; i <= 8; i++) {
            cells[i].assigned = true;
        }
    }

    /**
    * @dev function that check if there is a winning configuartion for a player
    */
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
        
        //no win condition
        return false;
    }
}