add_mlir_dialect_library(MLIRMyDialect
    MyDialect.cpp
    Types.cpp

    DEPENDS
    MLIRMyDialectIncGen

    LINK_COMPONENTS
    Core

    LINK_LIBS PUBLIC
    MLIRIR
    MLIRSupport
    MLIRCallInterfaces
    MLIRControlFlowInterfaces
    MLIRFunctionInterfaces
    MLIRSideEffectInterfaces)
