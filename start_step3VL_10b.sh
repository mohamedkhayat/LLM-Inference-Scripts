#!/bin/bash

source ~/.venv/vllm/bin/activate

HOST="${MODEL_HOST:-127.0.0.1}" 

vllm serve stepfun-ai/Step3-VL-10B-FP8 \
    --host "$HOST" \
    --max-model-len 64K \
    -tp 1 \
    --reasoning-parser deepseek_r1 \
    --enable-auto-tool-choice \
    --tool-call-parser hermes \
    --trust-remote-code \
    --gpu-memory-utilization 0.9 \
    --port 8000
  
