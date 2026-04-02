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
HOST="${MODEL_HOST:-127.0.0.1}" 
MODEL_PORT="${MODEL_PORT:-8000}"
~/Apps/llama.cpp/build/bin/llama-server -m ~/models/GLM4.7flash/GLM-4.7-Flash-UD-Q4_K_XL.gguf \
    --jinja \
    -ngl 99 \
    -fa on \
    --port "$MODEL_PORT" \
    --host "$HOST" \
    --ctx-size 131072 \
    --temp 1.0 \
    --top-p 0.95 \
    --repeat-penalty 1.0 \
    --min-p 0.01 \
    --cache-type-k q8_0 \
    --cache-type-v q8_0 \
    --context-shift \
