#!/bin/bash
HOST="${MODEL_HOST:-127.0.0.1}" 
MODEL_PORT="${MODEL_PORT:-8000}"
~/Apps/llama.cpp/build/bin/llama-server -m ~/models/Nanbeige/Nanbeige4.1-3B.gguf -ngl 99 -fa on --port "$MODEL_PORT" --host "$HOST" --ctx-size 64000 --temp 0.6 --top-p 0.95 --repeat-penalty 1.0 -n 64000