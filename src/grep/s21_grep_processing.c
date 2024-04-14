#include "s21_grep_processing.h"

void push_to_array(char* array, const char* value, short* counter) {
  if (*counter == 0)
    strcpy(array, value);
  else {
    char str_to_add[100] = "|";
    strcat(str_to_add, value);
    strcat(array, str_to_add);
  }
  (*counter)++;
}

short get_arguments(const int a, char** v, s21_grep_options* options) {
  char* opts = "e:ivclnhsof:";  // доступные опции
  int opt;  // каждая следующая опция попадает сюда
  while ((opt = getopt(a, v, opts)) != -1) {
    switch (opt) {
      case 'e':
        push_to_array(options->patterns, optarg, &options->pattern_count);
        break;
      case 'i':
        options->ingore_case = 1;
        break;
      case 'v':
        options->invert_match = 1;
        break;
      case 'c':
        options->count_only = 1;
        break;
      case 'l':
        options->filenames_only = 1;
        break;
      case 'n':
        options->show_line_number = 1;
        break;
      case 'h':
        options->show_without_filename = 1;
        break;
      case 's':
        options->silent_mode = 1;
        break;
      case 'o':
        options->show_only_matches = 1;
        break;
      case 'f':
        f_option(optarg, options);
        break;
      case '?':
      default:
        options->valid = 0;
        break;
    }
  }

  if ((options->valid == 0) ||
      ((options->pattern_count == 0) && (optind + 1 >= a)) ||
      ((options->pattern_count > 0) && (optind == a))) {
    fprintf(stderr, (options->valid) ? "No patterns or filenames\n"
                                     : "Unknown option or no options\n");
    options->valid = 0;
  } else {
    if (options->pattern_count == 0) {
      push_to_array(options->patterns, v[optind], &options->pattern_count);
      optind++;
    }
  }
  options->file_count = a - optind;  // количество файлов
  return optind;
}

void f_option(const char* filename, s21_grep_options* options) {
  FILE* fp = fopen(filename, "r");
  if (fp == NULL) {
    fprintf(stderr, "Template file error: %s", strerror(errno));
  } else {
    char* line = NULL;
    size_t len = 0;
    getline(&line, &len, fp);
    push_to_array(options->patterns, line, &options->pattern_count);
    fclose(fp);
    free(line);
  }
}

void print_option_o(const regex_t regex, char* line, const char* filename,
                    const short counter, const s21_grep_options* options) {
  regmatch_t pm;
  pm.rm_so = 0;
  pm.rm_eo = (regoff_t)strlen(line);
  short count = 0;
  while (regexec(&regex, line, 1, &pm, REG_STARTEND) == options->invert_match) {
    if (count >= 1 && !(options->show_without_filename) &&
        options->file_count > 1)
      printf("%s:", filename);
    if (count >= 1 && options->show_line_number) printf("%i:", counter);

    line += pm.rm_so;  // сдвигаем строку
    long long int n = pm.rm_eo - pm.rm_so;
    for (long long int i = 0; i < n; i++) {
      putchar(line[i]);
    }
    putchar('\n');
    line += n;
    pm.rm_so = 0;
    pm.rm_eo = (regoff_t)strlen(line);
    count++;
  }
}

void s21_grep(s21_grep_options* options, char** argv, short index) {
  while (argv[index] != NULL) {
    FILE* fp = fopen(argv[index], "r");
    if (!fp) {
      if (!options->silent_mode)
        fprintf(stderr, "Could not read %s: %s\n", argv[index],
                strerror(errno));
    } else {
      char* line = NULL;
      size_t line_len = 0;

      int string_counter = 0;
      int match_counter = 0;
      while (getline(&line, &line_len, fp) != -1) {
        if (ferror(fp)) {
          perror("Error when reading");
          if (line) free(line);
        }
        string_counter++;
        regex_t regex;
        if (regcomp(&regex, options->patterns,
                    options->ingore_case ? REG_ICASE : REG_EXTENDED) == 0) {
          if (regexec(&regex, line, 0, NULL, 0) == options->invert_match) {
            match_counter++;
            if ((options->count_only || options->filenames_only) == 0) {
              if (options->file_count > 1 && !(options->show_without_filename))
                printf("%s:", argv[index]);
              if (options->show_line_number) printf("%i:", string_counter);
              if (!options->show_only_matches || options->invert_match)
                printf("%s", line);
              else {
                print_option_o(regex, line, argv[index], string_counter,
                               options);
              }
            }
          }
        }
        regfree(&regex);
      }
      if (options->count_only) {
        if (options->file_count > 1 && !(options->show_without_filename))
          printf("%s:", argv[index]);
        printf("%d\n", match_counter);
      }
      if (match_counter > 0 && options->filenames_only)
        printf("%s\n", argv[index]);
      fclose(fp);
      if (line) free(line);
    }
    index++;
  }
}

void process_arguments(int argc, char** argv) {
  s21_grep_options options = {0};
  options.valid = 1;
  short file_index = get_arguments(argc, argv, &options);
  if (options.valid) {
    s21_grep(&options, argv, file_index);
  }
}