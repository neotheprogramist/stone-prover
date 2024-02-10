#!/usr/bin/env bash

source .venv/bin/activate && \
cairo-compile \
  e2e_test/main.cairo \
  --output e2e_test/main_compiled.json \
  --proof_mode && \
deactivate
