#!/bin/bash
HOST="${MODEL_HOST:-127.0.0.1}" 
~/Apps/llama.cpp/build/bin/llama-server -m ~/models/Qwen-3-Coder-Next/Qwen3-Coder-Next-UD-Q4_K_XL.gguf -ngl 28 -fa on --port 8000 --host "$HOST" --ctx-size 32768 --alias "unsloth/Qwen3-Coder-Next" \
    --temp 1.0 \
    --top-p 0.95 \
    --min-p 0.01 \
    --top-k 40 \
    --cache-type-k q4_0 \
    --cache-type-v q4_0