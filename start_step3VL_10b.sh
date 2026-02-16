#!/bin/bash

source ~/.venv/vllm/bin/activate

HOST="${MODEL_HOST:-127.0.0.1}" 

vllm serve cyankiwi/Step3-VL-10B-AWQ-8bit \
    --host "$HOST" \
    --max-model-len 32K \
    -tp 1 \
    --reasoning-parser deepseek_r1 \
    --enable-auto-tool-choice \
    --tool-call-parser hermes \
    --trust-remote-code \
    --gpu-memory-utilization 0.9 \
    --port 8000
  
