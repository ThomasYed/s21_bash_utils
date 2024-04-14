#!/bin/bash

for file in test_files/1.txt test_files/2.txt test_files/3.txt
do
  echo
  echo $file "test:"

  echo no flag
  cat $file > 1
  ./s21_cat $file > 2
  diff 1 2

  echo flag -b
  cat -b $file > 1
  ./s21_cat -b $file > 2
  diff 1 2

  echo flag -e
  cat -e $file > 1
  ./s21_cat -e $file > 2
  diff 1 2
  
  echo flag -n
  cat -n $file > 1
  ./s21_cat -n $file > 2
  diff 1 2

  echo flag -s
  cat -s $file > 1
  ./s21_cat -s $file > 2
  diff 1 2
  
  echo flag -t
  cat -t $file > 1
  ./s21_cat -t $file > 2
  diff 1 2

done

rm 1 2