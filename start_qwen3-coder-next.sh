#!/bin/bash
HOST="${MODEL_HOST:-127.0.0.1}" 
~/Apps/llama.cpp/build/bin/llama-server -m ~/models/Qwen-3-Coder-Next/Qwen3-Coder-Next-UD-Q4_K_XL.gguf \
    -ngl 99 \
    -fa on \
    --port 8000 \
    --n-cpu-moe 20 \
    --host "$HOST" \
    --ctx-size 131072 \
    --alias "unsloth/Qwen3-Coder-Next" \
    --temp 1.0 \
    --top-p 0.95 \
    --min-p 0.01 \
    --context-shift \
    --top-k 40 \
    --cache-type-k q8_0 \
    --cache-type-v q8_0 \
    --no-mmap \
    --threads 16 \
    --jinja \
    --threads-batch 16 \
    --parallel 1 