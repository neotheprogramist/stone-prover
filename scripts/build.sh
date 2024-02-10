#!/usr/bin/env bash

ENGINE=podman

$ENGINE build --tag prover . && \
container_id=$($ENGINE create prover) && \
$ENGINE cp ${container_id}:/bin/cpu_air_prover ./e2e_test/cpu_air_prover.x && \
$ENGINE cp ${container_id}:/bin/cpu_air_verifier ./e2e_test/cpu_air_verifier.x
