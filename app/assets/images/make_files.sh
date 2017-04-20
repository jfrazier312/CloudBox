#!/bin/bash

JOKE1="Q: How do you tell an introverted computer scientist from an extroverted computer scientist?
\n\n\n
A: An extroverted computer scientist looks at YOUR shoes when he talks to you."

JOKE2="Knock Knock.\n\nWho's There?\n\n*long pause...*\n\n\nJava."



for i in {1..10}; do
    if [[ $((i%2)) == 1 ]]; then
	echo -e $JOKE1 > file${i}.txt
    else
	echo -e $JOKE2 > file$i.txt
    fi
done