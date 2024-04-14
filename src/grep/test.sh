#!/bin/bash

for file in test_files/1.txt test_files/2.txt test_files/3.txt
do
  echo
  echo $file "test:"
  echo
  echo test with string template:

  echo flag -
  grep "abc" $file > 1
  ./s21_grep "abc" $file > 2
  diff 1 2

  echo flag -e
  grep -e "abc" $file > 1
  ./s21_grep -e "abc" $file > 2
  diff 1 2

  echo flag -i
  grep -i "abc" $file > 1
  ./s21_grep -i "abc" $file > 2
  diff 1 2

  echo flag -v
  grep -v "abc" $file > 1
  ./s21_grep -v "abc" $file > 2
  diff 1 2

  echo flag -c
  grep -c "abc" $file > 1
  ./s21_grep -c "abc" $file > 2
  diff 1 2

  echo flag -l
  grep -l "abc" $file > 1
  ./s21_grep -l "abc" $file > 2
  diff 1 2

  echo flag -n
  grep -n "abc" $file > 1
  ./s21_grep -n "abc" $file > 2
  diff 1 2

  echo flag -h
  grep -h "abc" $file > 1
  ./s21_grep -h "abc" $file > 2
  diff 1 2

  echo flag -s
  grep -s "abc" notexist.txt > 1
  ./s21_grep -s "abc" notexist.txt > 2
  diff 1 2

  echo flag -s
  grep -s "abc" $file > 1
  ./s21_grep -s "abc" $file > 2
  diff 1 2

  echo flag -o
  grep -o "abc" $file > 1
  ./s21_grep -o "abc" $file > 2
  diff 1 2

  echo flag -f
  grep -f test_files/template1.txt $file > 1
  ./s21_grep -f test_files/template1.txt $file > 2
  diff 1 2

  echo
  echo test with regex template:

 echo flag -
  grep '[0-9]*' $file > 1
  ./s21_grep '[0-9]*' $file > 2
  diff 1 2

  echo flag -e
  grep -e '[0-9]*' $file > 1
  ./s21_grep -e '[0-9]*' $file > 2
  diff 1 2

  echo flag -i
    grep -i '[0-9]*' $file > 1
    ./s21_grep -i '[0-9]*' $file > 2
    diff 1 2

  echo flag -v
  grep -v '[0-9]*' $file > 1
  ./s21_grep -v '[0-9]*' $file > 2
  diff 1 2

  echo flag -c
  grep -c '[0-9]*' $file > 1
  ./s21_grep -c '[0-9]*' $file > 2
  diff 1 2

  echo flag -l
  grep -l '[0-9]*' $file > 1
  ./s21_grep -l '[0-9]*' $file > 2
  diff 1 2

  echo flag -n
  grep -n '[0-9]*' $file > 1
  ./s21_grep -n '[0-9]*' $file > 2
  diff 1 2

  echo flag -h
  grep -h '[0-9]*' $file > 1
  ./s21_grep -h '[0-9]*' $file > 2
  diff 1 2

  echo flag -s \(incorrect file\)
  grep -s '[0-9]*' notexist.txt > 1
  ./s21_grep -s '[0-9]*' notexist.txt > 2
  diff 1 2

  echo flag -s \(common file\)
  grep -s '[0-9]*' $file > 1
  ./s21_grep -s '[0-9]*' $file > 2
  diff 1 2

  echo flag -o
  grep -o '[0-9]' $file > 1
  ./s21_grep -o '[0-9]' $file > 2
  diff 1 2

  echo flag -f
  grep -f test_files/template2.txt $file > 1
  ./s21_grep -f test_files/template2.txt $file > 2
  diff 1 2

done

echo
echo test several files

echo flag -
grep "abc" test_files/1.txt test_files/2.txt test_files/3.txt > 1
./s21_grep "abc" test_files/1.txt test_files/2.txt test_files/3.txt > 2
diff 1 2

echo flag -e
grep -e "abc" test_files/1.txt test_files/2.txt test_files/3.txt > 1
./s21_grep -e "abc" test_files/1.txt test_files/2.txt test_files/3.txt > 2
diff 1 2

echo flag -i
grep -i "abc" test_files/1.txt test_files/2.txt test_files/3.txt > 1
./s21_grep -i "abc" test_files/1.txt test_files/2.txt test_files/3.txt > 2
diff 1 2

echo flag -v
grep -v "abc" test_files/1.txt test_files/2.txt test_files/3.txt > 1
./s21_grep -v "abc" test_files/1.txt test_files/2.txt test_files/3.txt > 2
diff 1 2

echo flag -c
grep -c "abc" test_files/1.txt test_files/2.txt test_files/3.txt > 1
./s21_grep -c "abc" test_files/1.txt test_files/2.txt test_files/3.txt > 2
diff 1 2

echo flag -l
grep -l "abc" test_files/1.txt test_files/2.txt test_files/3.txt > 1
./s21_grep -l "abc" test_files/1.txt test_files/2.txt test_files/3.txt > 2
diff 1 2

echo flag -n
grep -n "abc" test_files/1.txt test_files/2.txt test_files/3.txt > 1
./s21_grep -n "abc" test_files/1.txt test_files/2.txt test_files/3.txt > 2
diff 1 2

echo flag -h
grep -h "abc" test_files/1.txt test_files/2.txt test_files/3.txt > 1
./s21_grep -h "abc" test_files/1.txt test_files/2.txt test_files/3.txt > 2
diff 1 2

echo flag -s
grep -s "abc" test_files/1.txt test_files/2.txt test_files/3.txt > 1
./s21_grep -s "abc" test_files/1.txt test_files/2.txt test_files/3.txt > 2
diff 1 2

echo flag -o
grep -o "abc" test_files/1.txt test_files/2.txt test_files/3.txt > 1
./s21_grep -o "abc" test_files/1.txt test_files/2.txt test_files/3.txt > 2
diff 1 2

echo flag -f
grep -f test_files/template1.txt test_files/1.txt test_files/2.txt test_files/3.txt > 1
./s21_grep -f test_files/template1.txt test_files/1.txt test_files/2.txt test_files/3.txt > 2
diff 1 2

echo
echo test several flags and files

echo flag -iv
grep -iv "abc" test_files/1.txt test_files/2.txt test_files/3.txt > 1
./s21_grep -iv "abc" test_files/1.txt test_files/2.txt test_files/3.txt > 2
diff 1 2

echo flag -ic
grep -ic "abc" test_files/1.txt test_files/2.txt test_files/3.txt > 1
./s21_grep -ic "abc" test_files/1.txt test_files/2.txt test_files/3.txt > 2
diff 1 2

echo flag -in
grep -in "abc" test_files/1.txt test_files/2.txt test_files/3.txt > 1
./s21_grep -in "abc" test_files/1.txt test_files/2.txt test_files/3.txt > 2
diff 1 2

echo flag -il
grep -il "abc" test_files/1.txt test_files/2.txt test_files/3.txt > 1
./s21_grep -il "abc" test_files/1.txt test_files/2.txt test_files/3.txt > 2
diff 1 2

echo flag -ih
grep -ih "abc" test_files/1.txt test_files/2.txt test_files/3.txt > 1
./s21_grep -ih "abc" test_files/1.txt test_files/2.txt test_files/3.txt > 2
diff 1 2

echo flag -io
grep -io "abc" test_files/1.txt test_files/2.txt test_files/3.txt > 1
./s21_grep -io "abc" test_files/1.txt test_files/2.txt test_files/3.txt > 2
diff 1 2

echo flag -cv
grep -cv "abc" test_files/1.txt test_files/2.txt test_files/3.txt > 1
./s21_grep -cv "abc" test_files/1.txt test_files/2.txt test_files/3.txt > 2
diff 1 2

echo flag -ch
grep -ch "abc" test_files/1.txt test_files/2.txt test_files/3.txt > 1
./s21_grep -ch "abc" test_files/1.txt test_files/2.txt test_files/3.txt > 2
diff 1 2

echo flag -cn
grep -cn "abc" test_files/1.txt test_files/2.txt test_files/3.txt > 1
./s21_grep -cn "abc" test_files/1.txt test_files/2.txt test_files/3.txt > 2
diff 1 2

echo flag -co
grep -co "abc" test_files/1.txt test_files/2.txt test_files/3.txt > 1
./s21_grep -co "abc" test_files/1.txt test_files/2.txt test_files/3.txt > 2
diff 1 2

echo flag -ln
grep -ln "abc" test_files/1.txt test_files/2.txt test_files/3.txt > 1
./s21_grep -ln "abc" test_files/1.txt test_files/2.txt test_files/3.txt > 2
diff 1 2

echo flag -lv
grep -lv "abc" test_files/1.txt test_files/2.txt test_files/3.txt > 1
./s21_grep -lv "abc" test_files/1.txt test_files/2.txt test_files/3.txt > 2
diff 1 2

echo flag -lh
grep -lh "abc" test_files/1.txt test_files/2.txt test_files/3.txt > 1
./s21_grep -lh "abc" test_files/1.txt test_files/2.txt test_files/3.txt > 2
diff 1 2

echo flag -hv
grep -hv "abc" test_files/1.txt test_files/2.txt test_files/3.txt > 1
./s21_grep -hv "abc" test_files/1.txt test_files/2.txt test_files/3.txt > 2
diff 1 2

echo flag -hn
grep -hn "abc" test_files/1.txt test_files/2.txt test_files/3.txt > 1
./s21_grep -hn "abc" test_files/1.txt test_files/2.txt test_files/3.txt > 2
diff 1 2

echo flag -hs
grep -hs "abc" test_files/1.txt test_files/2.txt test_files/3.txt > 1
./s21_grep -hs "abc" test_files/1.txt test_files/2.txt test_files/3.txt > 2
diff 1 2

echo flag -co
grep -co "abc" test_files/1.txt test_files/2.txt test_files/3.txt > 1
./s21_grep -co "abc" test_files/1.txt test_files/2.txt test_files/3.txt > 2
diff 1 2

echo flag -ln
grep -ln "abc" test_files/1.txt test_files/2.txt test_files/3.txt > 1
./s21_grep -ln "abc" test_files/1.txt test_files/2.txt test_files/3.txt > 2
diff 1 2

echo flag -on
grep -on "abc" test_files/1.txt test_files/2.txt test_files/3.txt > 1
./s21_grep -on "abc" test_files/1.txt test_files/2.txt test_files/3.txt > 2
diff 1 2

echo flag -oh
grep -oh "abc" test_files/1.txt test_files/2.txt test_files/3.txt > 1
./s21_grep -oh "abc" test_files/1.txt test_files/2.txt test_files/3.txt > 2
diff 1 2

echo flag -is \(incorrect file included\)
grep -is "abc" test_files/1.txt test_files/2.txt test_files/33.txt > 1
./s21_grep -is "abc" test_files/1.txt test_files/2.txt test_files/33.txt > 2
diff 1 2

echo flag -vs \(incorrect file included\)
grep -vs "abc" test_files/1.txt test_files/2.txt test_files/33.txt > 1
./s21_grep -vs "abc" test_files/1.txt test_files/2.txt test_files/33.txt > 2
diff 1 2

echo flag -os \(incorrect file included\)
grep -os "abc" test_files/1.txt test_files/2.txt test_files/33.txt > 1
./s21_grep -os "abc" test_files/1.txt test_files/2.txt test_files/33.txt > 2
diff 1 2

echo flag -oi
grep -oi "abc" test_files/1.txt test_files/2.txt test_files/3.txt > 1
./s21_grep -oi "abc" test_files/1.txt test_files/2.txt test_files/3.txt > 2
diff 1 2

echo flag -lh
grep -lh "abc" test_files/1.txt test_files/2.txt test_files/3.txt > 1
./s21_grep -lh "abc" test_files/1.txt test_files/2.txt test_files/3.txt > 2
diff 1 2

rm 1 2