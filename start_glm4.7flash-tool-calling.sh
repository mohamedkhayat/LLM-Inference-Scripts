#!/bin/bash
HOST="${MODEL_HOST:-127.0.0.1}" 
~/Apps/llama.cpp/build/bin/llama-server -m ~/models/GLM4.7flash/GLM-4.7-Flash-UD-Q4_K_XL.gguf \
    --jinja \
    -ngl 99 \
    -fa on \
    --port 8000 \
    --host "$HOST" \
    --ctx-size 262144 \
    --temp 0.7 \
    --top-p 1.0 \
    --repeat-penalty 1.0 \
    --min-p 0.01 \
    --cache-type-k q8_0 \
    --cache-type-v q8_0 \
    --context-shift \
    --batch-size 2048 \
    --ubatch-size 1024 \
    --threads 16 \
    --parallel 1