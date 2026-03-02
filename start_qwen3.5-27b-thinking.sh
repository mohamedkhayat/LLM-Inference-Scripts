#!/bin/bash
HOST="${MODEL_HOST:-127.0.0.1}" 
~/Apps/llama.cpp/build/bin/llama-server -m ~/models/qwen3.5-27b/Qwen3.5-27B-UD-Q6_K_XL.gguf \
    --mmproj ~/models/qwen3.5-27b/mmproj-BF16.gguf \
    -ngl 99 \
    -fa on \
    --port 8000 \
    --host "$HOST" \
    --ctx-size 262144 \
    --context-shift \
    --temp 0.6 \
    --top-p 0.95 \
    --top-k 20 \
    --min-p 0.05 \
    --jinja \
    --cache-type-k bf16 \
    --cache-type-v bf16