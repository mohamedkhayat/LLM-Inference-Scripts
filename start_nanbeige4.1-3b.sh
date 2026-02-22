#!/bin/bash
HOST="${MODEL_HOST:-127.0.0.1}" 
~/Apps/llama.cpp/build/bin/llama-server -m ~/models/Nanbeige/Nanbeige4.1-3B.gguf -ngl 99 -fa on --port 8000 --host "$HOST" --ctx-size 64000 --temp 0.6 --top-p 0.95 --repeat-penalty 1.0 -n 64000