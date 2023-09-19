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
  # compare guess to number
    # if guess low
      # prompt guess higher
    # if guess high
      #prompt guess lower
    # if guess correct
      #update records
      #print win message 
  echo $USER
}

echo "Enter your username:"
GET_USER
echo "Guess the secret number between 1 and 1000:"
GUESS_GAME
#UPDATE database