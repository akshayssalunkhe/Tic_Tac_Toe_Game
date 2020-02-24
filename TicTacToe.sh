#!/bin/bash -x

#DISPLAYING WELCOME MESSAGE
echo "Welcome To Tic Tac Toe Game"

#DECLARING ARRAY
declare -a gameBoard

#CONSTANTS
NUMBER_OF_ROWS=3;
NUMBER_OF_COLUMNS=3;

#VARIABLES
rows=0;
columns=0;

#FUNCTION TO RESET THE GAME BOARD
function resetGameBoard() {
	for (( rows=1; rows<=NUMBER_OF_ROWS; rows++ ))
	do
		for(( columns=1; columns<=NUMBER_OF_COLUMNS; columns++ ))
		do
			gameBord[$rows,$columns]=""
		done
	done
}

#CALLING THE FUNCTION TO RESET THE BOARD
resetGameBoard

