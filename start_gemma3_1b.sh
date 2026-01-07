#!/bin/bash
HOST="${MODEL_HOST:-127.0.0.1}" 
~/Apps/llama.cpp/build-b7577/bin/llama-server -m ~/models/Gemma3-1b/gemma-3-1b-it-BF16.gguf -ngl 99 -fa on --port 8000 --host "$HOST" --ctx-size 32000