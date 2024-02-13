#!/usr/bin/env bash

source .venv/bin/activate && \
cd e2e_test && \
cairo-run \
    --program=main_compiled.json \
    --layout=recursive \
    --program_input=main_input.json \
    --air_public_input=main_public_input.json \
    --air_private_input=main_private_input.json \
    --trace_file=main_trace.bin \
    --memory_file=main_memory.bin \
    --print_output \
    --proof_mode && \
cd .. && \
deactivate
