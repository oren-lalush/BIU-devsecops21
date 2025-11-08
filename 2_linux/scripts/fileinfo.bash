#!/bin/bash

filename=$1

file_lines=`wc -l $filename | awk '{print $1}'`
file_words=`wc -w $filename | awk '{print $1}'`
file_size=`wc -m $filename | awk '{print $1}'`
file_usage=`du -sh $filename | awk '{print $1}'`

printf "File: %s\nLines: %s\nWords: %s\nSize: %s\nUsage: %s\n" "$1" "$file_lines" "$file_words" "$file_size" "$file_usage"

#echo $file_lines $file_words s$file_size $file_du
