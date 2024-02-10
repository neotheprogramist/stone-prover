#!/usr/bin/env bash

cd e2e_test && \
./cpu_air_prover.x \
  --out_file=main_proof.json \
  --private_input_file=main_private_input.json \
  --public_input_file=main_public_input.json \
  --prover_config_file=cpu_air_prover_config.json \
  --parameter_file=cpu_air_params.json \
  -generate_annotations && \
cd ..
