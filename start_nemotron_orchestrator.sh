#!/bin/bash

source ~/.venv/vllm/bin/activate

HOST="${MODEL_HOST:-127.0.0.1}" 
MODEL_PATH="/home/mohamed/models/Nemotron-Orchestrator"
vllm serve "$MODEL_PATH" \
    --host "$HOST" \
    --max-model-len 64K \
    --gpu-memory-utilization 0.6 \
    --enable-auto-tool-choice \
    --tool-call-parser hermes \
    --reasoning-parser qwen3 \
    --kv_cache_dtype "fp8" \
    --max-num-seqs 128 \
    --served-model-name "Nemotron-Orchestrator-8B" \
    --chat-template "$MODEL_PATH/chat_template.jinja" \
    --port 8000