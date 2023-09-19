#!/bin/bash
# Number guessing game with score save
PSQL="psql -X --username=freecodecamp --dbname=number_guess -t --no-align -c"
NUMBER=$(($RANDOM % 1000 +1 ))
GUESS_COUNT=0

GET_USER (){
  read USER
  # check user in database
  # if exists
    # get history highlights
    # welcome back 
  #else
    # add to database
    # first time welcome
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
}

echo "Enter your username:"
GET_USER
echo "Guess the secret number between 1 and 1000:"
GUESS_GAME
#UPDATE database