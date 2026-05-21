#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=<database_name> -t --no-align -c"

echo Enter your username:
#database allows username: VARCHAR(22)
read USERNAME

USER=$($PSQL "SELECT name FROM users WHERE name = '$USERNAME'")

if [[ -n $USER ]]
then 
  TOTAL_GAME=$($PSQL "SELECT total_game FROM users WHERE name = '$USERNAME'")
  FEWEST_GUESS=$($PSQL "SELECT fewest_guess FROM users WHERE name = '$USERNAME'")
#if username exists before, print:
  echo Welcome back, $USERNAME! You have played $TOTAL_GAME games, and your best game took $FEWEST_GUESS guesses.
else
#if username is not used before, print:
  echo Welcome, $USERNAME! It looks like this is your first time here.
fi

echo Guess the secret number between 1 and 1000:
SECRETNUMBER=$(( RANDOM % 1000 + 1 ))
read GUESS

NUMBER_OF_GUESS=0

#check if it's integer
if [[ $GUESS =~ ^-?[0-9]+$ ]]
then
  
  while (( GUESS != SECRETNUMBER ))
  do
    (( NUMBER_OF_GUESS++ ))
    
    if (( SECRETNUMBER < GUESS ))
    then
    #if guess is higher
      echo "It's lower than that, guess again:"
      read GUESS

    elif (( SECRETNUMBER > GUESS ))
    then
    #if guess is lower
      echo "It's higher than that, guess again:"
      read GUESS

    else
      #if the secret number is guessed
      echo You guessed it in $NUMBER_OF_GUESS tries. The secret number was $SECRETNUMBER. Nice job!

    fi
  done

else
#if input is not integer
  echo That is not an integer, guess again:
fi


#update database: users, games


