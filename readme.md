# AARCH64 Floats and Ncurses

## Project Description

This project makes a very crude sine wave in __NCURSES__ using AARCH64 floating point instruction. The goal of the project was to convert the C proram __main.c__ into an assembly version.

## Building

This project is ment to be assembled with the aarch64 linux GNU compiler collection. It requires the __CMATH__ library and __NCURSES__.            
For a POSIX compliant system the following should work.
> gcc floats.s -lcurses -lm

## Program Use
This program takes in no arguments. The size of crude sin waves is set on the intial size of the terminal window when starting the program. The user can close the program by sending __SIGINT__.