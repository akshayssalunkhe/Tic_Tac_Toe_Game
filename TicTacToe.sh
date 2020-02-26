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
flag=0;
count=0;
input=0;
columns=0;
userSymbol=0;
rowPosition=0;
playerOneSymbol=O;
computerSymbol=X;
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
	if [[ $((RANDOM%2)) -eq $ZERO ]]
	then
		echo "Assigned Symbol To Player One Is 'O' "
		playerOneSymbol=O;
		computerSymbol=X;
	else
		echo "Assigned Symbol To Player One Is 'X' "
		playerOneSymbol=X;
		computerSymbol=O;
	fi
}

#CALLING FUNCTION TO ASSIGN SYMBOL TO USER
assignSymbol

#FUNCTION TO DECIDE WHO PLAYS FIRST
function whoPlaysFirst() {
	if [[ $((RANDOM%2)) -eq $ZERO ]]
	then
		flag=0;
		echo "Player One Plays First"
	else
		flag=1;
		echo "Computer Plays First"
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
				[[ ${gameBoard[$rows,$columns]} && ${gameBoard[$rows,$(($columns+2))]} ]]
			then
				echo  "WinRows"
				if [[ $flag -eq $zero ]]
				then
					echo "congratulations ! Player one wins "
				else
					echo "Computer wins"
				fi
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
				[[ ${gameBoard[$rows,$columns]} && ${gameBoard[$(($rows+2)),$columns]} ]]
			then
				echo  "Wincolumns"
				if [[ $flag -eq $zero ]]
				then
					echo "congratulations ! Player one wins "
				else
					echo "Computer wins"
				fi
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
		if [[ $flag -eq $zero ]]
		then
			echo "congratulations ! Player one wins"
		else
			echo "Computer wins"
		fi
	exit
	elif [[ ${gameBoard[1,3]} == ${gameBoard[2,2]} ]] && [[ ${gameBoard[2,2]} == ${gameBoard[3,1]} ]] && [[ ${gameBoard[1,3]} ]]
	then
		echo  "Win Diagonal 2"
 		if [[ $flag -eq $zero ]]
		then
			echo "congratulations ! Player one wins"
		else
			echo "Computer wins"
		fi
		exit
	fi
}

#CALLING FUNCTION ASSIGN SYMBOL
assignSymbol

#FUNCTION TO PLAY THE TIC TOK TOE GAME
function playTicTacToe() {
	#LOOP WILL TERMINATE AFTER TOTAL NUMBER OF TURNS OVER
	while [[ $count -lt $TOTAL_TURN ]]
	do
		#IF PLAYER PLAYS FIRST THEN WILL ENTER IN THIS CONDITION
		if [[ $flag == 0 ]]
		then
			echo "Player Play"
			read -p "Enter Row position And Column Position " rowPosition columnPosition
			if [[ $rowPosition -gt $SIZE && $columnPosition -gt $SIZE ]]
			then
				echo "Invalid Input"
			elif [[ ${gameBoard[$rowPosition,$columnPosition]} != $playerOneSymbol && ${gameBoard[$rowPosition,$columnPosition]} != $computerSymbol ]]
			then
				gameBoard[$rowPosition,$columnPosition]=$playerOneSymbol
				displayGameBoard
				isWinnerRow
				isWinnerColumn
				winnerDiagonal
				((count++))
				flag=1
			fi
		#IF COMPUTER PLAY FIRST THEN WILL ENTER IN THIS CONDITION
		elif [[ $flag == 1 ]]
		then
			echo "Computer Play"
			rowPosition=$(( RANDOM%3+1 ))
			columnPosition=$(( RANDOM%3+1 ))
			#CHECKING WHETHER GENERATED CELL POSITION IS OCCUPIED OR NOT
			if [[ ${gameBoard[$rowPosition,$columnPosition]} != $playerOneSymbol && ${gameBoard[$rowPosition,$columnPosition]} != $computerSymbol ]]
			then
				gameBoard[$rowPosition,$columnPosition]=$computerSymbol
				displayGameBoard
				isWinnerRow
				isWinnerColumn
				winnerDiagonal
				flag=0
				((count++))
			fi
		fi
	done
	if [[ $count -eq $TOTAL_TURN ]]
	then
		echo "It's Tie"
	fi
}

#CALLING FUNCTION TO PLAY GAME
playTicTacToe
