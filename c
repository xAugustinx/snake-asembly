#!/bin/bash
rm meow
clear


as main.asm -o meow.o
ld meow.o -o meow

rm meow.o
chmod +x meow
./meow
