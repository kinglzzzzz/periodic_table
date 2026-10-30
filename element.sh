#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

#no argument
if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
  exit
fi

#query
RESULT=$($PSQL "select atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius from elements join properties using(atomic_number) join types using(type_id) where atomic_number::text='$1' or symbol='$1' or name='$1'")


if [[ -z $RESULT ]]
then
  echo "I could not find that element in the database."
  exit
fi

IFS='|' read -r ATOMIC_NUM NAME SYMBOL TYPE MASS MELT BOIL <<< "$RESULT"

echo "The element with atomic number $ATOMIC_NUM is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELT celsius and a boiling point of $BOIL celsius."
