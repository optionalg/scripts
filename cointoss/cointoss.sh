#!/bin/bash
# cointoss.sh

ITER=$1
COUNT=0
HEADS=0
TAILS=0

if [ $# -eq 0 ]; then
  echo "Usage: ./cointoss.sh <iterations>"
  echo
  exit 1
fi

while [ $COUNT -lt $ITER ]; do
  FLIP=$[$RANDOM % 2]

  if [ $FLIP -eq 0 ]; then
    HEADS=$[$HEADS + 1]
  else
    TAILS=$[$TAILS + 1]
  fi

  COUNT=$[$COUNT + 1]
done

echo "Heads: $HEADS  Tails: $TAILS"

if [ $HEADS -gt $TAILS ]; then
  echo "Heads won"
else
  echo "Tails won"
fi

echo

