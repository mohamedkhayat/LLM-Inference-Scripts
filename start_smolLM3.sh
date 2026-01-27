#!/bin/bash
HOST="${MODEL_HOST:-127.0.0.1}" 
~/Apps/llama.cpp/build-b7577/bin/llama-server -m ~/models/smolLM3/SmolLM3-3B-128K-BF16.gguf --jinja -ngl 99 -fa on --port 8000 --host "$HOST" --ctx-size 128000