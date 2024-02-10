#!/usr/bin/env bash

cd e2e_test && \
./cpu_air_verifier.x --in_file=main_proof.json && \
echo "Successfully verified example proof." && \
cd ..
