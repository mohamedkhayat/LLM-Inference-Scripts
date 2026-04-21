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
~/Apps/llama.cpp/build/bin/llama-server -m ~/models/Qwen3.5-27B/Qwen3.5-27B-UD-Q4_K_XL.gguf \
    --mmproj ~/models/Qwen3.5-27B/mmproj-BF16.gguf \
    -ngl 99 \
    -fa on \
    --port "$MODEL_PORT" \
    --host "$HOST" \
    --context-shift \
    --ctx-size  262144 \
    --temp 0.7 \
    --top-p 0.8 \
    --top-k 20 \
    --min-p 0.00 \
    --cache-type-k q8_0 \
    --cache-type-v q8_0 \
    --jinja \
    --chat-template-kwargs "{\"enable_thinking\": false}"