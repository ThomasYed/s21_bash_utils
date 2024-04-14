CFLAGS = -Wall -Werror -Wextra -std=c11

all: s21_cat

s21_cat: s21_cat.o s21_cat_processing.o
	gcc s21_cat.o s21_cat_processing.o -o s21_cat
	rm s21_cat.o s21_cat_processing.o

s21_cat_processing.o: s21_cat_processing.c s21_cat_processing.h
	gcc -c $(CFLAGS) s21_cat_processing.c

s21_cat.o: s21_cat.c
	gcc -c $(CFLAGS) s21_cat.c

clean:
	rm -rf *.o s21_cat

rebuild: clean all

check:
	clang-format -style=Google -n *.c *.h
	cppcheck --enable=all --suppress=missingIncludeSystem *.c *.h


test: s21_cat
	./test.sh
