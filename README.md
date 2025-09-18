The project implements a minimal out-of-tree project to reproduce an apparently upstream ASAN bug.
The bug can be reproduced by running the `run.sh` script, which builds MLIR and the project in a Docker container, and then runs the `my-opt` tool on a simple MLIR file.
The project is built with ASAN enabled, while MLIR is not.
If the `MyType` type is removed from `MyDialect`, the ASAN error does not occur.
