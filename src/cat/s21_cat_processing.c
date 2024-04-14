#include "s21_cat_processing.h"

void process_arguments(int c, char** v) {
  s21_cat_options options = {0};
  if (c == 1)
    fprintf(stderr, "Error: Too few arguments (1)");
  else if (c == 2)
    s21_cat_with_options(v[1], &options);
  else if (c == 3) {
    options.valid = 1;
    parse_option(v[1], &options);
    if (options.valid) {
      s21_cat_with_options(v[2], &options);
    } else
      fprintf(stderr, "Error: Invalid argument or No arguments");
  } else
    fprintf(stderr, "Error: Too many arguments (%d)", c - 1);
}

void get_long_options(const char* opt, s21_cat_options* options) {
  if (strcmp(opt, "--number-nonblank") == 0)
    options->num_not_empty_lines = 1;
  else if (strcmp(opt, "--number") == 0)
    options->num_all_lines = 1;
  else if (strcmp(opt, "--squeeze-blank") == 0) {
    options->squeeze_blank = 1;
  } else
    options->valid = 0;
}

void get_short_options(char opt, s21_cat_options* options) {
  switch (opt) {
    case 'b':
      options->num_not_empty_lines = 1;
      break;
    case 'e':
      options->show_end_of_line = 1;
      options->show_hidden = 1;
      break;
    case 'E':
      options->show_end_of_line = 1;
      break;
    case 'n':
      options->num_all_lines = 1;
      break;
    case 's':
      options->squeeze_blank = 1;
      break;
    case 't':
      options->show_tabs = 1;
      options->show_hidden = 1;
      break;
    case 'T':
      options->show_tabs = 1;
      break;
    default:
      options->valid = 0;
  }
}

void parse_option(const char* opt, s21_cat_options* options) {
  if (opt[0] == '-') {
    if (opt[1] == '-')
      get_long_options(opt, options);
    else
      get_short_options(opt[1], options);
  } else
    options->valid = 0;
}

void cat_v_option(int c) {
  if (c <= 31)
    printf("^%c", c + 64);
  else if (c == 127)
    printf("^?");
  else if (c >= 128) {
    printf("M-");
    if (c < 128 + 32) {
      printf("^%c", c - 64);
    } else {
      printf("%c", c - 128);
    }
  } else
    printf("%c", c);
}

void s21_cat_with_options(const char* filename,
                          const s21_cat_options* options) {
  FILE* fp = fopen(filename, "r");
  if (!fp)
    perror("Could not read file");
  else {
    int c;
    int previos = '\n';
    int line_number = 1;
    shint was_empty_line = 0;
    while ((c = fgetc(fp)) != EOF) {
      if (c == '\n') {
        if (options->num_all_lines && previos == '\n')
          printf("%6d\t", line_number++);
      } else if ((options->num_all_lines || options->num_not_empty_lines) &&
                 previos == '\n')
        printf("%6d\t", line_number++);

      if (!(options->squeeze_blank && c == '\n' && previos == '\n' &&
            was_empty_line)) {
        if (options->show_end_of_line && c == '\n')
          printf("$\n");
        else if (options->show_tabs && c == '\t')
          printf("^I");
        else if (c != 9 && c != 10 && options->show_hidden)
          cat_v_option(c);
        else
          putchar(c);
      }
      was_empty_line = (c == '\n' && previos == '\n');
      previos = c;

      if (ferror(fp)) perror("Error when reading");
    }
    fclose(fp);
  }
}
