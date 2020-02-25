#!/bin/bash -x

#DISPLAYING WELCOME MESSAGE
echo "Welcome To Tic Tac Toe Game"

#DECLARING DICTIONARY
declare -A gameBoard

#CONSTANTS
ZERO=0;
SIZE=3;
TOTAL_TURN=9;

#VARIABLES
rows=0;
count=0;
columns=0;
userSymbol=0;
rowPosition=0;
columnPosition=0;

#FUNCTION TO RESET THE GAME BOARD
function resetGameBoard() {
	for (( rows=1; rows<=$SIZE; rows++ ))
	do
		for(( columns=1; columns<=$SIZE; columns++ ))
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
		echo "Assigned Symbol To Player One Is 'O' "
		playerOneSymbol=O;
		playerTwoSymbol=X;
	else
		echo "Assigned Symbol To Player One Is 'X' "
		playerOneSymbol=X;
		playerTwoSymbol=O;
	fi
}

#CALLING FUNCTION TO ASSIGN SYMBOL TO USER
assignSymbol

#FUNCTION TO DECIDE WHO PLAYS FIRST
function whoPlaysFirst() {
	if [[ $((RANDOM%2)) -eq $ZERO ]]
	then
		echo "Player One Plays First"
	else
		echo "Player Two Plays First"
	fi
}

#CALLING FUNCTION TO DECIDE WHO PLAYS
whoPlaysFirst

#FUNCTION TO DISPLAY GAME BOARD
function displayGameBoard() {
	for (( rows=1; rows<=$SIZE; rows++ ))
	do
		echo "-------------------------"
		for (( columns=1; columns<=$SIZE; columns++ ))
		do
			echo -ne "${gameBoard[$rows,$columns]}\t|"
		done
		echo  ""
	done
	echo "-------------------------"
}

#CALLING FUNCTION TO DISPLAY GAME BOARD
displayGameBoard

#FUNCTION TO CHECK WINNING ROW
function isWinnerRow() {
	for (( rows=1; rows<=$SIZE; rows++ ))
	do
		for (( columns=1; columns<=$SIZE; columns++))
		do
			if [[ ${gameBoard[$rows,$columns]} == ${gameBoard[$rows,$(($columns+1))]} ]] &&
				[[ ${gameBoard[$rows,$(($columns+1))]} == ${gameBoard[$rows,$(($columns+2))]} ]] &&
				[[ ${gameBoard[$rows,$columns]}  ]]
			then
				echo  "WinRows"
				exit
			fi
		done
	done
}

#FUNCTION TO CHECK WINNING COLUMN
function isWinnerColumn() {
	for (( rows=1; rows<=$SIZE; rows++ ))
	do
		for (( columns=1; columns<=$SIZE; columns++ ))
		do
			if [[ ${gameBoard[$rows,$columns]} == ${gameBoard[$(($rows+1)),$columns]} ]] &&
				[[ ${gameBoard[$(($rows+1)),$columns]} == ${gameBoard[$(($rows+2)),$columns]} ]] &&
				[[ ${gameBoard[$rows,$columns]} ]]
			then
				echo  "Wincolumns"
				exit
			fi
		done
	done
}

#FUNCTION TO CHECK WINNING DIADONAL
function winnerDiagonal() {
	if [[ ${gameBoard[1,1]} == ${gameBoard[2,2]} ]] && [[ ${gameBoard[2,2]} == ${gameBoard[3,3]} ]] && [[ ${gameBoard[1,1]} ]]
	then
		echo "Win Diagonal"
		exit
	elif [[ ${gameBoard[1,3]} == ${gameBoard[2,2]} ]] && [[ ${gameBoard[2,2]} == ${gameBoard[3,1]} ]] && [[ ${gameBoard[1,3]} ]]
	then
		echo  "Win Diagonal"
		exit
	fi
}

#CALLING FUNCTION ASSIGN SYMBOL
assignSymbol

function playTicTacToe() {
	for (( input=1; input<=$TOTAL_TURN; input++ ))
	do
		if [[ $count -eq $ZERO ]]
		then
			read -p "Player One Turn Enter The Row Position And Column Position Respectively " rowPosition columnPosition
			gameBoard[$rowPosition,$columnPosition]=$playerOneSymbol
			((count++))
			displayGameBoard
			isWinnerRow
			isWinnerColumn
			winnerDiagonal
		else
			read -p "Player Two Turn Enter The Row Position And Column Position Respectively " rowPosition columnPosition
			gameBoard[$rowPosition,$columnPosition]=$playerTwoSymbol
			displayGameBoard
			isWinnerRow
			isWinnerColumn
			winnerDiagonal
			count=0;
		fi
		if [[ $input == $TOTAL_TURN ]]
		then
			echo "It's Tie"
		fi
	done
}
playTicTacToe
