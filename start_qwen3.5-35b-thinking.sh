#!/bin/bash
HOST="${MODEL_HOST:-127.0.0.1}" 
MODEL_PORT="${MODEL_PORT:-8000}"
~/Apps/llama.cpp/build/bin/llama-server -m ~/models/Qwen3.5-35B-A3B/Qwen3.5-35B-A3B-UD-Q4_K_XL.gguf \
    --mmproj ~/models/Qwen3.5-35B-A3B/mmproj-BF16.gguf \
    -ngl 99 \
    -fa on \
    --port "$MODEL_PORT" \
    --host "$HOST" \
    --ctx-size 131072 \
    --context-shift \
    --ubatch-size 4096 \
    --batch-size 4096 \
    --temp 0.6 \
    --top-p 0.95 \
    --top-k 20 \
    --min-p 0.05 \
    --jinja \
    --cache-type-k q8_0 \
    --cache-type-v q8_0 \
    --threads 16 \
    --parallel 1