#!/bin/sh

#rename all .txt in .asm

for f in *.txt; do 
mv -- "$f" "${f%.txt}.asm"
done
