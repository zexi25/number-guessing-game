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
  $($PSQL "INSERT INTO users(name) VALUES($USERNAME)")
  TOTAL_GAME=0
  FEWEST_GUESS=999999
fi

echo Guess the secret number between 1 and 1000:
SECRETNUMBER=$(( RANDOM % 1000 + 1 ))
read GUESS

NUMBER_OF_GUESS=0

#check if it's integer
check_integer

  while (( GUESS != SECRETNUMBER )) 
  do
    (( NUMBER_OF_GUESS++ ))
    
    if (( SECRETNUMBER < GUESS ))
    then
    #if guess is higher
      echo "It's lower than that, guess again:"
      read GUESS
      check_integer

    elif (( SECRETNUMBER > GUESS ))
    then
    #if guess is lower
      echo "It's higher than that, guess again:"
      read GUESS
      check_integer
     
    fi
  done

#if the secret number is guessed
echo You guessed it in $NUMBER_OF_GUESS tries. The secret number was $SECRETNUMBER. Nice job!
(( TOTAL_GAME++ ))
FEWEST_GUESS=$(( NUMBER_OF_GUESS < FEWEST_GUESS ? NUMBER_OF_GUESS : FEWEST_GUESS ))

#update database: users, games

$($PSQL "UPDATE users SET total_game = TOTAL_GAME, fewest_guess = FEWEST_GUESS where name = USERNAME")



# check if an input is integer
check_integer() {
  until [[ $GUESS=~ ^-?[0-9]+$ ]]
  do 
    #if input is not integer
    echo That is not an integer, guess again:
    read GUESS
  done 
}

