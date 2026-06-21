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

~/Apps/llama.cpp/build/bin/llama-server -m ~/models/Gemma4-12B/gemma-4-12B-it-qat-UD-Q4_K_XL.gguf \
  --mmproj ~/models/Gemma4-12B/mmproj-BF16.gguf \
  --model-draft ~/models/Gemma4-12B/mtp-gemma-4-12B-it.gguf \
  -ngl 99 \
  -fa on \
  --port "$MODEL_PORT" \
  --host "$HOST" \
  --ctx-size 131072 \
  --spec-type draft-mtp --spec-draft-n-max 2 \
  --context-shift \
  --temp 1.0 \
  --top-p 0.95 \
  --top-k 64 \
  --min-p 0.00 \
  --jinja \
  --cache-type-k q8_0 \
  --cache-type-v q8_0 \
  --parallel 1 \
  --alias Gemma4-31b \
  --chat-template-kwargs '{"enable_thinking":false}'
