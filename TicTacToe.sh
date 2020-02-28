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
turnCount=0;
input=0;
columns=0;
userSymbol=0;
rowPosition=0;
playerOneSymbol=O;
computerSymbol=X;
columnPosition=0;
isEmpty="";
flagTwo=0;

#FUNCTION TO RESET THE GAME BOARD
function resetGameBoard() {
	for (( rows=1; rows<=$SIZE; rows++ ))
	do
		for (( columns=1; columns<=$SIZE; columns++ ))
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

#FUNCTION TO GENERATE ROW AND COLUMN POSITIONS
function rowColumnPosition() {
	rows=$(( RANDOM%3+1 ));
	columns=$(( RANDOM%3+1 ));
}

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
		if [[ $flag -eq $zero ]]
		then
			echo "congratulations ! Player one wins"
		else
			echo "Computer wins"
		fi
		exit
	elif [[ ${gameBoard[1,3]} == ${gameBoard[2,2]} ]] && [[ ${gameBoard[2,2]} == ${gameBoard[3,1]} ]] && [[ ${gameBoard[1,3]} ]]
	then
 		if [[ $flag -eq $zero ]]
		then
			echo "congratulations ! Player one wins"
		else
			echo "Computer wins"
		fi
		exit
	fi
}

function checkWinMove() {
	local rows=1
	local columns=1
	local symbol=$1

	for (( rows=1; rows<=$SIZE; rows++ ))
	do
			#CHECKIMG ROW WINNING CONDITION
		if [[ ${gameBoard[$rows,$columns]} == ${gameBoard[$rows,$(($columns+1))]} ]] &&
			[[ ${gameBoard[$rows,$columns]} != $isEmpty ]] && [[ ${gameBoard[$rows,$columns]} == $symbol ]] &&
			[[ ${gameBoard[$rows,$(($columns+2))]} == $isEmpty ]]
		then
			gameBoard[$rows,$(($columns+2))]=$computerSymbol
			((flagTwo++))
			return;
		elif [[ ${gameBoard[$rows,$columns]} == ${gameBoard[$rows,$(($columns+2))]} ]] &&
			[[ ${gameBoard[$rows,$columns]} != $isEmpty ]] && [[ ${gameBoard[$rows,$columns]} == $symbol ]] &&
			[[ ${gameBoard[$rows,$(($columns+1))]} == $isEmpty ]]
		then
			gameBoard[$rows,$(($columns+1))]=$computerSymbol
			((flagTwo++))
			return;
		elif [[ ${gameBoard[$rows,$(($columns+1))]} == ${gameBoard[$rows,$(($columns+2))]} ]] &&
			 [[ ${gameBoard[$rows,$(($columns+1))]} != $isEmpty ]] && [[ ${gameBoard[$rows,$(($columns+1))]} == $symbol ]] &&
			 [[ ${gameBoard[$rows,$columns]} == $isEmpty ]]
		then
			gameBoard[$rows,$columns]=$computerSymbol
			((flagTwo++))
			return;
		fi
	done

	#REINITIALIZING ROW AND COLUMNS VALUES
	rows=1;
	columns=1;
	#CHECKING COLUMNS WINNING CONDITION
	for (( columns=1; columns<=$SIZE; columns++ ))
	do
		if [[ ${gameBoard[$rows,$columns]} == ${gameBoard[$(($rows+1)),$columns]} ]] &&
			[[ ${gameBoard[$rows,$columns]} != $isEmpty ]] && [[ ${gameBoard[$rows,$columns]} == $symbol ]] &&
			[[ ${gameBoard[$(($rows+2)),$columns]} == $isEmpty ]]
		then
			gameBoard[$(($rows+2)),$columns]=$computerSymbol
			((flagTwo++))
			return;
		elif [[ ${gameBoard[$rows,$columns]} == ${gameBoard[$(($rows+2)),$columns]} ]] &&
			[[ ${gameBoard[$rows,$columns]} != $isEmpty ]] && [[ ${gameBoard[$rows,$columns]} == $symbol ]] &&
			[[ ${gameBoard[$(($rows+1)),$columns]} == $isEmpty ]]
		then
			gameBoard[$(($rows+1)),$columns]=$computerSymbol
			((flagTwo++))
			return;
		elif [[ ${gameBoard[$(($rows+1)),$columns]} == ${gameBoard[$(($rows+2)),$columns]} ]] &&
			[[ ${gameBoard[$(($rows+1)),$columns]} != $isEmpty ]] && [[ ${gameBoard[$(($rows+1)),$columns]} == $symbol ]] &&
			[[ ${gameBoard[$rows,$columns]} == $isEmpty ]]
		then
			gameBoard[$rows,$columns]=$computerSymbol
			((flagTwo++))
			return;
		fi
	done

	#REINITIALIZING THE ROW AND COLUMN
	rows=1;
	columns=1;
	#CHECKING DIAGOLNAL WINNING CONDITION
	if [[ ${gameBoard[$rows,$columns]} == ${gameBoard[$(($rows+1)),$(($columns+1))]} ]] &&
		[[ ${gameBoard[$rows,$columns]} != $isEmpty ]] && [[ ${gameBoard[$rows,$columns]} == $symbol ]] &&
		[[ ${gameBoard[$(($rows+2)),$(($columns+2))]} == $isEmpty ]]
	then
		gameBoard[$(($rows+2)),$(($columns+2))]=$computerSymbol
		((flagTwo++))
		return;
	elif [[ ${gameBoard[$rows,$columns]} == ${gameBoard[$(($rows+2)),$(($columns+2))]} ]] &&
		[[ ${gameBoard[$rows,$columns]} != $isEmpty ]] && [[ ${gameBoard[$rows,$columns]} == $symbol ]] &&
		[[ ${gameBoard[$(($rows+1)),$(($columns+1))]} == $isEmpty ]]
	then
		gameBoard[$(($rows+1)),$(($columns+1))]=$computerSymbol
		((flagTwo++))
		return;
	elif [[ ${gameBoard[$(($rows+1)),$(($columns+1))]} == ${gameBoard[$(($rows+2)),$(($columns+2))]} ]] &&
		[[ ${gameBoard[$(($rows+1)),$(($columns+1))]} != $isEmpty ]] && [[ ${gameBoard[$(($rows+1)),$(($columns+1))]} == $symbol ]] &&
		[[ ${gameBoard[$rows,$columns]} == $isEmpty ]]
	then
		gameBoard[$rows,$columns]=$computerSymbol
		((flagTwo++))
		return;
	fi
	if [[ ${gameBoard[$rows,$(($columns+2))]} == ${gameBoard[$(($rows+1)),$(($columns+1))]} ]] &&
		[[ ${gameBoard[$rows,$(($columns+2))]} != $isEmpty ]]  && [[ ${gameBoard[$rows,$(($columns+2))]} == $symbol ]] &&
		[[ ${gameBoard[$(($rows+2)),$columns]} == $isEmpty ]]
	then
		gameBoard[$(($rows+2)),$columns]=$computerSymbol
		((flagTwo++))
		return;
	elif [[ ${gameBoard[$rows,$(($columns+2))]} == ${gameBoard[$(($rows+2)),$columns]} ]] &&
		[[ ${gameBoard[$rows,$(($columns+2))]} != $isEmpty ]] && [[ ${gameBoard[$rows,$(($columns+2))]} == $symbol ]] &&
		[[ ${gameBoard[$(($rows+1)),$(($columns+1))]} == $isEmpty ]]
	then
		gameBoard[$(($rows+1)),$(($columns+1))]=$computerSymbol
		((flagTwo++))
		return;
	elif [[ ${gameBoard[$(($rows+1)),$(($columns+1))]} == ${gameBoard[$(($rows+2)),$columns]} ]] &&
		[[ ${gameBoard[$(($rows+1)),$(($columns+1))]} != $isEmpty ]] && [[ ${gameBoard[$(($rows+1)),$(($columns+1))]} == $symbol ]] &&
		[[ ${gameBoard[$rows,$(($columns+2))]} == $isEmpty ]]
	then
		gameBoard[$rows,$(($columns+2))]=$computerSymbol
		((flagTwo++))
		return;
	fi
}

#FUNCTION TO CHECK CORNERS ARE EMPTY IF YES THEN OCCUPY
function checkCorners() {
	local countCorner=0;
	local totalCorner=4;
	local symbol=$1
	while [[ $countCorner -lt $totalCorner ]]
	do
		rowColumnPosition
		if [[ $rows == 1 || $rows == 3 ]] && [[ $columns == 1 || $columns == 3 ]] && [[ ${gameBoard[$rows,$columns]} == $isEmpty ]]
		then
			gameBoard[$rows,$columns]=$symbol;
			((countCorner++));
			((flagTwo++))
			return;
		fi
	done
}

#CALLING FUNCTION ASSIGN SYMBOL
assignSymbol

#FUNCTION TO PLAY THE TIC TOK TOE GAME
function playTicTacToe() {
	#LOOP WILL TERMINATE AFTER TOTAL NUMBER OF TURNS OVER
	while [[ $turnCount -lt $TOTAL_TURN ]]
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
				((turnCount++))
				flag=1
			fi
		#IF COMPUTER PLAY FIRST THEN WILL ENTER IN THIS CONDITION
		elif [[ $flag == 1 ]]
		then
			flagTwo=0;
			((turnCount++))
			echo "Computer Play"
			checkWinMove
			if [[ $flagTwo -eq $ZERO ]]
			then
				checkWinMove $playerOneSymbol
			fi
			if [[ $flagTwo -eq $ZERO ]]
			then
				checkCorners $computerSymbol
			fi
			if [[ $flagTwo -eq $ZERO ]]
			then
				rowColumnPosition
				#CHECKING WHETHER GENERATED CELL POSITION IS OCCUPIED OR NOT
				if [[ ${gameBoard[$rowPosition,$columnPosition]} != $playerOneSymbol && ${gameBoard[$rowPosition,$columnPosition]} != $computerSymbol ]]
				then
					gameBoard[$rowPosition,$columnPosition]=$computerSymbol
				fi
			fi
			displayGameBoard
			isWinnerRow
			isWinnerColumn
			winnerDiagonal
			flag=0;
		fi
	done
	if [[ $turnCount -eq $TOTAL_TURN ]]
	then
		echo "It's Tie"
	fi
}

#CALLING FUNCTION TO PLAY GAME
playTicTacToe
