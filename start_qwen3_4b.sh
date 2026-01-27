#!/bin/bash

source ~/.venv/vllm/bin/activate

HOST="${MODEL_HOST:-127.0.0.1}" 

vllm serve Qwen/Qwen3-4B-Instruct-2507\
    --host "$HOST" \
    --max-model-len 262144 \
    --gpu-memory-utilization 0.8 \
    --port 8000 