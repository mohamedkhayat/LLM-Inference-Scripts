#!/bin/bash
pkill -f 'llama-server' 2>/dev/null || true
while true; do
    free_mb=$(nvidia-smi --query-gpu=memory.free --format=csv,noheader,nounits | head -1)
    [ "$free_mb" -gt 1000 ] && break
    echo "Waiting for VRAM... ${free_mb}MB free"
    sleep 2
done

HOST="${MODEL_HOST:-127.0.0.1}"
MODEL_PORT="${MODEL_PORT:-8000}"

~/Apps/llama.cpp/build/bin/llama-server \
    -m ~/models/Qwen3-Embedding/Qwen3-Embedding-0.6B-f16.gguf \
    -ngl 99 \
    --port "$MODEL_PORT" \
    --host "$HOST" \
    --embedding \
    --pooling last \
    -ub 8192 \
    --ctx-size 32768 \
    --threads 16 \
    --parallel 4