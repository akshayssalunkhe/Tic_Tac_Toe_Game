#!/bin/bash -x

#DISPLAYING WELCOME MESSAGE
echo "Welcome To Tic Tac Toe Game"

#DECLARING ARRAY
declare -a gameBoard

#CONSTANTS
NUMBER_OF_ROWS=3;
NUMBER_OF_COLUMNS=3;
ZERO=0;

#VARIABLES
rows=0;
columns=0;
userSymbol=0;
counter=1;

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

#FUNCTION TO ASSIGN SYMBOL TO USER
function assignSymbol() {
	if [[ $((RANDOM%2)) -eq 0 ]]
	then
		echo "Assigned Symbol To User Is 'O' "
		userSymbol=O;
	else
		echo "Assigned Symbol To User Is 'X' "
		userSymbol=X;
	fi
}

#CALLING FUNCTION TO ASSIGN SYMBOL TO USER
assignSymbol

#FUNCTION TO DECIDE WHO PLAYS FIRST
function whoPlaysFirst() {
	if [[ $((RANDOM%2)) -eq $ZERO ]]
	then
		echo "User Plays First"
	else
		echo "Computer Plays First"
	fi
}

#CALLING FUNCTION
whoPlaysFirst

#FUNCTION TO DISPLAY GAME BOARD
function displayGameBoard() {
	for((rows=1;rows<=NUMBER_OF_ROWS;rows++))
	do
		echo "---------------"
		for((columns=1;columns<=NUMBER_OF_COLUMNS;columns++))
		do
			echo -n " $counter  |"
			((counter++))
		done
		echo  ""
	done
	echo "---------------"
}

#CALLING FUNCTION TO DISPLAY GAME BOARD
displayGameBoard

