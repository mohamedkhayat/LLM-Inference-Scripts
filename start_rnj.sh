#!/bin/bash

source ~/.venv/vllm/bin/activate

HOST="${MODEL_HOST:-127.0.0.1}" 

vllm serve cyankiwi/rnj-1-instruct-AWQ-4bit \
    --host "$HOST" \
    --max-model-len 64K \
    --gpu-memory-utilization 0.5 \
    --kv_cache_dtype "fp8" \
    --port 8000