#ifndef S21_GREP_H
#define S21_GREP_H

#ifndef REG_STARTEND
#define REG_STARTEND 00004
#endif

#define _GNU_SOURCE
#include <errno.h>
#include <getopt.h>
#include <regex.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

typedef struct s21_grep_options {
  short valid;
  short file_count;
  char patterns[500];
  short pattern_count;

  short ingore_case;            // i =implemented
  short invert_match;           // v =implemented
  short count_only;             // c =implemented
  short filenames_only;         // l =implemented
  short show_line_number;       // n =implemented
  short show_without_filename;  // h =implemented
  short silent_mode;            // s =implemented
  short show_only_matches;      // o =implemented
} s21_grep_options;

void push_to_array(char* array, const char* value, short* counter);

void process_arguments(int argc, char** argv);

short get_arguments(const int a, char** v, s21_grep_options* options);

void f_option(const char* filename, s21_grep_options* options);

void s21_grep(s21_grep_options* options, char** argv, short index);

void print_option_o(const regex_t regex, char* line, const char* filename,
                    const short counter, const s21_grep_options* options);

#endif  // S21_GREP_H
