#! /usr/bin/env bash

script_directory=$HOME/Scripts/zephyr_app_init
app_directory=$1
board=$2

mkdir -p $app_directory/src $app_directory/boards
cd $app_directory
touch boards/$board.overlay

cp $script_directory/CMakeLists_template.txt CMakeLists.txt
awk -v app_dir="$app_directory" '{ sub(/PROJ_NAME/, app_dir) }1' CMakeLists.txt > CMakeLists.tmp && mv CMakeLists.tmp CMakeLists.txt
cp $script_directory/prj_template.conf prj.conf
cp $script_directory/main_template.c src/main.c
