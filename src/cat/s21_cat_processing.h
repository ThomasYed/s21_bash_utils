#ifndef S21_CAT_PROCESSING_H
#define S21_CAT_PROCESSING_H
#include <stdio.h>
#include <string.h>
typedef short int shint;

typedef struct s21_cat_options {
  shint valid;
  shint num_not_empty_lines;
  shint num_all_lines;
  shint show_hidden;
  shint show_tabs;
  shint show_end_of_line;
  shint squeeze_blank;
} s21_cat_options;

void process_arguments(int c, char** v);

void get_long_options(const char* opt, s21_cat_options* options);

void get_short_options(char opt, s21_cat_options* options);

void parse_option(const char* opt, s21_cat_options* options);

void cat_v_option(int c);

void s21_cat_with_options(const char* filename, const s21_cat_options* options);

#endif  // S21_CAT_PROCESSING_H
