set(SOURCES
    my-opt.cpp)

add_llvm_executable(my-opt ${SOURCES})
llvm_update_compile_flags(my-opt)

get_property(dialect_libs GLOBAL PROPERTY MLIR_DIALECT_LIBS)
get_property(extension_libs GLOBAL PROPERTY MLIR_EXTENSION_LIBS)
get_property(conversion_libs GLOBAL PROPERTY MLIR_CONVERSION_LIBS)

set(LIBS
        ${dialect_libs}
        ${extension_libs}
        ${conversion_libs}
        MLIROptLib
        MLIRRegisterAllDialects
        MLIRRegisterAllExtensions
        MLIRRegisterAllPasses
        MLIRToLLVMIRTranslationRegistration)

target_link_libraries(my-opt PRIVATE ${LIBS})
mlir_check_all_link_libraries(my-opt)
