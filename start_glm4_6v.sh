#!/bin/bash
HOST="${MODEL_HOST:-127.0.0.1}" 
~/Apps/llama.cpp/build-b7577/bin/llama-server   -m ./models/GLM-4.6/GLM-4.6V-UD-IQ2_M.gguf   --mmproj ./models/GLM-4.6/mmproj-BF16.gguf -ngl 25 --n-predict 32768 --ctx-size 32768 --port 8000 --host "$HOST" --cache-type-k q8_0 --cache-type-k q8_0
