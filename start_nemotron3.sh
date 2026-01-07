#!/bin/bash
HOST="${MODEL_HOST:-127.0.0.1}" 
~/Apps/llama.cpp/build-b7577/bin/llama-server -m ~/models/Nemotron-3-Nano-30b/Nemotron-3-Nano-30B-A3B-Q4_K_M.gguf -ngl 99 -fa on --port 8000 --host "$HOST" --n-predict 32768 --cache-type-k q8_0 --cache-type-k q8_0