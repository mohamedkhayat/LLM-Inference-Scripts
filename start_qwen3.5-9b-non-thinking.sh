#!/bin/bash

source ~/.venv/vllm/bin/activate
HOST="${MODEL_HOST:-127.0.0.1}" 
MODEL_PORT="${MODEL_PORT:-8000}"

vllm serve Qwen/Qwen3.5-9B\
    --host "$HOST" \
    --max-model-len 120K \
    --gpu-memory-utilization 0.8 \
    --mm-encoder-tp-mode data \
    --mm-processor-cache-type shm \
    --reasoning-parser qwen3 \
    --enable-auto-tool-choice \
    --enable-prefix-caching \
    --tool-call-parser qwen3_coder \
    --port "$MODEL_PORT" \
    --default-chat-template-kwargs '{"enable_thinking": false}' \
    --max-num-seqs 4 \
    --override-generation-config '{
        "temperature": 0.7,
        "top_p": 0.8,
        "top_k": 20,
        "presence_penalty": 1.5,
        "repetition_penalty": 1.0,
        "enable_thinking": false
    }'
