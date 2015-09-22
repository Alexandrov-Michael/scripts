#!/bin/bash
# tested

t1="$(cat test.txt)"

if [ -n "$t1" ]
then 
	echo "then $t1"
else
	echo "else $t1"
fi
