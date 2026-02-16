#!/bin/bash

source ~/.venv/vllm/bin/activate

HOST="${MODEL_HOST:-127.0.0.1}" 

vllm serve Qwen/Qwen3-4B-Instruct-2507\
    --host "$HOST" \
    --max-model-len 16K \
    --gpu-memory-utilization 0.35 \
    --kv_cache_dtype "fp8" \
    --tool-call-parser hermes \
    --enable-auto-tool-choice \
    --port 8000