CFLAGS = -Wall -Werror -Wextra -std=c11

all: s21_grep

s21_grep: s21_grep.o s21_grep_processing.o
	gcc s21_grep.o s21_grep_processing.o -o s21_grep
	rm s21_grep.o s21_grep_processing.o

s21_grep_processing.o: s21_grep_processing.c s21_grep_processing.h
	gcc -c $(CFLAGS) s21_grep_processing.c

s21_grep.o: s21_grep.c
	gcc -c $(CFLAGS) s21_grep.c

clean:
	rm -rf *.o s21_grep

rebuild: clean all

check:
	clang-format -style=Google -n *.c *.h
	cppcheck --enable=all --suppress=missingIncludeSystem *.c *.h

test: s21_grep
	./test.sh
