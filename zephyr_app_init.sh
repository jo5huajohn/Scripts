#! /usr/bin/env bash

directory=$1
board=$2

mkdir -p $directory/src $directory/boards
cd "$directory"
touch prj.conf boards/$board.overlay

echo "cmake_minimum_required(VERSION 3.20.0)

find_package(Zephyr REQUIRED HINTS \$ENV{ZEPHYR_BASE})
project($directory)
    
target_sources(app PRIVATE src/main.c)" > CMakeLists.txt

echo "#include <zephyr.h>
#include <logging/log.h>
    
void main(void)
{
    
}" > src/main.c
