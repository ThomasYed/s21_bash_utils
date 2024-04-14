cmake_minimum_required(VERSION 3.27)
project(grep C)

set(CMAKE_C_STANDARD 11)

include_directories(.)

add_executable(grep
        s21_grep.c
        s21_grep_processing.c
        s21_grep_processing.h)
