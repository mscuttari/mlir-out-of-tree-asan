#ifndef MYPROJECT_DIALECT_MYDIALECT_IR_MYDIALECT_TD
#define MYPROJECT_DIALECT_MYDIALECT_IR_MYDIALECT_TD

include "mlir/IR/OpBase.td"

def MyDialect_Dialect : Dialect
{
    let name = "mydialect";
    let cppNamespace = "::mlir::mydialect";
}

#endif // MYPROJECT_DIALECT_MYDIALECT_IR_MYDIALECT_TD
