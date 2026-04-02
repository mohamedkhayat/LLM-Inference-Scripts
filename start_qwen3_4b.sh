#!/bin/bash
# Kill any lingering llama-server instances
pkill -f 'llama-server' 2>/dev/null || true
# Wait for VRAM to be released by previous model
while true; do
    free_mb=$(nvidia-smi --query-gpu=memory.free --format=csv,noheader,nounits | head -1)
    [ "$free_mb" -gt 20000 ] && break
    echo "Waiting for VRAM... ${free_mb}MB free"
    sleep 2
done

source ~/.venv/vllm/bin/activate

HOST="${MODEL_HOST:-127.0.0.1}" 
MODEL_PORT="${MODEL_PORT:-8000}"

vllm serve Qwen/Qwen3-4B-Instruct-2507\
    --host "$HOST" \
    --max-model-len 64K \
    --gpu-memory-utilization 0.8 \
    --tool-call-parser hermes \
    --enable-auto-tool-choice \
    --port "$MODEL_PORT"