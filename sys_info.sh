#!/bin/bash

os=$(uname -o)
cpu=$(lscpu)
mem=$(free -h)
disk=$(df -h)
mount=$(mount)

yad --info --text "OS: $os\nCPU: $cpu\nMemory: $mem\nDisk: $disk\nMount: $mount"
