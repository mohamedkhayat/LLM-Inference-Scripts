#!/bin/bash
HOST="${MODEL_HOST:-127.0.0.1}" 
~/Apps/llama.cpp/build/bin/llama-server -m ~/models/Qwen3.5-35B-A3B/Qwen3.5-35B-A3B-UD-Q4_K_XL.gguf \
    --mmproj ~/models/Qwen3.5-35B-A3B/mmproj-BF16.gguf \
    -ngl 99 \
    -fa on \
    --port 8000 \
    --host "$HOST" \
    --ctx-size 131072 \
    --context-shift \
    --batch-size 2048 \
    --ubatch-size 512 \
    --temp 0.6 \
    --top-p 0.95 \
    --top-k 20 \
    --min-p 0.05 \
    --jinja \
    --cache-type-k q8_0 \
    --cache-type-v q8_0