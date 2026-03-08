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
    --ubatch-size 4096 \
    --batch-size 4096 \
    --temp 0.6 \
    --top-p 0.95 \
    --top-k 20 \
    --min-p 0.05 \
    --jinja \
    --cache-type-k bf16 \
    --cache-type-v bf16 \
    --threads 16 \
    --parallel 1