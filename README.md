# Number Guessing Game

A PostgreSQL and Bash scripting project built as part of the freeCodeCamp Relational Database certification.

## Project Description

An interactive bash script that generates a random number between 1 and 1000 for users to guess. It tracks each user's game history including total games played and their best game (fewest guesses).

## Files

- `number_guess.sql` — PostgreSQL database dump containing the full schema and data
- `number_guess.sh` — Bash script for the number guessing game

## Database Structure

### Tables

**users**
- `user_id` — SERIAL PRIMARY KEY
- `name` — VARCHAR(22), NOT NULL, UNIQUE
- `total_game` — INT, NOT NULL, DEFAULT 0
- `fewest_guess` — INT

## How to Use

### Restore the database
```bash
psql -U postgres < number_guess.sql
```

### Run the script
```bash
./number_guess.sh
```

### Example interaction
Enter your username:

Bob

Welcome, Bob! It looks like this is your first time here.

Guess the secret number between 1 and 1000:

500

It's higher than that, guess again:

750

It's lower than that, guess again:

625

You guessed it in 3 tries. The secret number was 625. Nice job!


### Returning user
Enter your username:

Bob

Welcome back, Bob! You have played 2 games, and your best game took 3 guesses.

Guess the secret number between 1 and 1000:



## Technologies Used

- PostgreSQL
- Bash scripting
- Git
