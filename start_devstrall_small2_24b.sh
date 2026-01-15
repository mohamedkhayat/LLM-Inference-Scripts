#!/bin/bash

source ~/.venv/vllm/bin/activate

HOST="${MODEL_HOST:-127.0.0.1}" 
vllm serve cyankiwi/Devstral-Small-2-24B-Instruct-2512-AWQ-4bit \
    --tool-call-parser mistral \
    --enable-auto-tool-choice \
    --max-model-len 32K \
    --gpu-memory-utilization 0.9 \
    --kv_cache_dtype "fp8" \
    --port 8000 \
    --host "$HOST" \
    --max-num-seqs 8 
