#!/bin/bash

source ~/.venv/vllm/bin/activate

HOST="${MODEL_HOST:-127.0.0.1}" 

vllm serve Qwen/Qwen3-VL-8B-Thinking-FP8 \
    --host "$HOST" \
    --limit-mm-per-prompt.video 0 \
    --async-scheduling \
    --max-num-seqs 128 \
    --max-model-len 128K \
    --gpu-memory-utilization 0.9 \
    --reasoning-parser qwen3 \
	--tool-call-parser qwen3_coder \
    --enable-auto-tool-choice \
    --port 8000 \
    --default-chat-template-kwargs '{
        "enable_thinking": true,
        "temperature": 1.0,
        "top_p": 0.95,
        "top_k": 20,
        "presence_penalty": 0.0
    }'
    #--kv_cache_dtype "fp8" \