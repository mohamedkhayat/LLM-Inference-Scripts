#!/bin/bash

source ~/.venv/vllm/bin/activate

HOST="${MODEL_HOST:-127.0.0.1}" 

vllm serve cyankiwi/Qwen3-VL-8B-Instruct-AWQ-4bit \
    --host "$HOST" \
    --limit-mm-per-prompt.video 0 \
    --async-scheduling \
    --max-num-seqs 128 \
    --max-model-len 64K \
    --gpu-memory-utilization 0.9 \
    --kv_cache_dtype "fp8" \
    --port 8000