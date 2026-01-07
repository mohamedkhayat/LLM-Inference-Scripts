#!/bin/bash

printf "%s\n" *_*.md | sort -V | while read f; do
  base="${f%.md}"
  
  num="$((${base##*_} + 1))"
 
  echo -e "\n\n<!-- PAGE $num -->\n"
  cat "$f"
done > combined.txt
