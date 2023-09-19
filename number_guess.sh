#!/bin/bash
# Number guessing game with score save
PSQL="psql -X --username=freecodecamp --dbname=number_guess -t --no-align -c"
NUMBER=$(($RANDOM % 1000 +1 ))
GUESS_COUNT=0

GET_USER (){
  read USER
  # check user in database
  USER_ID=$($PSQL "SELECT user_id FROM users WHERE name='$USER'")
  # if exists
  if [[ -z $USER_ID ]]
  then
    # add to database
    INSERT_USER_RESULT=$($PSQL "INSERT INTO users(name) VALUES('$USER')")
    USER_ID=$($PSQL "SELECT user_id FROM users WHERE name='$USER'")
    # first time welcome
    echo "Welcome, $USER! It looks like this is your first time here." 
  else
    # get history highlights
    TOTAL_GAMES=$($PSQL "SELECT count(*) FROM scores WHERE user_id=$USER_ID")
    BEST_SCORE=$($PSQL "SELECT min(score) FROM scores WHERE user_id=$USER_ID")
    # welcome back
    echo "Welcome back, $USER! You have played $TOTAL_GAMES games, and your best game took $BEST_SCORE guesses."
  fi
}
GUESS_GAME (){
  # Prompt for next guess
  if [[ ! -z $1 ]]
  then
    echo "$1"
  fi
  read GUESS
  if [[ ! $GUESS =~ ^[0-9]+$ ]]
  then
    GUESS_GAME "That is not an integer, guess again:"
  else
    ((GUESS_COUNT+=1))
  if [[ $GUESS -lt $NUMBER ]]
  then
    # prompt guess higher
    GUESS_GAME "It's higher than that, guess again:"
  elif [[ $GUESS -gt $NUMBER ]]
  then
    #prompt guess lower
    GUESS_GAME "It's lower than that, guess again:"
  else
    #update records
    UPDATE_RESULT=$($PSQL "INSERT INTO scores(user_id,score) VALUES($USER_ID, $GUESS_COUNT)")
    #print win message
    echo "You guessed it in $GUESS_COUNT tries. The secret number was $NUMBER. Nice job!"
  fi
  fi 
}

echo "Enter your username:"
GET_USER
echo "Guess the secret number between 1 and 1000:"
GUESS_GAME
#UPDATE database