#ifndef MYPROJECT_DIALECT_MYDIALECT_IR_MYDIALECTTYPES_TD
#define MYPROJECT_DIALECT_MYDIALECT_IR_MYDIALECTTYPES_TD

include "myproject/Dialect/MyDialect/IR/MyDialect.td"
include "mlir/IR/OpBase.td"

class MyDialect_Type<string name, string typeMnemonic>
    : TypeDef<MyDialect_Dialect, name>
{
    let mnemonic = typeMnemonic;
}

def MyType : MyDialect_Type<"MyType", "mytype">
{
}

#endif // MYPROJECT_DIALECT_MYDIALECT_IR_MYDIALECTTYPES_TD
