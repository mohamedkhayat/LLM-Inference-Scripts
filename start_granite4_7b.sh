#!/bin/bash
HOST="${MODEL_HOST:-127.0.0.1}" 
~/Apps/llama.cpp/build-b7577/bin/llama-server -m ~/models/granite-4.0/granite-4.0-h-tiny-UD-Q8_K_XL.gguf \
    --jinja \
    --ctx-size 16384 \
    --n-gpu-layers 99 \
    --seed 3407 \
    --prio 2 \
    --temp 0.0 \
    --top-k 0 \
    --top-p 1.0 \
     -fa on \
     --port 8000 \
     --host "$HOST"