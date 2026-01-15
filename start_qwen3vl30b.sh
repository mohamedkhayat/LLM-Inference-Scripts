#!/bin/bash

source ~/.venv/vllm/bin/activate

HOST="${MODEL_HOST:-127.0.0.1}" 
vllm serve cyankiwi/Qwen3-VL-30B-A3B-Thinking-AWQ-4bit \
    --host "$HOST" \
    --limit-mm-per-prompt.video 0 \
    --async-scheduling \
    --max-num-seqs 128 \
    --max-model-len 32K \
    --gpu-memory-utilization 0.9 \
    --reasoning-parser deepseek_r1 \
    --port 8000 \
