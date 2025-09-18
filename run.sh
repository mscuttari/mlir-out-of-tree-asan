#!/bin/bash

docker build -t test-mlir-asan -f Dockerfile .docker
docker run --rm -v "$(pwd)":/workspace -w /workspace test-mlir-asan bash -c "mkdir -p build && cmake -G Ninja -B build -S . && cmake --build build && ./build/bin/my-opt test/test.mlir"
