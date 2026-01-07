#!/bin/bash

echo -e 'Available models : \n'
for file in ~/scripts/start_*.sh; do
    [[ -e "$file" ]] || continue

    name="${file#/home/mohamed/scripts/start_}"
    
    name="\t${name%.sh}"
    
    echo -e "$name"
done

echo -e '\nTo run a model : start_MODEL_NAME.sh'