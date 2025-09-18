set(LLVM_TARGET_DEFINITIONS MyDialectTypes.td)
mlir_tablegen(MyDialectTypes.h.inc -gen-typedef-decls -typedefs-dialect=mydialect)
mlir_tablegen(MyDialectTypes.cpp.inc -gen-typedef-defs -typedefs-dialect=mydialect)
add_public_tablegen_target(MLIRMyDialectTypesIncGen)

set(LLVM_TARGET_DEFINITIONS MyDialect.td)
mlir_tablegen(MyDialect.h.inc -gen-dialect-decls -dialect=mydialect)
mlir_tablegen(MyDialect.cpp.inc -gen-dialect-defs -dialect=mydialect)
add_public_tablegen_target(MLIRMyDialectIncGen)

add_dependencies(MLIRMyDialectIncGen MLIRMyDialectTypesIncGen)
