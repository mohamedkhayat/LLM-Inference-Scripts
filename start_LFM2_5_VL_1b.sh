#!/bin/bash

source ~/.venv/vllm/bin/activate

HOST="${MODEL_HOST:-127.0.0.1}" 
MODEL_PORT="${MODEL_PORT:-8000}"

vllm serve LiquidAI/LFM2.5-VL-1.6B \
    --host "$HOST" \
    --max-model-len 32K \
    --gpu-memory-utilization 0.8 \
    --port "$MODEL_PORT"